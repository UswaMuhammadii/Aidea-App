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
  /// **'Your service has been successfully booked'**
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
  /// **'Booking Received'**
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
  /// **'Please select reason for cancellation'**
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
  /// **'Get real-time updates about your bookings'**
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
  /// **'You have \$COUNT\$ unread notifications'**
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
  /// **'{serviceName} added to cart successfully!'**
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
  /// **'Choose your machine type'**
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

  /// No description provided for @acServices.
  ///
  /// In en, this message translates to:
  /// **'AC Services'**
  String get acServices;

  /// No description provided for @homeAppliances.
  ///
  /// In en, this message translates to:
  /// **'Home Appliances'**
  String get homeAppliances;

  /// No description provided for @plumbing.
  ///
  /// In en, this message translates to:
  /// **'Plumbing'**
  String get plumbing;

  /// No description provided for @electric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get electric;

  /// No description provided for @splitAc.
  ///
  /// In en, this message translates to:
  /// **'Split AC'**
  String get splitAc;

  /// No description provided for @windowAc.
  ///
  /// In en, this message translates to:
  /// **'Window AC'**
  String get windowAc;

  /// No description provided for @centralAc.
  ///
  /// In en, this message translates to:
  /// **'Central AC'**
  String get centralAc;

  /// No description provided for @refrigerator.
  ///
  /// In en, this message translates to:
  /// **'Refrigerator'**
  String get refrigerator;

  /// No description provided for @oven.
  ///
  /// In en, this message translates to:
  /// **'Oven'**
  String get oven;

  /// No description provided for @stove.
  ///
  /// In en, this message translates to:
  /// **'Stove'**
  String get stove;

  /// No description provided for @dishwasher.
  ///
  /// In en, this message translates to:
  /// **'Dishwasher'**
  String get dishwasher;

  /// No description provided for @automatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get automatic;

  /// No description provided for @regular.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get regular;

  /// No description provided for @semiAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Semi-Automatic'**
  String get semiAutomatic;

  /// No description provided for @topLoad.
  ///
  /// In en, this message translates to:
  /// **'Top Load'**
  String get topLoad;

  /// No description provided for @frontLoad.
  ///
  /// In en, this message translates to:
  /// **'Front Load'**
  String get frontLoad;

  /// No description provided for @pipeRepair.
  ///
  /// In en, this message translates to:
  /// **'Pipe Repair'**
  String get pipeRepair;

  /// No description provided for @drainCleaning.
  ///
  /// In en, this message translates to:
  /// **'Drain Cleaning'**
  String get drainCleaning;

  /// No description provided for @waterHeater.
  ///
  /// In en, this message translates to:
  /// **'Water Heater'**
  String get waterHeater;

  /// No description provided for @faucetInstallation.
  ///
  /// In en, this message translates to:
  /// **'Faucet Installation'**
  String get faucetInstallation;

  /// No description provided for @wiring.
  ///
  /// In en, this message translates to:
  /// **'Wiring'**
  String get wiring;

  /// No description provided for @switchSocket.
  ///
  /// In en, this message translates to:
  /// **'Switch & Socket'**
  String get switchSocket;

  /// No description provided for @circuitBreaker.
  ///
  /// In en, this message translates to:
  /// **'Circuit Breaker'**
  String get circuitBreaker;

  /// No description provided for @lightingInstallation.
  ///
  /// In en, this message translates to:
  /// **'Lighting Installation'**
  String get lightingInstallation;

  /// No description provided for @serviceManagement.
  ///
  /// In en, this message translates to:
  /// **'Service Management'**
  String get serviceManagement;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @subcategories.
  ///
  /// In en, this message translates to:
  /// **'Subcategories'**
  String get subcategories;

  /// No description provided for @servicesCount.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ Services'**
  String servicesCount(int count);

  /// No description provided for @acWashing.
  ///
  /// In en, this message translates to:
  /// **'AC Washing (Cleaning indoor and outdoor unit)'**
  String get acWashing;

  /// No description provided for @repairingLeaks.
  ///
  /// In en, this message translates to:
  /// **'Repairing leaks'**
  String get repairingLeaks;

  /// No description provided for @cleaningWithFreon.
  ///
  /// In en, this message translates to:
  /// **'Cleaning all units + Freon filling'**
  String get cleaningWithFreon;

  /// No description provided for @installNewAc.
  ///
  /// In en, this message translates to:
  /// **'New AC installation'**
  String get installNewAc;

  /// No description provided for @disassembleInside.
  ///
  /// In en, this message translates to:
  /// **'Disassembly and assembly (inside the house)'**
  String get disassembleInside;

  /// No description provided for @disassembleOutside.
  ///
  /// In en, this message translates to:
  /// **'Disassembly and assembly (outside the house)'**
  String get disassembleOutside;

  /// No description provided for @electronicBoardService.
  ///
  /// In en, this message translates to:
  /// **'Disassembling and assembling an electronic board'**
  String get electronicBoardService;

  /// No description provided for @externalFanService.
  ///
  /// In en, this message translates to:
  /// **'Removing and installing an external fan'**
  String get externalFanService;

  /// No description provided for @changeDynamo.
  ///
  /// In en, this message translates to:
  /// **'Change the dynamo (external)'**
  String get changeDynamo;

  /// No description provided for @acWash.
  ///
  /// In en, this message translates to:
  /// **'Air conditioner wash'**
  String get acWash;

  /// No description provided for @sewerCleaning.
  ///
  /// In en, this message translates to:
  /// **'Sewer cleaning'**
  String get sewerCleaning;

  /// No description provided for @installCabinetAc.
  ///
  /// In en, this message translates to:
  /// **'Installing a cabinet air conditioner'**
  String get installCabinetAc;

  /// No description provided for @cassetteAcInstallation.
  ///
  /// In en, this message translates to:
  /// **'Cassette air conditioner installation'**
  String get cassetteAcInstallation;

  /// No description provided for @changeSplitCrystal.
  ///
  /// In en, this message translates to:
  /// **'Change the split interior crystal'**
  String get changeSplitCrystal;

  /// No description provided for @changeInternalEngine.
  ///
  /// In en, this message translates to:
  /// **'Change the internal engine dynamo'**
  String get changeInternalEngine;

  /// No description provided for @changeCompressor.
  ///
  /// In en, this message translates to:
  /// **'Changing the compressor 36-48-60 units'**
  String get changeCompressor;

  /// No description provided for @changeComponents.
  ///
  /// In en, this message translates to:
  /// **'Change the cylinder - coil - cylinder - battery'**
  String get changeComponents;

  /// No description provided for @changeContactor.
  ///
  /// In en, this message translates to:
  /// **'Changing and installing a contactor'**
  String get changeContactor;

  /// No description provided for @disassembleElectronicBoard.
  ///
  /// In en, this message translates to:
  /// **'Disassembling and assembling the electronic board'**
  String get disassembleElectronicBoard;

  /// No description provided for @disassembleDryingMachine.
  ///
  /// In en, this message translates to:
  /// **'Disassembling and assembling the drying machine'**
  String get disassembleDryingMachine;

  /// No description provided for @disassembleWashingMachine.
  ///
  /// In en, this message translates to:
  /// **'Disassemble and assemble washing machine'**
  String get disassembleWashingMachine;

  /// No description provided for @doorDisassembly.
  ///
  /// In en, this message translates to:
  /// **'Door disassembly and installation'**
  String get doorDisassembly;

  /// No description provided for @balanceBarService.
  ///
  /// In en, this message translates to:
  /// **'Balance bar disassembly and installation'**
  String get balanceBarService;

  /// No description provided for @waterDrainageMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Water drainage maintenance'**
  String get waterDrainageMaintenance;

  /// No description provided for @waterFlowMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Water flow maintenance'**
  String get waterFlowMaintenance;

  /// No description provided for @electricalShortCircuit.
  ///
  /// In en, this message translates to:
  /// **'Electrical short circuit maintenance'**
  String get electricalShortCircuit;

  /// No description provided for @powerSupplyRepair.
  ///
  /// In en, this message translates to:
  /// **'Power supply repair'**
  String get powerSupplyRepair;

  /// No description provided for @disassembleTimer.
  ///
  /// In en, this message translates to:
  /// **'Disassemble and assemble timer'**
  String get disassembleTimer;

  /// No description provided for @compressorChange.
  ///
  /// In en, this message translates to:
  /// **'Compressor change'**
  String get compressorChange;

  /// No description provided for @changeExternalFan.
  ///
  /// In en, this message translates to:
  /// **'Change the external fan'**
  String get changeExternalFan;

  /// No description provided for @changeInternalFan.
  ///
  /// In en, this message translates to:
  /// **'Change the internal fan'**
  String get changeInternalFan;

  /// No description provided for @changeHeater.
  ///
  /// In en, this message translates to:
  /// **'Change the heater'**
  String get changeHeater;

  /// No description provided for @changeSensor.
  ///
  /// In en, this message translates to:
  /// **'Change the \"Depressor\" sensor'**
  String get changeSensor;

  /// No description provided for @americanFreonFilling.
  ///
  /// In en, this message translates to:
  /// **'American Freon filling'**
  String get americanFreonFilling;

  /// No description provided for @indianFreonFilling.
  ///
  /// In en, this message translates to:
  /// **'Indian Freon filling'**
  String get indianFreonFilling;

  /// No description provided for @externalLeakageMaintenance.
  ///
  /// In en, this message translates to:
  /// **'External leakage maintenance'**
  String get externalLeakageMaintenance;

  /// No description provided for @changeTimer.
  ///
  /// In en, this message translates to:
  /// **'Change and adjust the timer'**
  String get changeTimer;

  /// No description provided for @smallCompressorReplacement.
  ///
  /// In en, this message translates to:
  /// **'Refrigerator compressor replacement 1/6 - 1/5 - 1/4 - 1/3'**
  String get smallCompressorReplacement;

  /// No description provided for @largeCompressorReplacement.
  ///
  /// In en, this message translates to:
  /// **'Refrigerator compressor replacement 1/2 - 3/4 - 1'**
  String get largeCompressorReplacement;

  /// No description provided for @leakRepairAmericanR134.
  ///
  /// In en, this message translates to:
  /// **'External leakage maintenance + American R134 Freon filling'**
  String get leakRepairAmericanR134;

  /// No description provided for @leakRepairAmericanR12.
  ///
  /// In en, this message translates to:
  /// **'External leakage maintenance + American R12 Freon filling'**
  String get leakRepairAmericanR12;

  /// No description provided for @leakRepairChineseR134.
  ///
  /// In en, this message translates to:
  /// **'External leakage maintenance + Chinese R134 Freon filling'**
  String get leakRepairChineseR134;

  /// No description provided for @leakRepairChineseR12.
  ///
  /// In en, this message translates to:
  /// **'External leakage maintenance + Chinese R12 Freon filling'**
  String get leakRepairChineseR12;

  /// No description provided for @leakRepairIndianR134.
  ///
  /// In en, this message translates to:
  /// **'External leakage maintenance + Indian R134 Freon filling'**
  String get leakRepairIndianR134;

  /// No description provided for @changeKeys.
  ///
  /// In en, this message translates to:
  /// **'Change keys'**
  String get changeKeys;

  /// No description provided for @changeDoorHinges.
  ///
  /// In en, this message translates to:
  /// **'Change door hinges'**
  String get changeDoorHinges;

  /// No description provided for @ovenCleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get ovenCleaning;

  /// No description provided for @smugglingMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Smuggling maintenance'**
  String get smugglingMaintenance;

  /// No description provided for @microwaveMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Microwave maintenance'**
  String get microwaveMaintenance;

  /// No description provided for @yourCompletedOrderWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your completed orders will appear here'**
  String get yourCompletedOrderWillAppearHere;

  /// No description provided for @completeCleaningService.
  ///
  /// In en, this message translates to:
  /// **'Complete cleaning service'**
  String get completeCleaningService;

  /// No description provided for @leakRepairService.
  ///
  /// In en, this message translates to:
  /// **'Leak repair service'**
  String get leakRepairService;

  /// No description provided for @acServicesDescription.
  ///
  /// In en, this message translates to:
  /// **'Professional AC installation and maintenance'**
  String get acServicesDescription;

  /// No description provided for @homeAppliancesDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete home appliance repair services'**
  String get homeAppliancesDescription;

  /// No description provided for @plumbingDescription.
  ///
  /// In en, this message translates to:
  /// **'Expert plumbing services'**
  String get plumbingDescription;

  /// No description provided for @electricDescription.
  ///
  /// In en, this message translates to:
  /// **'Professional electrical services'**
  String get electricDescription;

  /// No description provided for @completeServiceWithGasRefill.
  ///
  /// In en, this message translates to:
  /// **'Complete service with gas refill'**
  String get completeServiceWithGasRefill;

  /// No description provided for @professionalInstallation.
  ///
  /// In en, this message translates to:
  /// **'Professional installation'**
  String get professionalInstallation;

  /// No description provided for @indoorMountingService.
  ///
  /// In en, this message translates to:
  /// **'Indoor mounting/dismounting'**
  String get indoorMountingService;

  /// No description provided for @outdoorMountingService.
  ///
  /// In en, this message translates to:
  /// **'Outdoor mounting/dismounting'**
  String get outdoorMountingService;

  /// No description provided for @controlBoardRepair.
  ///
  /// In en, this message translates to:
  /// **'Control board repair'**
  String get controlBoardRepair;

  /// No description provided for @externalMotorReplacement.
  ///
  /// In en, this message translates to:
  /// **'External motor replacement'**
  String get externalMotorReplacement;

  /// No description provided for @completeCleaning.
  ///
  /// In en, this message translates to:
  /// **'Complete cleaning'**
  String get completeCleaning;

  /// No description provided for @serviceWithGasRefill.
  ///
  /// In en, this message translates to:
  /// **'Service with gas refill'**
  String get serviceWithGasRefill;

  /// No description provided for @installationService.
  ///
  /// In en, this message translates to:
  /// **'Installation service'**
  String get installationService;

  /// No description provided for @drainPipeCleaning.
  ///
  /// In en, this message translates to:
  /// **'Drain pipe cleaning'**
  String get drainPipeCleaning;

  /// No description provided for @cabinetInstallation.
  ///
  /// In en, this message translates to:
  /// **'Cabinet installation'**
  String get cabinetInstallation;

  /// No description provided for @controlBoardService.
  ///
  /// In en, this message translates to:
  /// **'Control board service'**
  String get controlBoardService;

  /// No description provided for @cassetteTypeInstallation.
  ///
  /// In en, this message translates to:
  /// **'Cassette type installation'**
  String get cassetteTypeInstallation;

  /// No description provided for @indoorUnitCrystalReplacement.
  ///
  /// In en, this message translates to:
  /// **'Indoor unit crystal replacement'**
  String get indoorUnitCrystalReplacement;

  /// No description provided for @internalMotorReplacement.
  ///
  /// In en, this message translates to:
  /// **'Internal motor replacement'**
  String get internalMotorReplacement;

  /// No description provided for @compressorReplacementLarge.
  ///
  /// In en, this message translates to:
  /// **'Compressor replacement (large)'**
  String get compressorReplacementLarge;

  /// No description provided for @majorComponentReplacement.
  ///
  /// In en, this message translates to:
  /// **'Major component replacement'**
  String get majorComponentReplacement;

  /// No description provided for @contactorReplacement.
  ///
  /// In en, this message translates to:
  /// **'Contactor replacement'**
  String get contactorReplacement;

  /// No description provided for @balanceBarServiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Balance bar service'**
  String get balanceBarServiceDesc;

  /// No description provided for @drainSystemService.
  ///
  /// In en, this message translates to:
  /// **'Drain system service'**
  String get drainSystemService;

  /// No description provided for @waterInletService.
  ///
  /// In en, this message translates to:
  /// **'Water inlet service'**
  String get waterInletService;

  /// No description provided for @electricalRepair.
  ///
  /// In en, this message translates to:
  /// **'Electrical repair'**
  String get electricalRepair;

  /// No description provided for @powerSystemRepair.
  ///
  /// In en, this message translates to:
  /// **'Power system repair'**
  String get powerSystemRepair;

  /// No description provided for @timerRepair.
  ///
  /// In en, this message translates to:
  /// **'Timer repair'**
  String get timerRepair;

  /// No description provided for @dryerService.
  ///
  /// In en, this message translates to:
  /// **'Dryer service'**
  String get dryerService;

  /// No description provided for @compressorReplacement.
  ///
  /// In en, this message translates to:
  /// **'Compressor replacement'**
  String get compressorReplacement;

  /// No description provided for @externalFanReplacement.
  ///
  /// In en, this message translates to:
  /// **'External fan replacement'**
  String get externalFanReplacement;

  /// No description provided for @internalFanReplacement.
  ///
  /// In en, this message translates to:
  /// **'Internal fan replacement'**
  String get internalFanReplacement;

  /// No description provided for @heaterReplacement.
  ///
  /// In en, this message translates to:
  /// **'Heater replacement'**
  String get heaterReplacement;

  /// No description provided for @sensorReplacement.
  ///
  /// In en, this message translates to:
  /// **'Sensor replacement'**
  String get sensorReplacement;

  /// No description provided for @fanReplacement.
  ///
  /// In en, this message translates to:
  /// **'Fan Replacement'**
  String get fanReplacement;

  /// No description provided for @professionalsService.
  ///
  /// In en, this message translates to:
  /// **'Professional Service'**
  String get professionalsService;

  /// No description provided for @testingIncluded.
  ///
  /// In en, this message translates to:
  /// **'Testing Included'**
  String get testingIncluded;

  /// No description provided for @motorReplacement.
  ///
  /// In en, this message translates to:
  /// **'Motor Replacement'**
  String get motorReplacement;

  /// No description provided for @qualityParts.
  ///
  /// In en, this message translates to:
  /// **'Quality Parts'**
  String get qualityParts;

  /// No description provided for @expertservice.
  ///
  /// In en, this message translates to:
  /// **'Expert Service'**
  String get expertservice;

  /// No description provided for @deepCleaning.
  ///
  /// In en, this message translates to:
  /// **'Deep Cleaning'**
  String get deepCleaning;

  /// No description provided for @filterCleaning.
  ///
  /// In en, this message translates to:
  /// **'Filter Cleaning'**
  String get filterCleaning;

  /// No description provided for @performanceCheck.
  ///
  /// In en, this message translates to:
  /// **'Performance Check'**
  String get performanceCheck;

  /// No description provided for @leakDetection.
  ///
  /// In en, this message translates to:
  /// **'Leak Detection'**
  String get leakDetection;

  /// No description provided for @professionalRepair.
  ///
  /// In en, this message translates to:
  /// **'Professional Repair'**
  String get professionalRepair;

  /// No description provided for @teakRepair.
  ///
  /// In en, this message translates to:
  /// **'Teak Repair'**
  String get teakRepair;

  /// No description provided for @teakDetection.
  ///
  /// In en, this message translates to:
  /// **'Teak Detection'**
  String get teakDetection;

  /// No description provided for @professionalsRepair.
  ///
  /// In en, this message translates to:
  /// **'Professional Repair'**
  String get professionalsRepair;

  /// No description provided for @testing.
  ///
  /// In en, this message translates to:
  /// **'Testing'**
  String get testing;

  /// No description provided for @cleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get cleaning;

  /// No description provided for @gasRefill.
  ///
  /// In en, this message translates to:
  /// **'Gas Refill'**
  String get gasRefill;

  /// No description provided for @performanceOptimization.
  ///
  /// In en, this message translates to:
  /// **'Performance Optimization'**
  String get performanceOptimization;

  /// No description provided for @indoorUnitCleaning.
  ///
  /// In en, this message translates to:
  /// **'Indoor Unit Cleaning'**
  String get indoorUnitCleaning;

  /// No description provided for @outdoorUnitCleaning.
  ///
  /// In en, this message translates to:
  /// **'Outdoor Unit Cleaning'**
  String get outdoorUnitCleaning;

  /// No description provided for @warrantyIncluded.
  ///
  /// In en, this message translates to:
  /// **'Warranty Included'**
  String get warrantyIncluded;

  /// No description provided for @indoorService.
  ///
  /// In en, this message translates to:
  /// **'Indoor Service'**
  String get indoorService;

  /// No description provided for @professionalTools.
  ///
  /// In en, this message translates to:
  /// **'Professional Tools'**
  String get professionalTools;

  /// No description provided for @safeHandling.
  ///
  /// In en, this message translates to:
  /// **'Safe Handling'**
  String get safeHandling;

  /// No description provided for @outdoorService.
  ///
  /// In en, this message translates to:
  /// **'Outdoor Service'**
  String get outdoorService;

  /// No description provided for @safetyEquipment.
  ///
  /// In en, this message translates to:
  /// **'Safety Equipment'**
  String get safetyEquipment;

  /// No description provided for @expertTechnicians.
  ///
  /// In en, this message translates to:
  /// **'Expert Technicians'**
  String get expertTechnicians;

  /// No description provided for @electronicRepair.
  ///
  /// In en, this message translates to:
  /// **'Electronic Repair'**
  String get electronicRepair;

  /// No description provided for @cleanFinish.
  ///
  /// In en, this message translates to:
  /// **'Clean Finish'**
  String get cleanFinish;

  /// No description provided for @quickService.
  ///
  /// In en, this message translates to:
  /// **'Quick Service'**
  String get quickService;

  /// No description provided for @pipeUnclogging.
  ///
  /// In en, this message translates to:
  /// **'Pipe Unclogging'**
  String get pipeUnclogging;

  /// No description provided for @completeSetup.
  ///
  /// In en, this message translates to:
  /// **'Complete Setup'**
  String get completeSetup;

  /// No description provided for @boardReplacement.
  ///
  /// In en, this message translates to:
  /// **'Board Replacement'**
  String get boardReplacement;

  /// No description provided for @crystalReplacement.
  ///
  /// In en, this message translates to:
  /// **'Crystal Replacement'**
  String get crystalReplacement;

  /// No description provided for @componentReplacement.
  ///
  /// In en, this message translates to:
  /// **'Component Replacement'**
  String get componentReplacement;

  /// No description provided for @boardRepair.
  ///
  /// In en, this message translates to:
  /// **'Board Repair'**
  String get boardRepair;

  /// No description provided for @dryerRepair.
  ///
  /// In en, this message translates to:
  /// **'Dryer Repair'**
  String get dryerRepair;

  /// No description provided for @completeDisassembly.
  ///
  /// In en, this message translates to:
  /// **'Complete Disassembly'**
  String get completeDisassembly;

  /// No description provided for @reassembly.
  ///
  /// In en, this message translates to:
  /// **'Reassembly'**
  String get reassembly;

  /// No description provided for @doorRepair.
  ///
  /// In en, this message translates to:
  /// **'Door Repair'**
  String get doorRepair;

  /// No description provided for @sealReplacement.
  ///
  /// In en, this message translates to:
  /// **'Seal Replacement'**
  String get sealReplacement;

  /// No description provided for @alignmentCheck.
  ///
  /// In en, this message translates to:
  /// **'Alignment Check'**
  String get alignmentCheck;

  /// No description provided for @balanceBarReplacement.
  ///
  /// In en, this message translates to:
  /// **'Balance Bar Replacement'**
  String get balanceBarReplacement;

  /// No description provided for @vibrationReduction.
  ///
  /// In en, this message translates to:
  /// **'Vibration Reduction'**
  String get vibrationReduction;

  /// No description provided for @pumpCheck.
  ///
  /// In en, this message translates to:
  /// **'Pump Check'**
  String get pumpCheck;

  /// No description provided for @inletValveService.
  ///
  /// In en, this message translates to:
  /// **'Inlet Valve Service'**
  String get inletValveService;

  /// No description provided for @waterFlowOptimization.
  ///
  /// In en, this message translates to:
  /// **'Water Flow Optimization'**
  String get waterFlowOptimization;

  /// No description provided for @electricalDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Electrical Diagnosis'**
  String get electricalDiagnosis;

  /// No description provided for @wiringRepair.
  ///
  /// In en, this message translates to:
  /// **'Wiring Repair'**
  String get wiringRepair;

  /// No description provided for @safetyCheck.
  ///
  /// In en, this message translates to:
  /// **'Safety Check'**
  String get safetyCheck;

  /// No description provided for @componentCheck.
  ///
  /// In en, this message translates to:
  /// **'Component Check'**
  String get componentCheck;

  /// No description provided for @timerReplacement.
  ///
  /// In en, this message translates to:
  /// **'Timer Replacement'**
  String get timerReplacement;

  /// No description provided for @fullService.
  ///
  /// In en, this message translates to:
  /// **'Full Service'**
  String get fullService;

  /// No description provided for @expertService.
  ///
  /// In en, this message translates to:
  /// **'Expert Service'**
  String get expertService;

  /// No description provided for @professionalService.
  ///
  /// In en, this message translates to:
  /// **'Professional Service'**
  String get professionalService;

  /// No description provided for @textRepair.
  ///
  /// In en, this message translates to:
  /// **'Text Repair'**
  String get textRepair;

  /// No description provided for @completeinstallation.
  ///
  /// In en, this message translates to:
  /// **'Complete Installation'**
  String get completeinstallation;

  /// No description provided for @professionalSetup.
  ///
  /// In en, this message translates to:
  /// **'Professional Setup'**
  String get professionalSetup;

  /// No description provided for @completeservice.
  ///
  /// In en, this message translates to:
  /// **'Complete Service'**
  String get completeservice;

  /// No description provided for @leakRepair.
  ///
  /// In en, this message translates to:
  /// **'Leak Repair'**
  String get leakRepair;

  /// No description provided for @completeInstallation.
  ///
  /// In en, this message translates to:
  /// **'Complete Installation'**
  String get completeInstallation;

  /// No description provided for @completeService.
  ///
  /// In en, this message translates to:
  /// **'Complete Service'**
  String get completeService;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @selectedLocation.
  ///
  /// In en, this message translates to:
  /// **'Selected Location'**
  String get selectedLocation;

  /// No description provided for @tapOnMapToSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Tap on the map to select your location'**
  String get tapOnMapToSelectLocation;

  /// No description provided for @tapToChangeLocation.
  ///
  /// In en, this message translates to:
  /// **'Tap to change location'**
  String get tapToChangeLocation;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocation;

  /// No description provided for @tapToSelectOnMap.
  ///
  /// In en, this message translates to:
  /// **'Tap to select on map'**
  String get tapToSelectOnMap;

  /// No description provided for @pleaseSelectLocationFromMap.
  ///
  /// In en, this message translates to:
  /// **'Please select location from map'**
  String get pleaseSelectLocationFromMap;

  /// No description provided for @tapMapIconToSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Tap map icon to select location'**
  String get tapMapIconToSelectLocation;

  /// No description provided for @addressType.
  ///
  /// In en, this message translates to:
  /// **'Address Type'**
  String get addressType;

  /// No description provided for @additionalLocationDetails.
  ///
  /// In en, this message translates to:
  /// **'Additional location details (landmark, building name, etc.)'**
  String get additionalLocationDetails;

  /// No description provided for @selectOnMap.
  ///
  /// In en, this message translates to:
  /// **'Select on Map'**
  String get selectOnMap;

  /// No description provided for @chooseExactLocationOnMap.
  ///
  /// In en, this message translates to:
  /// **'Choose exact location on map'**
  String get chooseExactLocationOnMap;

  /// No description provided for @useCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get useCurrentLocation;

  /// No description provided for @detectYourCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Detect your current location automatically'**
  String get detectYourCurrentLocation;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @selectDeliveryLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Delivery Location'**
  String get selectDeliveryLocation;

  /// No description provided for @hasBeenSaved.
  ///
  /// In en, this message translates to:
  /// **'has been saved'**
  String get hasBeenSaved;

  /// No description provided for @cartWithCount.
  ///
  /// In en, this message translates to:
  /// **'Cart (\$COUNT\$)'**
  String get cartWithCount;

  /// No description provided for @dateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateAndTime;

  /// No description provided for @pleaseSelectADateFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a date first'**
  String get pleaseSelectADateFirst;

  /// No description provided for @errorPickingImages.
  ///
  /// In en, this message translates to:
  /// **'Error picking images'**
  String get errorPickingImages;

  /// No description provided for @errorTakingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Error taking photo'**
  String get errorTakingPhoto;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @qty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get qty;

  /// No description provided for @electricalServices.
  ///
  /// In en, this message translates to:
  /// **'Electrical Services'**
  String get electricalServices;

  /// No description provided for @splitAcServices.
  ///
  /// In en, this message translates to:
  /// **'Split AC Services'**
  String get splitAcServices;

  /// No description provided for @windowAcServices.
  ///
  /// In en, this message translates to:
  /// **'Window AC Services'**
  String get windowAcServices;

  /// No description provided for @packageAcServices.
  ///
  /// In en, this message translates to:
  /// **'Package AC Services'**
  String get packageAcServices;

  /// No description provided for @washingMachineServices.
  ///
  /// In en, this message translates to:
  /// **'Washing Machine Services'**
  String get washingMachineServices;

  /// No description provided for @refrigeratorServices.
  ///
  /// In en, this message translates to:
  /// **'Refrigerator Services'**
  String get refrigeratorServices;

  /// No description provided for @ovenServices.
  ///
  /// In en, this message translates to:
  /// **'Oven Services'**
  String get ovenServices;

  /// No description provided for @pipeLeak.
  ///
  /// In en, this message translates to:
  /// **'Pipe Leak'**
  String get pipeLeak;

  /// No description provided for @cloggedDrains.
  ///
  /// In en, this message translates to:
  /// **'Clogged Drains'**
  String get cloggedDrains;

  /// No description provided for @faucetRepair.
  ///
  /// In en, this message translates to:
  /// **'Faucet Repair'**
  String get faucetRepair;

  /// No description provided for @wiringProblems.
  ///
  /// In en, this message translates to:
  /// **'Wiring Problems'**
  String get wiringProblems;

  /// No description provided for @switchRepair.
  ///
  /// In en, this message translates to:
  /// **'Switch Repair'**
  String get switchRepair;

  /// No description provided for @outletRepair.
  ///
  /// In en, this message translates to:
  /// **'Outlet Repair'**
  String get outletRepair;

  /// No description provided for @acCleaning.
  ///
  /// In en, this message translates to:
  /// **'AC Washer (cleaning the internal and external unit)'**
  String get acCleaning;

  /// No description provided for @acCleaningDescription.
  ///
  /// In en, this message translates to:
  /// **'Split AC - Complete cleaning service'**
  String get acCleaningDescription;

  /// No description provided for @acLeakRepair.
  ///
  /// In en, this message translates to:
  /// **'Leak repair'**
  String get acLeakRepair;

  /// No description provided for @acWithGasRefill.
  ///
  /// In en, this message translates to:
  /// **'Disassemble and assemble electronic board'**
  String get acWithGasRefill;

  /// No description provided for @acInstallation.
  ///
  /// In en, this message translates to:
  /// **'New AC installation'**
  String get acInstallation;

  /// No description provided for @acIndoorMounting.
  ///
  /// In en, this message translates to:
  /// **'Indoor mounting/dismounting'**
  String get acIndoorMounting;

  /// No description provided for @acOutdoorMounting.
  ///
  /// In en, this message translates to:
  /// **'Outdoor mounting/dismounting'**
  String get acOutdoorMounting;

  /// No description provided for @externalMotorChange.
  ///
  /// In en, this message translates to:
  /// **'External motor change'**
  String get externalMotorChange;

  /// No description provided for @acFullCleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning all units + Freon filling'**
  String get acFullCleaning;

  /// No description provided for @cleaningAllUnitsGasRefill.
  ///
  /// In en, this message translates to:
  /// **'Cleaning all units + Freon filling'**
  String get cleaningAllUnitsGasRefill;

  /// No description provided for @mountingService.
  ///
  /// In en, this message translates to:
  /// **'Cabinet installation'**
  String get mountingService;

  /// No description provided for @controlBoardRepairService.
  ///
  /// In en, this message translates to:
  /// **'Disassemble and assemble electronic board'**
  String get controlBoardRepairService;

  /// No description provided for @cassetteTypeInstallationService.
  ///
  /// In en, this message translates to:
  /// **'Cassette type installation'**
  String get cassetteTypeInstallationService;

  /// No description provided for @internalCrystalChange.
  ///
  /// In en, this message translates to:
  /// **'Internal crystal change'**
  String get internalCrystalChange;

  /// No description provided for @internalMotorChange.
  ///
  /// In en, this message translates to:
  /// **'Internal motor change'**
  String get internalMotorChange;

  /// No description provided for @largeCompressorChange.
  ///
  /// In en, this message translates to:
  /// **'Large compressor change'**
  String get largeCompressorChange;

  /// No description provided for @largeComponentChange.
  ///
  /// In en, this message translates to:
  /// **'Large compressor change'**
  String get largeComponentChange;

  /// No description provided for @contactorChange.
  ///
  /// In en, this message translates to:
  /// **'Contactor change'**
  String get contactorChange;

  /// No description provided for @completentialation.
  ///
  /// In en, this message translates to:
  /// **'Complete Installation'**
  String get completentialation;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationTitle;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All as Read'**
  String get markAllAsRead;

  /// No description provided for @newNotification.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newNotification;

  /// No description provided for @youHaveUnreadNotificationsSingular.
  ///
  /// In en, this message translates to:
  /// **'You have 1 unread notification'**
  String get youHaveUnreadNotificationsSingular;

  /// No description provided for @youHaveUnreadNotificationsPlural.
  ///
  /// In en, this message translates to:
  /// **'You have \$COUNT\$ unread notifications'**
  String get youHaveUnreadNotificationsPlural;

  /// No description provided for @bookingConfirmedNotification.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed'**
  String get bookingConfirmedNotification;

  /// No description provided for @bookingConfirmedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your AC Cleaning service has been confirmed for tomorrow at 10:00 AM'**
  String get bookingConfirmedMessage;

  /// No description provided for @specialOfferNotification.
  ///
  /// In en, this message translates to:
  /// **'Special Offer'**
  String get specialOfferNotification;

  /// No description provided for @specialOfferMessage.
  ///
  /// In en, this message translates to:
  /// **'Get 20% off on all plumbing services this weekend!'**
  String get specialOfferMessage;

  /// No description provided for @serviceReminderNotification.
  ///
  /// In en, this message translates to:
  /// **'Service Reminder'**
  String get serviceReminderNotification;

  /// No description provided for @serviceReminderMessage.
  ///
  /// In en, this message translates to:
  /// **'Your washing machine cleaning is scheduled for today at 2:00 PM'**
  String get serviceReminderMessage;

  /// No description provided for @serviceCompletedNotification.
  ///
  /// In en, this message translates to:
  /// **'Service Completed'**
  String get serviceCompletedNotification;

  /// No description provided for @serviceCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your electrical repair service has been completed. Rate your experience!'**
  String get serviceCompletedMessage;

  /// No description provided for @technicianAssignedNotification.
  ///
  /// In en, this message translates to:
  /// **'Technician Assigned'**
  String get technicianAssignedNotification;

  /// No description provided for @technicianAssignedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your technician Ahmed has been assigned to your AC Cleaning service'**
  String get technicianAssignedMessage;

  /// No description provided for @workStartedNotification.
  ///
  /// In en, this message translates to:
  /// **'Work Started'**
  String get workStartedNotification;

  /// No description provided for @workStartedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your technician has started working on your service'**
  String get workStartedMessage;

  /// No description provided for @workCompletedNotification.
  ///
  /// In en, this message translates to:
  /// **'Work Completed'**
  String get workCompletedNotification;

  /// No description provided for @workCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your service has been completed successfully. Please review and rate!'**
  String get workCompletedMessage;

  /// No description provided for @invoiceGeneratedNotification.
  ///
  /// In en, this message translates to:
  /// **'Invoice Generated'**
  String get invoiceGeneratedNotification;

  /// No description provided for @invoiceGeneratedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your invoice is ready. Total amount: SAR \$AMOUNT\$'**
  String get invoiceGeneratedMessage;

  /// No description provided for @timeAgoJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get timeAgoJustNow;

  /// No description provided for @timeAgoMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ minute ago'**
  String get timeAgoMinutesAgo;

  /// No description provided for @timeAgoMinutesAgoPlural.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ minutes ago'**
  String get timeAgoMinutesAgoPlural;

  /// No description provided for @timeAgoHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ hour ago'**
  String get timeAgoHoursAgo;

  /// No description provided for @timeAgoHoursAgoPlural.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ hours ago'**
  String get timeAgoHoursAgoPlural;

  /// No description provided for @timeAgoDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ day ago'**
  String get timeAgoDaysAgo;

  /// No description provided for @timeAgoDaysAgoPlural.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ days ago'**
  String get timeAgoDaysAgoPlural;

  /// No description provided for @timeAgoWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ week ago'**
  String get timeAgoWeeksAgo;

  /// No description provided for @timeAgoWeeksAgoPlural.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ weeks ago'**
  String get timeAgoWeeksAgoPlural;

  /// No description provided for @timeAgoMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ month ago'**
  String get timeAgoMonthsAgo;

  /// No description provided for @timeAgoMonthsAgoPlural.
  ///
  /// In en, this message translates to:
  /// **'\$COUNT\$ months ago'**
  String get timeAgoMonthsAgoPlural;

  /// No description provided for @currencySAR.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get currencySAR;

  /// No description provided for @sar.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get sar;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @workCompleted.
  ///
  /// In en, this message translates to:
  /// **'Work Completed'**
  String get workCompleted;
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
