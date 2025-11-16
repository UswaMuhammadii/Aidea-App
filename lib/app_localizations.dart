import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'Aidea Technology',
      'homeServices': 'Home Services',
      'hello': 'Hello',
      'welcome': 'Welcome',
      'notificationsEnabled': 'Notifications Enabled',
      'notificationDescription': 'Receive updates about your bookings and services',
      'gettingCurrentLocation': 'Getting current location...',
      'continueText': 'Continue',
      'technician': 'Technician',
      'dateTime': 'Date & Time',
      'currency': 'SAR',
      'currencySymbol': 'SAR',
      'phoneLogin': 'Phone Login',
      'whatIsYourMobileNumber': 'What is your mobile number?',
      'enterMobileToSendCode': 'Enter your mobile number to send you the activation code',
      'login': 'Login',
      'invalidNumber': 'Invalid number',
      'otpVerification': 'OTP Verification',
      'enterCodeSentToYou': 'Enter the code sent to you',
      'confirmationCodeSent': 'Confirmation code has been sent to',
      'didntReceiveCode': 'Didn\'t receive the code?',
      'resend': 'Resend',
      'verify': 'Verify',
      'completeYourProfile': 'Complete Your Profile',
      'personalInformation': 'Personal Information',
      'fullName': 'Full Name',
      'enterYourFullName': 'Enter your full name',
      'emailAddress': 'Email Address',
      'enterYourEmail': 'Enter your email',
      'deliveryAddress': 'Delivery Address',
      'streetName': 'Street Name',
      'floor': 'Floor',
      'floorNumber': 'Floor number',
      'apartment': 'Apartment',
      'apartmentNumber': 'Apartment number',
      'otherInformation': 'Other information',
      'saveAddressAsPrimary': 'Save address as primary',
      'home': 'Home',
      'work': 'Work',
      'friend': 'Friend',
      'saveContinue': 'Save & Continue',
      'dashboard': 'Dashboard',
      'ourServices': 'Our Services',
      'services': 'Services',
      'service': 'Service',
      'viewAllServices': 'View all services',
      'serviceDetails': 'Service Details',
      'addToCart': 'Add to Cart',
      'addedToCart': 'Added to cart successfully!',
      'viewCart': 'View Cart',
      'orders': 'Orders',
      'myOrders': 'My Orders',
      'activeOrders': 'Active',
      'previousOrders': 'Previous',
      'noActiveOrders': 'No Active Orders',
      'noPreviousOrders': 'No Previous Orders',
      'bookYourFirstService': 'Book your first service today!',
      'completedOrdersAppearHere': 'Your completed orders will appear here',
      'bookNow': 'Book Now',
      'orderDetails': 'Order Details',
      'orderId': 'Order ID',
      'bookingDate': 'Booking Date',
      'serviceTime': 'Service Time',
      'address': 'Address',
      'serviceAddress': 'Service Address',
      'totalAmount': 'Total Amount',
      'estimatedPrice': 'Estimated Price',
      'orderStatus': 'Order Status',
      'trackOrder': 'Track Order',
      'viewTechnicianDetails': 'View Technician Details',
      'servicesBooked': '{count} services booked',
      'at': 'at',
      'pending': 'Pending',
      'confirmed': 'Confirmed',
      'inProgress': 'In Progress',
      'completed': 'Completed',
      'cancelled': 'Cancelled',
      'bookingDone': 'Booking Done',
      'technicianAssigned': 'Technician Assigned',
      'workStarted': 'Work Started',
      'workDone': 'Work Done',
      'cart': 'Cart',
      'yourCartIsEmpty': 'Your cart is empty',
      'addSomeServices': 'Add some services to get started',
      'clearAll': 'Clear All',
      'clearCart': 'Clear Cart',
      'areYouSureRemoveAllItems': 'Are you sure you want to remove all items?',
      'proceedToCheckout': 'Proceed to Checkout',
      'quantity': 'Quantity',
      'total': 'Total',
      'checkout': 'Checkout',
      'bookService': 'Book Service',
      'selectedServices': 'Selected Services',
      'uploadApplianceImages': 'Upload Appliance Images',
      'addPhotos': 'Add Photos',
      'uploadPhotosOfAppliance': 'Upload photos of your appliance',
      'imagesSelected': '{count} images selected',
      'selectDate': 'Select Date',
      'chooseDate': 'Choose a date',
      'selectTime': 'Select Time',
      'chooseTime': 'Choose a time',
      'enterServiceAddress': 'Enter service address',
      'additionalNotesOptional': 'Additional Notes (Optional)',
      'anySpecialRequests': 'Any special requests or notes...',
      'requestSummary': 'Request Summary',
      'date': 'Date',
      'time': 'Time',
      'submitRequest': 'Submit Request',
      'bookingConfirmed': 'Booking Confirmed!',
      'serviceBookedSuccessfully': 'Your service has been successfully booked',
      'backToHome': 'Back to Home',
      'viewBookings': 'View Bookings',
      'invoices': 'Invoices',
      'noInvoicesYet': 'No Invoices Yet',
      'completeServiceToGenerate': 'Complete a service to generate invoices',
      'downloadShareInvoice': 'Download / Share Invoice',
      'paid': 'PAID',
      'reviews': 'Reviews',
      'myReviews': 'My Reviews',
      'writeReview': 'Write a Review',
      'rateYourExperience': 'Rate Your Experience',
      'shareYourExperience': 'Share your experience (optional)...',
      'noReviewsYet': 'No Reviews Yet',
      'profile': 'Profile',
      'editProfile': 'Edit Profile',
      'settings': 'Settings',
      'notifications': 'Notifications',
      'language': 'Language',
      'darkMode': 'Dark Mode',
      'logout': 'Logout',
      'areYouSureLogout': 'Are you sure you want to logout?',
      'notificationsScreen': 'Notifications',
      'markAllRead': 'Mark all read',
      'noNotifications': 'No Notifications',
      'allCaughtUp': 'You\'re all caught up!',
      'enableNotifications': 'Enable Notifications',
      'notNow': 'Not Now',
      'allow': 'Allow',
      'chatWithTechnician': 'Chat with Technician',
      'typeMessage': 'Type a message...',
      'cancelBooking': 'Cancel Booking',
      'keepBooking': 'Keep Booking',
      'selectCancellationReason': 'Please select a reason for cancellation',
      'searchServices': 'Search services...',
      'noServicesFound': 'No services found',
      'changeAddress': 'Change Address',
      'useCurrentLocation': 'Use my current location',
      'selectCountryCode': 'Select Country Code',
      'continueToCheckout': 'Continue to Checkout',
      'addressUpdated': 'Address updated successfully!',
      'savedAddresses': 'Saved Addresses',
      'editing': 'Editing',
      'enterYourAddress': 'Enter your address',
      'comingSoon': 'Coming soon!',
      'addNewAddress': 'Add New Address',
      'cancel': 'Cancel',
      'save': 'Save',
      'homeAddress': 'Home Address',

      // ADDED ALL MISSING KEYS
      'pleaseSelectDateTime': 'Please select date and time',
      'errorPickingImages': 'Error picking images',
      'errorTakingPhoto': 'Error taking photo',
      'chooseImageSource': 'Choose image source',
      'gallery': 'Gallery',
      'camera': 'Camera',
      'pleaseSelectBothDateAndTime': 'Please select both date and time',
      'pleaseEnterYourAddress': 'Please enter your address',
      'qty': 'Qty',
      'uploadPhotosOfYourAppliance': 'Upload photos of your appliance',
      'image': 'Image',
      'images': 'Images',
      'selected': 'Selected',
      'anySpecialRequestsOnNotes': 'Any special requests or notes...',
      'notSelected': 'Not selected',
      'noImages': 'No images',
      'holmages': 'Hold images',
      'pleaseSelectDateFirst': 'Please select date first',
      'anySpecialRequestsOrNotes': 'Any special requests or notes...',
      'profileUpdated': 'Profile updated successfully!',
      'pleaseEnterName': 'Please enter your name',
      'pleaseEnterEmail': 'Please enter your email',
      'pleaseEnterValidEmail': 'Please enter a valid email',
      'phoneNumber': 'Phone Number',
      'pleaseEnterPhone': 'Please enter your phone number',
      'saveChanges': 'Save Changes',
      'added': 'Added',
      'toCartSuccessfully': 'to cart successfully',
      'whatsIncluded': 'What\'s Included',
      'notIncluded': 'Not Included',
      'anyTypeOfRepair': 'Any type of repair',
      'anyTypeOfMaterial': 'Any type of material',
      'ladder': 'Ladder',
      'toCart': 'to cart',
      'chooseMachineType': 'Choose Machine Type',
      'washingMachine': 'Washing Machine',
      'viewServiceFor': 'View Service for',
      'machines': 'Machines',
      'tryAdjustingYourSearchTerms': 'Try adjusting your search terms',
      'viewServicesFor': 'View services for',
    },
    'ar': {
      'appName': 'أيديا تكنولوجي',
      'homeServices': 'الخدمات المنزلية',
      'hello': 'مرحباً',
      'welcome': 'أهلاً وسهلاً',
      'notificationsEnabled': 'الإشعارات مفعلة',
      'notificationDescription': 'استقبل تحديثات حول حجوزاتك وخدماتك',
      'gettingCurrentLocation': 'جاري الحصول على الموقع الحالي...',
      'continueText': 'متابعة',
      'technician': 'الفني',
      'dateTime': 'التاريخ والوقت',
      'currency': 'ريال',
      'currencySymbol': 'ر.س',
      'phoneLogin': 'تسجيل الدخول بالهاتف',
      'whatIsYourMobileNumber': 'ما هو رقم هاتفك المحمول؟',
      'enterMobileToSendCode': 'أدخل رقم هاتفك المحمول لإرسال رمز التفعيل',
      'login': 'تسجيل الدخول',
      'invalidNumber': 'رقم غير صالح',
      'otpVerification': 'التحقق من OTP',
      'enterCodeSentToYou': 'أدخل الرمز المرسل إليك',
      'confirmationCodeSent': 'تم إرسال رمز التأكيد إلى',
      'didntReceiveCode': 'لم تستلم الرمز؟',
      'resend': 'إعادة إرسال',
      'verify': 'التحقق',
      'completeYourProfile': 'أكمل ملفك الشخصي',
      'personalInformation': 'المعلومات الشخصية',
      'fullName': 'الاسم الكامل',
      'enterYourFullName': 'أدخل اسمك الكامل',
      'emailAddress': 'عنوان البريد الإلكتروني',
      'enterYourEmail': 'أدخل بريدك الإلكتروني',
      'deliveryAddress': 'عنوان التسليم',
      'streetName': 'اسم الشارع',
      'floor': 'الطابق',
      'floorNumber': 'رقم الطابق',
      'apartment': 'الشقة',
      'apartmentNumber': 'رقم الشقة',
      'otherInformation': 'معلومات أخرى',
      'saveAddressAsPrimary': 'حفظ العنوان كعنوان أساسي',
      'home': 'المنزل',
      'work': 'العمل',
      'friend': 'صديق',
      'saveContinue': 'حفظ ومتابعة',
      'dashboard': 'لوحة التحكم',
      'ourServices': 'خدماتنا',
      'services': 'الخدمات',
      'service': 'الخدمة',
      'viewAllServices': 'عرض جميع الخدمات',
      'serviceDetails': 'تفاصيل الخدمة',
      'addToCart': 'أضف إلى السلة',
      'addedToCart': 'تمت الإضافة إلى السلة بنجاح!',
      'viewCart': 'عرض السلة',
      'orders': 'الطلبات',
      'myOrders': 'طلباتي',
      'activeOrders': 'نشطة',
      'previousOrders': 'سابقة',
      'noActiveOrders': 'لا توجد طلبات نشطة',
      'noPreviousOrders': 'لا توجد طلبات سابقة',
      'bookYourFirstService': 'احجز خدمتك الأولى اليوم!',
      'completedOrdersAppearHere': 'ستظهر طلباتك المكتملة هنا',
      'bookNow': 'احجز الآن',
      'orderDetails': 'تفاصيل الطلب',
      'orderId': 'رقم الطلب',
      'bookingDate': 'تاريخ الحجز',
      'serviceTime': 'وقت الخدمة',
      'address': 'العنوان',
      'serviceAddress': 'عنوان الخدمة',
      'totalAmount': 'المبلغ الإجمالي',
      'estimatedPrice': 'السعر المقدر',
      'orderStatus': 'حالة الطلب',
      'trackOrder': 'تتبع الطلب',
      'viewTechnicianDetails': 'عرض تفاصيل الفني',
      'servicesBooked': '{count} خدمات محجوزة',
      'at': 'في',
      'pending': 'قيد الانتظار',
      'confirmed': 'مؤكد',
      'inProgress': 'جاري التنفيذ',
      'completed': 'مكتمل',
      'cancelled': 'ملغى',
      'bookingDone': 'تم الحجز',
      'technicianAssigned': 'تم تعيين الفني',
      'workStarted': 'بدأ العمل',
      'workDone': 'تم العمل',
      'cart': 'السلة',
      'viewServicesFor': 'عرض الخدمات لـ',
      'yourCartIsEmpty': 'سلتك فارغة',
      'addSomeServices': 'أضف بعض الخدمات للبدء',
      'clearAll': 'مسح الكل',
      'clearCart': 'مسح السلة',
      'areYouSureRemoveAllItems': 'هل أنت متأكد من إزالة جميع العناصر؟',
      'proceedToCheckout': 'متابعة الدفع',
      'quantity': 'الكمية',
      'total': 'الإجمالي',
      'checkout': 'الدفع',
      'bookService': 'حجز الخدمة',
      'selectedServices': 'الخدمات المحددة',
      'uploadApplianceImages': 'رفع صور الجهاز',
      'addPhotos': 'إضافة صور',
      'uploadPhotosOfAppliance': 'رفع صور جهازك',
      'imagesSelected': '{count} صور محددة',
      'selectDate': 'اختر التاريخ',
      'chooseDate': 'اختر تاريخاً',
      'selectTime': 'اختر الوقت',
      'chooseTime': 'اختر وقتاً',
      'enterServiceAddress': 'أدخل عنوان الخدمة',
      'additionalNotesOptional': 'ملاحظات إضافية (اختياري)',
      'anySpecialRequests': 'أي طلبات أو ملاحظات خاصة...',
      'requestSummary': 'ملخص الطلب',
      'date': 'التاريخ',
      'time': 'الوقت',
      'submitRequest': 'إرسال الطلب',
      'bookingConfirmed': 'تم تأكيد الحجز!',
      'serviceBookedSuccessfully': 'تم حجز خدمتك بنجاح',
      'backToHome': 'العودة للرئيسية',
      'viewBookings': 'عرض الحجوزات',
      'invoices': 'الفواتير',
      'noInvoicesYet': 'لا توجد فواتير بعد',
      'completeServiceToGenerate': 'أكمل خدمة لإنشاء الفواتير',
      'downloadShareInvoice': 'تحميل / مشاركة الفاتورة',
      'paid': 'مدفوع',
      'reviews': 'التقييمات',
      'myReviews': 'تقييماتي',
      'writeReview': 'اكتب تقييماً',
      'rateYourExperience': 'قيم تجربتك',
      'shareYourExperience': 'شارك تجربتك (اختياري)...',
      'noReviewsYet': 'لا توجد تقييمات بعد',
      'profile': 'الملف الشخصي',
      'editProfile': 'تعديل الملف الشخصي',
      'settings': 'الإعدادات',
      'notifications': 'الإشعارات',
      'language': 'اللغة',
      'darkMode': 'الوضع الداكن',
      'logout': 'تسجيل الخروج',
      'areYouSureLogout': 'هل أنت متأكد من تسجيل الخروج؟',
      'notificationsScreen': 'الإشعارات',
      'markAllRead': 'تحديد الكل كمقروء',
      'noNotifications': 'لا توجد إشعارات',
      'allCaughtUp': 'أنت على اطلاع بكل شيء!',
      'enableNotifications': 'تفعيل الإشعارات',
      'notNow': 'ليس الآن',
      'allow': 'السماح',
      'chatWithTechnician': 'محادثة مع الفني',
      'typeMessage': 'اكتب رسالة...',
      'cancelBooking': 'إلغاء الحجز',
      'keepBooking': 'الاحتفاظ بالحجز',
      'selectCancellationReason': 'يرجى اختيار سبب الإلغاء',
      'searchServices': 'بحث عن الخدمات...',
      'noServicesFound': 'لم يتم العثور على خدمات',
      'changeAddress': 'تغيير العنوان',
      'useCurrentLocation': 'استخدم موقعي الحالي',
      'selectCountryCode': 'اختر رمز الدولة',
      'continueToCheckout': 'متابعة الدفع',
      'addressUpdated': 'تم تحديث العنوان بنجاح!',
      'savedAddresses': 'العناوين المحفوظة',
      'editing': 'جاري التعديل',
      'enterYourAddress': 'أدخل عنوانك',
      'comingSoon': 'قريباً!',
      'addNewAddress': 'إضافة عنوان جديد',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'homeAddress': 'عنوان المنزل',

      // ADDED ALL MISSING KEYS
      'pleaseSelectDateTime': 'يرجى اختيار التاريخ والوقت',
      'errorPickingImages': 'خطأ في اختيار الصور',
      'errorTakingPhoto': 'خطأ في التقاط الصورة',
      'chooseImageSource': 'اختر مصدر الصورة',
      'gallery': 'المعرض',
      'camera': 'الكاميرا',
      'pleaseSelectBothDateAndTime': 'يرجى اختيار كل من التاريخ والوقت',
      'pleaseEnterYourAddress': 'يرجى إدخال عنوانك',
      'qty': 'الكمية',
      'uploadPhotosOfYourAppliance': 'رفع صور جهازك',
      'image': 'صورة',
      'images': 'الصور',
      'selected': 'محدد',
      'anySpecialRequestsOnNotes': 'أي طلبات أو ملاحظات خاصة...',
      'notSelected': 'غير محدد',
      'noImages': 'لا توجد صور',
      'holmages': 'الصور المحملة',
      'pleaseSelectDateFirst': 'يرجى اختيار التاريخ أولاً',
      'anySpecialRequestsOrNotes': 'أي طلبات أو ملاحظات خاصة...',
      'profileUpdated': 'تم تحديث الملف الشخصي بنجاح!',
      'pleaseEnterName': 'يرجى إدخال اسمك',
      'pleaseEnterEmail': 'يرجى إدخال بريدك الإلكتروني',
      'pleaseEnterValidEmail': 'يرجى إدخال بريد إلكتروني صالح',
      'phoneNumber': 'رقم الهاتف',
      'pleaseEnterPhone': 'يرجى إدخال رقم هاتفك',
      'saveChanges': 'حفظ التغييرات',
      'added': 'تمت الإضافة',
      'toCartSuccessfully': 'إلى السلة بنجاح',
      'whatsIncluded': 'المشمول في الخدمة',
      'notIncluded': 'غير مشمول',
      'anyTypeOfRepair': 'أي نوع من الإصلاح',
      'anyTypeOfMaterial': 'أي نوع من المواد',
      'ladder': 'سلم',
      'toCart': 'إلى السلة',
      'chooseMachineType': 'اختر نوع الجهاز',
      'washingMachine': 'غسالة ملابس',
      'viewServiceFor': 'عرض الخدمة لـ',
      'machines': 'الأجهزة',
      'tryAdjustingYourSearchTerms': 'حاول تعديل مصطلحات البحث الخاصة بك',
    },
  };

  // Getters for all strings
  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get homeServices => _localizedValues[locale.languageCode]!['homeServices']!;
  String get hello => _localizedValues[locale.languageCode]!['hello']!;
  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get notificationsEnabled => _localizedValues[locale.languageCode]!['notificationsEnabled']!;
  String get notificationDescription => _localizedValues[locale.languageCode]!['notificationDescription']!;
  String get gettingCurrentLocation => _localizedValues[locale.languageCode]!['gettingCurrentLocation']!;
  String get continueText => _localizedValues[locale.languageCode]!['continueText']!;
  String get technician => _localizedValues[locale.languageCode]!['technician']!;
  String get dateTime => _localizedValues[locale.languageCode]!['dateTime']!;
  String get currency => _localizedValues[locale.languageCode]!['currency']!;
  String get currencySymbol => _localizedValues[locale.languageCode]!['currencySymbol']!;
  String get phoneLogin => _localizedValues[locale.languageCode]!['phoneLogin']!;
  String get whatIsYourMobileNumber => _localizedValues[locale.languageCode]!['whatIsYourMobileNumber']!;
  String get enterMobileToSendCode => _localizedValues[locale.languageCode]!['enterMobileToSendCode']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get invalidNumber => _localizedValues[locale.languageCode]!['invalidNumber']!;
  String get otpVerification => _localizedValues[locale.languageCode]!['otpVerification']!;
  String get enterCodeSentToYou => _localizedValues[locale.languageCode]!['enterCodeSentToYou']!;
  String get confirmationCodeSent => _localizedValues[locale.languageCode]!['confirmationCodeSent']!;
  String get didntReceiveCode => _localizedValues[locale.languageCode]!['didntReceiveCode']!;
  String get resend => _localizedValues[locale.languageCode]!['resend']!;
  String get verify => _localizedValues[locale.languageCode]!['verify']!;
  String get completeYourProfile => _localizedValues[locale.languageCode]!['completeYourProfile']!;
  String get personalInformation => _localizedValues[locale.languageCode]!['personalInformation']!;
  String get fullName => _localizedValues[locale.languageCode]!['fullName']!;
  String get enterYourFullName => _localizedValues[locale.languageCode]!['enterYourFullName']!;
  String get emailAddress => _localizedValues[locale.languageCode]!['emailAddress']!;
  String get enterYourEmail => _localizedValues[locale.languageCode]!['enterYourEmail']!;
  String get deliveryAddress => _localizedValues[locale.languageCode]!['deliveryAddress']!;
  String get streetName => _localizedValues[locale.languageCode]!['streetName']!;
  String get floor => _localizedValues[locale.languageCode]!['floor']!;
  String get floorNumber => _localizedValues[locale.languageCode]!['floorNumber']!;
  String get apartment => _localizedValues[locale.languageCode]!['apartment']!;
  String get apartmentNumber => _localizedValues[locale.languageCode]!['apartmentNumber']!;
  String get otherInformation => _localizedValues[locale.languageCode]!['otherInformation']!;
  String get saveAddressAsPrimary => _localizedValues[locale.languageCode]!['saveAddressAsPrimary']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get work => _localizedValues[locale.languageCode]!['work']!;
  String get friend => _localizedValues[locale.languageCode]!['friend']!;
  String get saveContinue => _localizedValues[locale.languageCode]!['saveContinue']!;
  String get dashboard => _localizedValues[locale.languageCode]!['dashboard']!;
  String get ourServices => _localizedValues[locale.languageCode]!['ourServices']!;
  String get services => _localizedValues[locale.languageCode]!['services']!;
  String get service => _localizedValues[locale.languageCode]!['service']!;
  String get viewAllServices => _localizedValues[locale.languageCode]!['viewAllServices']!;
  String get serviceDetails => _localizedValues[locale.languageCode]!['serviceDetails']!;
  String get addToCart => _localizedValues[locale.languageCode]!['addToCart']!;
  String get addedToCart => _localizedValues[locale.languageCode]!['addedToCart']!;
  String get viewCart => _localizedValues[locale.languageCode]!['viewCart']!;
  String get orders => _localizedValues[locale.languageCode]!['orders']!;
  String get myOrders => _localizedValues[locale.languageCode]!['myOrders']!;
  String get activeOrders => _localizedValues[locale.languageCode]!['activeOrders']!;
  String get previousOrders => _localizedValues[locale.languageCode]!['previousOrders']!;
  String get noActiveOrders => _localizedValues[locale.languageCode]!['noActiveOrders']!;
  String get noPreviousOrders => _localizedValues[locale.languageCode]!['noPreviousOrders']!;
  String get bookYourFirstService => _localizedValues[locale.languageCode]!['bookYourFirstService']!;
  String get completedOrdersAppearHere => _localizedValues[locale.languageCode]!['completedOrdersAppearHere']!;
  String get bookNow => _localizedValues[locale.languageCode]!['bookNow']!;
  String get orderDetails => _localizedValues[locale.languageCode]!['orderDetails']!;
  String get orderId => _localizedValues[locale.languageCode]!['orderId']!;
  String get bookingDate => _localizedValues[locale.languageCode]!['bookingDate']!;
  String get serviceTime => _localizedValues[locale.languageCode]!['serviceTime']!;
  String get address => _localizedValues[locale.languageCode]!['address']!;
  String get serviceAddress => _localizedValues[locale.languageCode]!['serviceAddress']!;
  String get totalAmount => _localizedValues[locale.languageCode]!['totalAmount']!;
  String get estimatedPrice => _localizedValues[locale.languageCode]!['estimatedPrice']!;
  String get orderStatus => _localizedValues[locale.languageCode]!['orderStatus']!;
  String get trackOrder => _localizedValues[locale.languageCode]!['trackOrder']!;
  String get viewTechnicianDetails => _localizedValues[locale.languageCode]!['viewTechnicianDetails']!;
  String get servicesBooked => _localizedValues[locale.languageCode]!['servicesBooked']!;
  String get at => _localizedValues[locale.languageCode]!['at']!;
  String get imagesSelected => _localizedValues[locale.languageCode]!['imagesSelected']!;
  String get pending => _localizedValues[locale.languageCode]!['pending']!;
  String get confirmed => _localizedValues[locale.languageCode]!['confirmed']!;
  String get inProgress => _localizedValues[locale.languageCode]!['inProgress']!;
  String get completed => _localizedValues[locale.languageCode]!['completed']!;
  String get cancelled => _localizedValues[locale.languageCode]!['cancelled']!;
  String get bookingDone => _localizedValues[locale.languageCode]!['bookingDone']!;
  String get technicianAssigned => _localizedValues[locale.languageCode]!['technicianAssigned']!;
  String get workStarted => _localizedValues[locale.languageCode]!['workStarted']!;
  String get workDone => _localizedValues[locale.languageCode]!['workDone']!;
  String get cart => _localizedValues[locale.languageCode]!['cart']!;
  String get yourCartIsEmpty => _localizedValues[locale.languageCode]!['yourCartIsEmpty']!;
  String get addSomeServices => _localizedValues[locale.languageCode]!['addSomeServices']!;
  String get clearAll => _localizedValues[locale.languageCode]!['clearAll']!;
  String get clearCart => _localizedValues[locale.languageCode]!['clearCart']!;
  String get areYouSureRemoveAllItems => _localizedValues[locale.languageCode]!['areYouSureRemoveAllItems']!;
  String get proceedToCheckout => _localizedValues[locale.languageCode]!['proceedToCheckout']!;
  String get quantity => _localizedValues[locale.languageCode]!['quantity']!;
  String get total => _localizedValues[locale.languageCode]!['total']!;
  String get checkout => _localizedValues[locale.languageCode]!['checkout']!;
  String get bookService => _localizedValues[locale.languageCode]!['bookService']!;
  String get selectedServices => _localizedValues[locale.languageCode]!['selectedServices']!;
  String get uploadApplianceImages => _localizedValues[locale.languageCode]!['uploadApplianceImages']!;
  String get addPhotos => _localizedValues[locale.languageCode]!['addPhotos']!;
  String get uploadPhotosOfAppliance => _localizedValues[locale.languageCode]!['uploadPhotosOfAppliance']!;
  String get selectDate => _localizedValues[locale.languageCode]!['selectDate']!;
  String get chooseDate => _localizedValues[locale.languageCode]!['chooseDate']!;
  String get selectTime => _localizedValues[locale.languageCode]!['selectTime']!;
  String get chooseTime => _localizedValues[locale.languageCode]!['chooseTime']!;
  String get enterServiceAddress => _localizedValues[locale.languageCode]!['enterServiceAddress']!;
  String get additionalNotesOptional => _localizedValues[locale.languageCode]!['additionalNotesOptional']!;
  String get anySpecialRequests => _localizedValues[locale.languageCode]!['anySpecialRequests']!;
  String get requestSummary => _localizedValues[locale.languageCode]!['requestSummary']!;
  String get date => _localizedValues[locale.languageCode]!['date']!;
  String get time => _localizedValues[locale.languageCode]!['time']!;
  String get submitRequest => _localizedValues[locale.languageCode]!['submitRequest']!;
  String get bookingConfirmed => _localizedValues[locale.languageCode]!['bookingConfirmed']!;
  String get serviceBookedSuccessfully => _localizedValues[locale.languageCode]!['serviceBookedSuccessfully']!;
  String get backToHome => _localizedValues[locale.languageCode]!['backToHome']!;
  String get viewBookings => _localizedValues[locale.languageCode]!['viewBookings']!;
  String get invoices => _localizedValues[locale.languageCode]!['invoices']!;
  String get noInvoicesYet => _localizedValues[locale.languageCode]!['noInvoicesYet']!;
  String get completeServiceToGenerate => _localizedValues[locale.languageCode]!['completeServiceToGenerate']!;
  String get downloadShareInvoice => _localizedValues[locale.languageCode]!['downloadShareInvoice']!;
  String get paid => _localizedValues[locale.languageCode]!['paid']!;
  String get reviews => _localizedValues[locale.languageCode]!['reviews']!;
  String get myReviews => _localizedValues[locale.languageCode]!['myReviews']!;
  String get writeReview => _localizedValues[locale.languageCode]!['writeReview']!;
  String get rateYourExperience => _localizedValues[locale.languageCode]!['rateYourExperience']!;
  String get shareYourExperience => _localizedValues[locale.languageCode]!['shareYourExperience']!;
  String get noReviewsYet => _localizedValues[locale.languageCode]!['noReviewsYet']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get editProfile => _localizedValues[locale.languageCode]!['editProfile']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get notifications => _localizedValues[locale.languageCode]!['notifications']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get darkMode => _localizedValues[locale.languageCode]!['darkMode']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get areYouSureLogout => _localizedValues[locale.languageCode]!['areYouSureLogout']!;
  String get notificationsScreen => _localizedValues[locale.languageCode]!['notificationsScreen']!;
  String get markAllRead => _localizedValues[locale.languageCode]!['markAllRead']!;
  String get noNotifications => _localizedValues[locale.languageCode]!['noNotifications']!;
  String get allCaughtUp => _localizedValues[locale.languageCode]!['allCaughtUp']!;
  String get enableNotifications => _localizedValues[locale.languageCode]!['enableNotifications']!;
  String get notNow => _localizedValues[locale.languageCode]!['notNow']!;
  String get allow => _localizedValues[locale.languageCode]!['allow']!;
  String get chatWithTechnician => _localizedValues[locale.languageCode]!['chatWithTechnician']!;
  String get typeMessage => _localizedValues[locale.languageCode]!['typeMessage']!;
  String get cancelBooking => _localizedValues[locale.languageCode]!['cancelBooking']!;
  String get keepBooking => _localizedValues[locale.languageCode]!['keepBooking']!;
  String get selectCancellationReason => _localizedValues[locale.languageCode]!['selectCancellationReason']!;
  String get searchServices => _localizedValues[locale.languageCode]!['searchServices']!;
  String get noServicesFound => _localizedValues[locale.languageCode]!['noServicesFound']!;
  String get changeAddress => _localizedValues[locale.languageCode]!['changeAddress']!;
  String get useCurrentLocation => _localizedValues[locale.languageCode]!['useCurrentLocation']!;
  String get selectCountryCode => _localizedValues[locale.languageCode]!['selectCountryCode']!;
  String get continueToCheckout => _localizedValues[locale.languageCode]!['continueToCheckout']!;
  String get addressUpdated => _localizedValues[locale.languageCode]!['addressUpdated']!;
  String get savedAddresses => _localizedValues[locale.languageCode]!['savedAddresses']!;
  String get editing => _localizedValues[locale.languageCode]!['editing']!;
  String get enterYourAddress => _localizedValues[locale.languageCode]!['enterYourAddress']!;
  String get comingSoon => _localizedValues[locale.languageCode]!['comingSoon']!;
  String get addNewAddress => _localizedValues[locale.languageCode]!['addNewAddress']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get homeAddress => _localizedValues[locale.languageCode]!['homeAddress']!;

  // ADDED ALL MISSING GETTERS
  String get pleaseSelectDateTime => _localizedValues[locale.languageCode]!['pleaseSelectDateTime']!;
  String get errorPickingImages => _localizedValues[locale.languageCode]!['errorPickingImages']!;
  String get errorTakingPhoto => _localizedValues[locale.languageCode]!['errorTakingPhoto']!;
  String get chooseImageSource => _localizedValues[locale.languageCode]!['chooseImageSource']!;
  String get gallery => _localizedValues[locale.languageCode]!['gallery']!;
  String get camera => _localizedValues[locale.languageCode]!['camera']!;
  String get pleaseSelectBothDateAndTime => _localizedValues[locale.languageCode]!['pleaseSelectBothDateAndTime']!;
  String get pleaseEnterYourAddress => _localizedValues[locale.languageCode]!['pleaseEnterYourAddress']!;
  String get qty => _localizedValues[locale.languageCode]!['qty']!;
  String get uploadPhotosOfYourAppliance => _localizedValues[locale.languageCode]!['uploadPhotosOfYourAppliance']!;
  String get image => _localizedValues[locale.languageCode]!['image']!;
  String get images => _localizedValues[locale.languageCode]!['images']!;
  String get selected => _localizedValues[locale.languageCode]!['selected']!;
  String get anySpecialRequestsOnNotes => _localizedValues[locale.languageCode]!['anySpecialRequestsOnNotes']!;
  String get notSelected => _localizedValues[locale.languageCode]!['notSelected']!;
  String get noImages => _localizedValues[locale.languageCode]!['noImages']!;
  String get holmages => _localizedValues[locale.languageCode]!['holmages']!;
  String get pleaseSelectDateFirst => _localizedValues[locale.languageCode]!['pleaseSelectDateFirst']!;
  String get anySpecialRequestsOrNotes => _localizedValues[locale.languageCode]!['anySpecialRequestsOrNotes']!;
  String get profileUpdated => _localizedValues[locale.languageCode]!['profileUpdated']!;
  String get pleaseEnterName => _localizedValues[locale.languageCode]!['pleaseEnterName']!;
  String get pleaseEnterEmail => _localizedValues[locale.languageCode]!['pleaseEnterEmail']!;
  String get pleaseEnterValidEmail => _localizedValues[locale.languageCode]!['pleaseEnterValidEmail']!;
  String get phoneNumber => _localizedValues[locale.languageCode]!['phoneNumber']!;
  String get pleaseEnterPhone => _localizedValues[locale.languageCode]!['pleaseEnterPhone']!;
  String get saveChanges => _localizedValues[locale.languageCode]!['saveChanges']!;
  String get added => _localizedValues[locale.languageCode]!['added']!;
  String get toCartSuccessfully => _localizedValues[locale.languageCode]!['toCartSuccessfully']!;
  String get whatsIncluded => _localizedValues[locale.languageCode]!['whatsIncluded']!;
  String get notIncluded => _localizedValues[locale.languageCode]!['notIncluded']!;
  String get anyTypeOfRepair => _localizedValues[locale.languageCode]!['anyTypeOfRepair']!;
  String get anyTypeOfMaterial => _localizedValues[locale.languageCode]!['anyTypeOfMaterial']!;
  String get ladder => _localizedValues[locale.languageCode]!['ladder']!;
  String get toCart => _localizedValues[locale.languageCode]!['toCart']!;
  String get chooseMachineType => _localizedValues[locale.languageCode]!['chooseMachineType']!;
  String get washingMachine => _localizedValues[locale.languageCode]!['washingMachine']!;
  String get viewServiceFor => _localizedValues[locale.languageCode]!['viewServiceFor']!;
  String get machines => _localizedValues[locale.languageCode]!['machines']!;
  String get tryAdjustingYourSearchTerms => _localizedValues[locale.languageCode]!['tryAdjustingYourSearchTerms']!;
  String get viewServicesFor => _localizedValues[locale.languageCode]!['viewServicesFor']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsExtension on AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();
}