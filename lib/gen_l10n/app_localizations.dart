import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Aidea Technology'**
  String get appTitle;

  /// No description provided for @homeServices.
  ///
  /// In en, this message translates to:
  /// **'Home Services'**
  String get homeServices;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @whatIsYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'What is your mobile number?'**
  String get whatIsYourMobileNumber;

  /// No description provided for @enterMobileNumberToSendCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number to send you the activation code'**
  String get enterMobileNumberToSendCode;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @pleaseEnterCompleteOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter complete OTP'**
  String get pleaseEnterCompleteOtp;

  /// No description provided for @otpSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully!'**
  String get otpSentSuccessfully;

  /// No description provided for @enterCodeSentToYou.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to you'**
  String get enterCodeSentToYou;

  /// No description provided for @confirmationCodeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Confirmation code has been sent to'**
  String get confirmationCodeSentTo;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didntReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @streetName.
  ///
  /// In en, this message translates to:
  /// **'Street Name'**
  String get streetName;

  /// No description provided for @pleaseEnterStreetName.
  ///
  /// In en, this message translates to:
  /// **'Please enter street name'**
  String get pleaseEnterStreetName;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

  /// No description provided for @floorNumber.
  ///
  /// In en, this message translates to:
  /// **'Floor number'**
  String get floorNumber;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartment;

  /// No description provided for @apartmentNumber.
  ///
  /// In en, this message translates to:
  /// **'Apartment number'**
  String get apartmentNumber;

  /// No description provided for @otherInformation.
  ///
  /// In en, this message translates to:
  /// **'Other information'**
  String get otherInformation;

  /// No description provided for @saveAddressAsPrimary.
  ///
  /// In en, this message translates to:
  /// **'Save address as primary'**
  String get saveAddressAsPrimary;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @friend.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get friend;

  /// No description provided for @saveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get saveAndContinue;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @ourServices.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get ourServices;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'services'**
  String get services;

  /// No description provided for @viewAllServices.
  ///
  /// In en, this message translates to:
  /// **'View all services'**
  String get viewAllServices;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @noActiveOrders.
  ///
  /// In en, this message translates to:
  /// **'No Active Orders'**
  String get noActiveOrders;

  /// No description provided for @bookYourFirstServiceToday.
  ///
  /// In en, this message translates to:
  /// **'Book your first service today!'**
  String get bookYourFirstServiceToday;

  /// No description provided for @noPreviousOrders.
  ///
  /// In en, this message translates to:
  /// **'No Previous Orders'**
  String get noPreviousOrders;

  /// No description provided for @yourCompletedOrdersWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your completed orders will appear here'**
  String get yourCompletedOrdersWillAppearHere;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @servicesBooked.
  ///
  /// In en, this message translates to:
  /// **'Services Booked'**
  String get servicesBooked;

  /// No description provided for @serviceBooked.
  ///
  /// In en, this message translates to:
  /// **'Service Booked'**
  String get serviceBooked;

  /// No description provided for @bookingDone.
  ///
  /// In en, this message translates to:
  /// **'Booking Done'**
  String get bookingDone;

  /// No description provided for @technicianAssigned.
  ///
  /// In en, this message translates to:
  /// **'Technician Assigned'**
  String get technicianAssigned;

  /// No description provided for @workStarted.
  ///
  /// In en, this message translates to:
  /// **'Work Started'**
  String get workStarted;

  /// No description provided for @workDone.
  ///
  /// In en, this message translates to:
  /// **'Work Done'**
  String get workDone;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @trackOrder.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get trackOrder;

  /// No description provided for @viewTechnicianDetails.
  ///
  /// In en, this message translates to:
  /// **'View Technician Details'**
  String get viewTechnicianDetails;

  /// No description provided for @invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// No description provided for @noInvoicesYet.
  ///
  /// In en, this message translates to:
  /// **'No Invoices Yet'**
  String get noInvoicesYet;

  /// No description provided for @completeServiceToGenerateInvoices.
  ///
  /// In en, this message translates to:
  /// **'Complete a service to generate invoices'**
  String get completeServiceToGenerateInvoices;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @invoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice #'**
  String get invoiceNumber;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'PAID'**
  String get paid;

  /// No description provided for @downloadShareInvoice.
  ///
  /// In en, this message translates to:
  /// **'Download / Share Invoice'**
  String get downloadShareInvoice;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @myReviews.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get myReviews;

  /// No description provided for @toReview.
  ///
  /// In en, this message translates to:
  /// **'To Review'**
  String get toReview;

  /// No description provided for @noServicesToReview.
  ///
  /// In en, this message translates to:
  /// **'No Services to Review'**
  String get noServicesToReview;

  /// No description provided for @completeServicesToLeaveReviews.
  ///
  /// In en, this message translates to:
  /// **'Complete services to leave reviews'**
  String get completeServicesToLeaveReviews;

  /// No description provided for @completedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed on'**
  String get completedOn;

  /// No description provided for @writeAReview.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeAReview;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No Reviews Yet'**
  String get noReviewsYet;

  /// No description provided for @yourReviewsWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your reviews will appear here'**
  String get yourReviewsWillAppearHere;

  /// No description provided for @rateYourExperience.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Experience'**
  String get rateYourExperience;

  /// No description provided for @tapToRate.
  ///
  /// In en, this message translates to:
  /// **'Tap to rate'**
  String get tapToRate;

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent!'**
  String get excellent;

  /// No description provided for @veryGood.
  ///
  /// In en, this message translates to:
  /// **'Very Good!'**
  String get veryGood;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @fair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get fair;

  /// No description provided for @poor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get poor;

  /// No description provided for @shareYourExperience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience (optional)...'**
  String get shareYourExperience;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @thankYouForYourReview.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your review!'**
  String get thankYouForYourReview;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @manageNotificationPreferences.
  ///
  /// In en, this message translates to:
  /// **'Manage notification preferences'**
  String get manageNotificationPreferences;

  /// No description provided for @savedAddresses.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get savedAddresses;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @managePaymentOptions.
  ///
  /// In en, this message translates to:
  /// **'Manage payment options'**
  String get managePaymentOptions;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @getHelpAndContactUs.
  ///
  /// In en, this message translates to:
  /// **'Get help and contact us'**
  String get getHelpAndContactUs;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appVersionAndInformation.
  ///
  /// In en, this message translates to:
  /// **'App version and information'**
  String get appVersionAndInformation;

  /// No description provided for @areYouSureYouWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureYouWantToLogout;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @yourCartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// No description provided for @addSomeServicesToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Add some services to get started'**
  String get addSomeServicesToGetStarted;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @areYouSureYouWantToRemoveAllItems.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all items?'**
  String get areYouSureYouWantToRemoveAllItems;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// No description provided for @bookService.
  ///
  /// In en, this message translates to:
  /// **'Book Service'**
  String get bookService;

  /// No description provided for @selectedServices.
  ///
  /// In en, this message translates to:
  /// **'Selected Services'**
  String get selectedServices;

  /// No description provided for @uploadApplianceImages.
  ///
  /// In en, this message translates to:
  /// **'Upload Appliance Images'**
  String get uploadApplianceImages;

  /// No description provided for @addPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add Photos'**
  String get addPhotos;

  /// No description provided for @uploadPhotosOfYourAppliance.
  ///
  /// In en, this message translates to:
  /// **'Upload photos of your appliance'**
  String get uploadPhotosOfYourAppliance;

  /// No description provided for @imagesSelected.
  ///
  /// In en, this message translates to:
  /// **'images selected'**
  String get imagesSelected;

  /// No description provided for @imageSelected.
  ///
  /// In en, this message translates to:
  /// **'image selected'**
  String get imageSelected;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @chooseImageSource.
  ///
  /// In en, this message translates to:
  /// **'Choose Image Source'**
  String get chooseImageSource;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @chooseADate.
  ///
  /// In en, this message translates to:
  /// **'Choose a date'**
  String get chooseADate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @chooseATime.
  ///
  /// In en, this message translates to:
  /// **'Choose a time'**
  String get chooseATime;

  /// No description provided for @serviceAddress.
  ///
  /// In en, this message translates to:
  /// **'Service Address'**
  String get serviceAddress;

  /// No description provided for @enterServiceAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter service address'**
  String get enterServiceAddress;

  /// No description provided for @additionalNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes (Optional)'**
  String get additionalNotesOptional;

  /// No description provided for @anySpecialRequestsOrNotes.
  ///
  /// In en, this message translates to:
  /// **'Any special requests or notes...'**
  String get anySpecialRequestsOrNotes;

  /// No description provided for @requestSummary.
  ///
  /// In en, this message translates to:
  /// **'Request Summary'**
  String get requestSummary;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @noImages.
  ///
  /// In en, this message translates to:
  /// **'No images'**
  String get noImages;

  /// No description provided for @estimatedPrice.
  ///
  /// In en, this message translates to:
  /// **'Estimated Price'**
  String get estimatedPrice;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @pleaseSelectBothDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Please select both date and time'**
  String get pleaseSelectBothDateAndTime;

  /// No description provided for @pleaseEnterYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your address'**
  String get pleaseEnterYourAddress;

  /// No description provided for @bookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed!'**
  String get bookingConfirmed;

  /// No description provided for @yourServiceHasBeenSuccessfullyBooked.
  ///
  /// In en, this message translates to:
  /// **'Your service has been successfully booked'**
  String get yourServiceHasBeenSuccessfullyBooked;

  /// No description provided for @yourServicesHaveBeenSuccessfullyBooked.
  ///
  /// In en, this message translates to:
  /// **'Your {count} services have been successfully booked'**
  String yourServicesHaveBeenSuccessfullyBooked(int count);

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @whatsNext.
  ///
  /// In en, this message translates to:
  /// **'What\'s Next?'**
  String get whatsNext;

  /// No description provided for @youWillReceiveConfirmationEmailShortly.
  ///
  /// In en, this message translates to:
  /// **'You will receive a confirmation email shortly'**
  String get youWillReceiveConfirmationEmailShortly;

  /// No description provided for @reminderWillBeSent24HoursBefore.
  ///
  /// In en, this message translates to:
  /// **'A reminder will be sent 24 hours before'**
  String get reminderWillBeSent24HoursBefore;

  /// No description provided for @viewYourBookingsInOrdersSection.
  ///
  /// In en, this message translates to:
  /// **'View your bookings in the Orders section'**
  String get viewYourBookingsInOrdersSection;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @viewBookings.
  ///
  /// In en, this message translates to:
  /// **'View Bookings'**
  String get viewBookings;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get orderNumber;

  /// No description provided for @servicesList.
  ///
  /// In en, this message translates to:
  /// **'Services List'**
  String get servicesList;

  /// No description provided for @bookingDate.
  ///
  /// In en, this message translates to:
  /// **'Booking Date'**
  String get bookingDate;

  /// No description provided for @serviceTime.
  ///
  /// In en, this message translates to:
  /// **'Service Time'**
  String get serviceTime;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @bookingReceived.
  ///
  /// In en, this message translates to:
  /// **'Booking\nReceived'**
  String get bookingReceived;

  /// No description provided for @simulateAssignTechnician.
  ///
  /// In en, this message translates to:
  /// **'Simulate: Assign Technician'**
  String get simulateAssignTechnician;

  /// No description provided for @simulateStartWork.
  ///
  /// In en, this message translates to:
  /// **'Simulate: Start Work'**
  String get simulateStartWork;

  /// No description provided for @simulateCompleteWork.
  ///
  /// In en, this message translates to:
  /// **'Simulate: Complete Work'**
  String get simulateCompleteWork;

  /// No description provided for @technician.
  ///
  /// In en, this message translates to:
  /// **'Technician'**
  String get technician;

  /// No description provided for @ordersDone.
  ///
  /// In en, this message translates to:
  /// **'Orders Done'**
  String get ordersDone;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @facedAnyEmergency.
  ///
  /// In en, this message translates to:
  /// **'Faced any emergency?'**
  String get facedAnyEmergency;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @pleaseSelectReasonForCancellation.
  ///
  /// In en, this message translates to:
  /// **'Please select a reason for cancellation'**
  String get pleaseSelectReasonForCancellation;

  /// No description provided for @changeOfPlans.
  ///
  /// In en, this message translates to:
  /// **'Change of plans'**
  String get changeOfPlans;

  /// No description provided for @foundBetterService.
  ///
  /// In en, this message translates to:
  /// **'Found better service'**
  String get foundBetterService;

  /// No description provided for @incorrectBookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Incorrect booking details'**
  String get incorrectBookingDetails;

  /// No description provided for @emergencySituation.
  ///
  /// In en, this message translates to:
  /// **'Emergency situation'**
  String get emergencySituation;

  /// No description provided for @priceTooHigh.
  ///
  /// In en, this message translates to:
  /// **'Price too high'**
  String get priceTooHigh;

  /// No description provided for @technicianNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Technician not available'**
  String get technicianNotAvailable;

  /// No description provided for @serviceNoLongerNeeded.
  ///
  /// In en, this message translates to:
  /// **'Service no longer needed'**
  String get serviceNoLongerNeeded;

  /// No description provided for @otherReason.
  ///
  /// In en, this message translates to:
  /// **'Other reason'**
  String get otherReason;

  /// No description provided for @cancellationMayIncurCharges.
  ///
  /// In en, this message translates to:
  /// **'Cancellation may incur charges'**
  String get cancellationMayIncurCharges;

  /// No description provided for @keepBooking.
  ///
  /// In en, this message translates to:
  /// **'Keep Booking'**
  String get keepBooking;

  /// No description provided for @bookingCancelled.
  ///
  /// In en, this message translates to:
  /// **'Booking Cancelled'**
  String get bookingCancelled;

  /// No description provided for @yourBookingHasBeenCancelledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your booking has been cancelled successfully'**
  String get yourBookingHasBeenCancelledSuccessfully;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @vendorProfile.
  ///
  /// In en, this message translates to:
  /// **'Vendor Profile'**
  String get vendorProfile;

  /// No description provided for @professionalTechnician.
  ///
  /// In en, this message translates to:
  /// **'Professional Technician'**
  String get professionalTechnician;

  /// No description provided for @timePeriod.
  ///
  /// In en, this message translates to:
  /// **'Time Period'**
  String get timePeriod;

  /// No description provided for @profileVerified.
  ///
  /// In en, this message translates to:
  /// **'Profile Verified'**
  String get profileVerified;

  /// No description provided for @policeVerified.
  ///
  /// In en, this message translates to:
  /// **'Police Verified'**
  String get policeVerified;

  /// No description provided for @servicesProvide.
  ///
  /// In en, this message translates to:
  /// **'Services Provide'**
  String get servicesProvide;

  /// No description provided for @orderDone.
  ///
  /// In en, this message translates to:
  /// **'Order Done'**
  String get orderDone;

  /// No description provided for @typeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeAMessage;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @startConversationWith.
  ///
  /// In en, this message translates to:
  /// **'Start a conversation with {name}'**
  String startConversationWith(String name);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @callingTechnician.
  ///
  /// In en, this message translates to:
  /// **'Calling technician...'**
  String get callingTechnician;

  /// No description provided for @helloIWillBeArrivingIn30Minutes.
  ///
  /// In en, this message translates to:
  /// **'Hello! I will be arriving in 30 minutes. Please keep the service area ready.'**
  String get helloIWillBeArrivingIn30Minutes;

  /// No description provided for @okayNotedThankYou.
  ///
  /// In en, this message translates to:
  /// **'Okay, noted. Thank you!'**
  String get okayNotedThankYou;

  /// No description provided for @mAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String mAgo(int minutes);

  /// No description provided for @hAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String hAgo(int hours);

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @getRealTimeUpdatesAboutYourBookings.
  ///
  /// In en, this message translates to:
  /// **'Get real-time updates about your bookings, technician assignments, and service completion.'**
  String get getRealTimeUpdatesAboutYourBookings;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @notificationsEnabledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled successfully!'**
  String get notificationsEnabledSuccessfully;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get noNotifications;

  /// No description provided for @youreAllCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get youreAllCaughtUp;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @clearAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Clear All Notifications'**
  String get clearAllNotifications;

  /// No description provided for @areYouSureYouWantToClearAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all notifications? This action cannot be undone.'**
  String get areYouSureYouWantToClearAllNotifications;

  /// No description provided for @newNotifications.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newNotifications;

  /// No description provided for @youHaveUnreadNotifications.
  ///
  /// In en, this message translates to:
  /// **'You have {count} unread notification(s)'**
  String youHaveUnreadNotifications(int count);

  /// No description provided for @notificationDeleted.
  ///
  /// In en, this message translates to:
  /// **'Notification deleted'**
  String get notificationDeleted;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @serviceDetail.
  ///
  /// In en, this message translates to:
  /// **'Service Detail'**
  String get serviceDetail;

  /// No description provided for @whatsIncluded.
  ///
  /// In en, this message translates to:
  /// **'What\'s Included'**
  String get whatsIncluded;

  /// No description provided for @notIncluded.
  ///
  /// In en, this message translates to:
  /// **'Not Included'**
  String get notIncluded;

  /// No description provided for @anyTypeOfRepair.
  ///
  /// In en, this message translates to:
  /// **'Any type of repair'**
  String get anyTypeOfRepair;

  /// No description provided for @anyTypeOfMaterial.
  ///
  /// In en, this message translates to:
  /// **'Any type of material'**
  String get anyTypeOfMaterial;

  /// No description provided for @ladder.
  ///
  /// In en, this message translates to:
  /// **'Ladder'**
  String get ladder;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @addedToCartSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Added {serviceName} to cart successfully!'**
  String addedToCartSuccessfully(String serviceName);

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'View Cart'**
  String get viewCart;

  /// No description provided for @searchServices.
  ///
  /// In en, this message translates to:
  /// **'Search services...'**
  String get searchServices;

  /// No description provided for @noServicesFound.
  ///
  /// In en, this message translates to:
  /// **'No services found'**
  String get noServicesFound;

  /// No description provided for @tryAdjustingYourSearchTerms.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search terms'**
  String get tryAdjustingYourSearchTerms;

  /// No description provided for @chooseMachineType.
  ///
  /// In en, this message translates to:
  /// **'Choose machine type'**
  String get chooseMachineType;

  /// No description provided for @viewServicesForMachines.
  ///
  /// In en, this message translates to:
  /// **'View services for {type} machines'**
  String viewServicesForMachines(String type);

  /// No description provided for @washingMachine.
  ///
  /// In en, this message translates to:
  /// **'Washing Machine'**
  String get washingMachine;

  /// No description provided for @continueToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Continue to Checkout'**
  String get continueToCheckout;

  /// No description provided for @homeAddress.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get homeAddress;

  /// No description provided for @editing.
  ///
  /// In en, this message translates to:
  /// **'Editing'**
  String get editing;

  /// No description provided for @enterYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get enterYourAddress;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addressUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address updated successfully!'**
  String get addressUpdatedSuccessfully;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @addNewAddressFeatureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Add new address feature coming soon!'**
  String get addNewAddressFeatureComingSoon;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @pleaseEnterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterYourPhoneNumber;

  /// No description provided for @phoneNumberMustContainOnlyDigits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must contain only digits'**
  String get phoneNumberMustContainOnlyDigits;

  /// No description provided for @serviceExpertise.
  ///
  /// In en, this message translates to:
  /// **'Service Expertise'**
  String get serviceExpertise;

  /// No description provided for @previouslyCompletedServicesBy.
  ///
  /// In en, this message translates to:
  /// **'Previously completed services by {name}'**
  String previouslyCompletedServicesBy(String name);

  /// No description provided for @doneCount.
  ///
  /// In en, this message translates to:
  /// **'done'**
  String get doneCount;

  /// No description provided for @kmAway.
  ///
  /// In en, this message translates to:
  /// **'km away'**
  String get kmAway;

  /// No description provided for @serviceLocation.
  ///
  /// In en, this message translates to:
  /// **'Service Location'**
  String get serviceLocation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
