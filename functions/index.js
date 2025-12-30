const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/**
 * Triggered when a new document is created in the 'notifications' subcollection
 * of a user in the 'customers' collection.
 */
exports.sendNotificationOnCreate = functions.firestore
  .document("customers/{userId}/notifications/{notificationId}")
  .onCreate(async (snapshot, context) => {
    const notificationData = snapshot.data();
    const userId = context.params.userId;

    console.log(`New notification for user ${userId}`);

    try {
      // 1. Get the user's document to retrieve the FCM token
      const userDoc = await admin.firestore()
        .collection("customers")
        .doc(userId)
        .get();

      if (!userDoc.exists) {
        console.log(`User document ${userId} not found`);
        return null;
      }

      const userData = userDoc.data();
      const fcmToken = userData.fcmToken;

      if (!fcmToken) {
        console.log(`No FCM token found for user ${userId}`);
        return null;
      }

      // 2. Construct the FCM message
      const message = {
        token: fcmToken,
        notification: {
          title: notificationData.title || "New Notification",
          body: notificationData.message || notificationData.body || "",
        },
        data: {
          bookingId: notificationData.bookingId || "",
          type: notificationData.type || "general",
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        },
      };

      // 3. Send the message
      const response = await admin.messaging().send(message);
      console.log("Successfully sent message:", response);
      return { success: true, messageId: response };
    } catch (error) {
      console.error("Error sending notification:", error);
      return { success: false, error: error.message };
    }

    /**
     * Triggered when a new service request is created.
     * Sends a notification to the 'admin_notifications' topic.
     */
    exports.notifyAdminOnNewBooking = functions.firestore
      .document("service_requests/{bookingId}")
      .onCreate(async (snapshot, context) => {
        const bookingData = snapshot.data();
        const bookingId = context.params.bookingId;

        console.log(`New booking created: ${bookingId}`);

        const message = {
          topic: "admin_notifications",
          notification: {
            title: "New Booking Received 🆕",
            body: `New request from ${bookingData.customerName || "Customer"}: ${bookingData.serviceName || "Service"}`,
          },
          data: {
            bookingId: bookingId,
            type: "new_booking",
            click_action: "FLUTTER_NOTIFICATION_CLICK",
          },
        };

        try {
          const response = await admin.messaging().send(message);
          console.log("Successfully sent admin notification:", response);
          return { success: true, messageId: response };
        } catch (error) {
          console.error("Error sending admin notification:", error);
          return { success: false, error: error.message };
        }
      });

    /**
     * Triggered when a service request is updated.
     * Notifies the customer about status changes (Reassigned, Rescheduled, Resumed).
     */
    exports.notifyCustomerOnBookingUpdate = functions.firestore
      .document("service_requests/{bookingId}")
      .onUpdate(async (change, context) => {
        const newData = change.after.data();
        const oldData = change.before.data();
        const bookingId = context.params.bookingId;
        const customerId = newData.customerId;

        if (!customerId) return null;

        const notificationsRef = admin.firestore()
          .collection("customers")
          .doc(customerId)
          .collection("notifications");

        // 1. Check for Reassignment (Worker Changed)
        if (newData.workerId && newData.workerId !== oldData.workerId) {
          await notificationsRef.add({
            title: "Technician Reassigned 👷",
            message: `A new technician has been assigned to your service: ${newData.serviceName || "Service"}`,
            body: `A new technician has been assigned to your service: ${newData.serviceName || "Service"}`, // For consistent reading
            type: "reassigned",
            bookingId: bookingId,
            read: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          console.log(`Notification sent for Reassignment: ${bookingId}`);
        }

        // 2. Check for Reschedule (Date or Time Changed)
        // Ensure strictly different and not just format differences causing issues
        const dateChanged = newData.requestedDate && oldData.requestedDate && newData.requestedDate !== oldData.requestedDate;
        const timeChanged = newData.requestedTime && oldData.requestedTime && newData.requestedTime !== oldData.requestedTime;

        if (dateChanged || timeChanged) {
          await notificationsRef.add({
            title: "Service Rescheduled 📅",
            message: `Your service has been rescheduled to ${newData.requestedDate.split('T')[0]} at ${newData.requestedTime}`,
            body: `Your service has been rescheduled to ${newData.requestedDate.split('T')[0]} at ${newData.requestedTime}`,
            type: "rescheduled",
            bookingId: bookingId,
            read: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          console.log(`Notification sent for Reschedule: ${bookingId}`);
        }

        // 3. Check for Resume (Postponed -> InProgress)
        if (oldData.status === "postponed" && newData.status === "inProgress") {
          await notificationsRef.add({
            title: "Service Resumed ▶️",
            message: `Your service ${newData.serviceName || ""} has been resumed.`,
            body: `Your service ${newData.serviceName || ""} has been resumed.`,
            type: "resumed",
            bookingId: bookingId,
            read: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          console.log(`Notification sent for Resume: ${bookingId}`);
        }

        return null;
      });
