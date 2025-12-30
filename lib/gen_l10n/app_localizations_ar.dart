// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'هاندي مان';

  @override
  String get homeServices => 'خدمات منزلية';

  @override
  String get hello => 'مرحباً';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get whatIsYourMobileNumber => 'ما هو رقم هاتفك المحمول؟';

  @override
  String get enterMobileNumberToSendCode =>
      'أدخل رقم هاتفك المحمول لإرسال رمز التفعيل إليك';

  @override
  String get invalidNumber => 'رقم غير صالح';

  @override
  String get pleaseEnterCompleteOtp => 'يرجى إدخال رمز التحقق كاملاً';

  @override
  String get otpSentSuccessfully => 'تم إرسال رمز التحقق بنجاح!';

  @override
  String get enterCodeSentToYou => 'أدخل الرمز المرسل إليك';

  @override
  String get confirmationCodeSentTo => 'تم إرسال رمز التأكيد إلى';

  @override
  String get didntReceiveCode => 'لم تستلم الرمز؟';

  @override
  String get resend => 'إعادة إرسال';

  @override
  String get completeYourProfile => 'أكمل ملفك الشخصي';

  @override
  String get personalInformation => 'المعلومات الشخصية';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get enterYourFullName => 'أدخل اسمك الكامل';

  @override
  String get pleaseEnterYourName => 'الرجاء إدخال اسمك';

  @override
  String get emailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get pleaseEnterYourEmail => 'الرجاء إدخال بريدك الإلكتروني';

  @override
  String get pleaseEnterValidEmail => 'الرجاء إدخال بريد إلكتروني صالح';

  @override
  String get deliveryAddress => 'عنوان التسليم';

  @override
  String get streetName => 'اسم الشارع';

  @override
  String get pleaseEnterStreetName => 'الرجاء إدخال اسم الشارع';

  @override
  String get floor => 'الطابق';

  @override
  String get floorNumber => 'رقم الطابق';

  @override
  String get apartment => 'الشقة';

  @override
  String get apartmentNumber => 'رقم الشقة';

  @override
  String get otherInformation => 'معلومات أخرى';

  @override
  String get saveAddressAsPrimary => 'حفظ العنوان كعنوان أساسي';

  @override
  String get home => 'المنزل';

  @override
  String get work => 'العمل';

  @override
  String get friend => 'صديق';

  @override
  String get saveAndContinue => 'حفظ ومتابعة';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get ourServices => 'خدماتنا';

  @override
  String get services => 'خدمات';

  @override
  String get viewAllServices => 'عرض جميع الخدمات';

  @override
  String get orders => 'الطلبات';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get active => 'نشط';

  @override
  String get previous => 'السابق';

  @override
  String get noActiveOrders => 'لا توجد طلبات نشطة';

  @override
  String get bookYourFirstServiceToday => 'احجز خدمتك الأولى اليوم!';

  @override
  String get noPreviousOrders => 'لا توجد طلبات سابقة';

  @override
  String get yourCompletedOrdersWillAppearHere => 'ستظهر طلباتك المكتملة هنا';

  @override
  String get bookNow => 'احجز الآن';

  @override
  String get servicesBooked => 'خدمات محجوزة';

  @override
  String get serviceBooked => 'خدمة محجوزة';

  @override
  String get bookingDone => 'تم الحجز';

  @override
  String get technicianAssigned => 'تم تعيين الفني';

  @override
  String get workStarted => 'بدأ العمل';

  @override
  String get workDone => 'تم العمل';

  @override
  String get cancelled => 'ملغى';

  @override
  String get postponed => 'مؤجل';

  @override
  String get trackOrder => 'تتبع الطلب';

  @override
  String get viewTechnicianDetails => 'عرض تفاصيل الفني';

  @override
  String get invoices => 'الفواتير';

  @override
  String get noInvoicesYet => 'لا توجد فواتير بعد';

  @override
  String get completeServiceToGenerateInvoices => 'أكمل خدمة لإنشاء الفواتير';

  @override
  String get invoice => 'فاتورة';

  @override
  String get invoiceNumber => 'رقم الفاتورة #';

  @override
  String get amount => 'المبلغ';

  @override
  String get paid => 'مدفوع';

  @override
  String get downloadShareInvoice => 'تحميل الفاتورة';

  @override
  String get reviews => 'التقييمات';

  @override
  String get myReviews => 'تقييماتي';

  @override
  String get toReview => 'للتقييم';

  @override
  String get noServicesToReview => 'لا توجد خدمات للتقييم';

  @override
  String get completeServicesToLeaveReviews => 'أكمل الخدمات لترك التقييمات';

  @override
  String completedOn(String date) {
    return 'اكتملت في $date';
  }

  @override
  String get writeAReview => 'اكتب تقييماً';

  @override
  String get noReviewsYet => 'لا توجد تقييمات بعد';

  @override
  String get yourReviewsWillAppearHere => 'ستظهر تقييماتك هنا';

  @override
  String get rateYourExperience => 'قيّم تجربتك';

  @override
  String get tapToRate => 'اضغط للتقييم';

  @override
  String get excellent => 'ممتاز!';

  @override
  String get veryGood => 'جيد جداً!';

  @override
  String get good => 'جيد';

  @override
  String get fair => 'مقبول';

  @override
  String get poor => 'ضعيف';

  @override
  String get shareYourExperience => 'شارك تجربتك (اختياري)...';

  @override
  String get cancel => 'إلغاء';

  @override
  String get submit => 'إرسال';

  @override
  String get thankYouForYourReview => 'شكراً لك على تقييمك!';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get manageNotificationPreferences => 'إدارة تفضيلات الإشعارات';

  @override
  String get savedAddresses => 'العناوين المحفوظة';

  @override
  String get paymentMethods => 'طرق الدفع';

  @override
  String get managePaymentOptions => 'إدارة خيارات الدفع';

  @override
  String get helpAndSupport => 'المساعدة والدعم';

  @override
  String get getHelpAndContactUs => 'احصل على المساعدة واتصل بنا';

  @override
  String get about => 'حول';

  @override
  String get appVersionAndInformation => 'إصدار التطبيق والمعلومات';

  @override
  String get areYouSureYouWantToLogout => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cart => 'السلة';

  @override
  String get yourCartIsEmpty => 'سلتك فارغة';

  @override
  String get addSomeServicesToGetStarted => 'أضف بعض الخدمات للبدء';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get areYouSureYouWantToRemoveAllItems =>
      'هل أنت متأكد أنك تريد إزالة جميع العناصر؟';

  @override
  String get clear => 'مسح';

  @override
  String get total => 'المجموع';

  @override
  String get proceedToCheckout => 'المتابعة إلى الدفع';

  @override
  String get bookService => 'حجز خدمة';

  @override
  String get selectedServices => 'الخدمات المحددة';

  @override
  String get uploadApplianceImages => 'تحميل صور الجهاز';

  @override
  String get addPhotos => 'إضافة صور';

  @override
  String get uploadPhotosOfYourAppliance => 'قم بتحميل صور جهازك';

  @override
  String get imagesSelected => 'صور محددة';

  @override
  String get imageSelected => 'صورة محددة';

  @override
  String get gallery => 'المعرض';

  @override
  String get camera => 'الكاميرا';

  @override
  String get chooseImageSource => 'اختر مصدر الصورة';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get chooseADate => 'اختر تاريخاً';

  @override
  String get selectTime => 'اختر الوقت';

  @override
  String get chooseATime => 'اختر وقتاً';

  @override
  String get serviceAddress => 'عنوان الخدمة';

  @override
  String get enterServiceAddress => 'أدخل عنوان الخدمة';

  @override
  String get additionalNotesOptional => 'ملاحظات إضافية (اختياري)';

  @override
  String get anySpecialRequestsOrNotes => 'أي طلبات خاصة أو ملاحظات...';

  @override
  String get requestSummary => 'ملخص الطلب';

  @override
  String get date => 'التاريخ';

  @override
  String get time => 'الوقت';

  @override
  String get notSelected => 'غير محدد';

  @override
  String get images => 'الصور';

  @override
  String get noImages => 'لا توجد صور';

  @override
  String get estimatedPrice => 'السعر التقديري';

  @override
  String get submitRequest => 'إرسال الطلب';

  @override
  String get pleaseSelectBothDateAndTime => 'الرجاء تحديد كل من التاريخ والوقت';

  @override
  String get pleaseEnterYourAddress => 'الرجاء إدخال عنوانك';

  @override
  String get bookingConfirmed => 'تم تأكيد الحجز!';

  @override
  String get yourServiceHasBeenSuccessfullyBooked => 'تم حجز خدمتك بنجاح';

  @override
  String yourServicesHaveBeenSuccessfullyBooked(int count) {
    return 'تم حجز خدمتك بنجاح';
  }

  @override
  String get bookingDetails => 'تفاصيل الحجز';

  @override
  String get service => 'الخدمة';

  @override
  String get quantity => 'الكمية';

  @override
  String get totalAmount => 'المجموع:';

  @override
  String get whatsNext => 'ما التالي؟';

  @override
  String get youWillReceiveConfirmationEmailShortly =>
      'ستتلقى بريداً إلكترونياً للتأكيد قريباً';

  @override
  String get reminderWillBeSent24HoursBefore => 'سيتم إرسال تذكير قبل 24 ساعة';

  @override
  String get viewYourBookingsInOrdersSection => 'اعرض حجوزاتك في قسم الطلبات';

  @override
  String get backToHome => 'العودة إلى الرئيسية';

  @override
  String get viewBookings => 'عرض الحجوزات';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get orderNumber => 'طلب رقم';

  @override
  String get servicesList => 'قائمة الخدمات';

  @override
  String get bookingDate => 'تاريخ الحجز';

  @override
  String get serviceTime => 'وقت الخدمة';

  @override
  String get address => 'العنوان';

  @override
  String get orderStatus => 'حالة الطلب';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get confirmed => 'مؤكد';

  @override
  String get inProgress => 'قيد التنفيذ';

  @override
  String get completed => 'مكتمل';

  @override
  String get bookingReceived => 'تم استلام الحجز';

  @override
  String get simulateAssignTechnician => 'محاكاة: تعيين فني';

  @override
  String get simulateStartWork => 'محاكاة: بدء العمل';

  @override
  String get simulateCompleteWork => 'محاكاة: إكمال العمل';

  @override
  String get technician => 'الفني';

  @override
  String get ordersDone => 'الطلبات المكتملة';

  @override
  String get experience => 'الخبرة';

  @override
  String get viewProfile => 'عرض الملف';

  @override
  String get chat => 'محادثة';

  @override
  String get facedAnyEmergency => 'واجهت أي حالة طوارئ؟';

  @override
  String get cancelBooking => 'إلغاء الحجز';

  @override
  String get pleaseSelectReasonForCancellation => 'الرجاء تحديد سبب الإلغاء';

  @override
  String get changeOfPlans => 'تغيير في الخطط';

  @override
  String get foundBetterService => 'وجدت خدمة أفضل';

  @override
  String get incorrectBookingDetails => 'تفاصيل حجز غير صحيحة';

  @override
  String get emergencySituation => 'حالة طوارئ';

  @override
  String get priceTooHigh => 'السعر مرتفع جداً';

  @override
  String get technicianNotAvailable => 'الفني غير متاح';

  @override
  String get serviceNoLongerNeeded => 'الخدمة لم تعد مطلوبة';

  @override
  String get otherReason => 'سبب آخر';

  @override
  String get cancellationMayIncurCharges => 'قد يترتب على الإلغاء رسوم';

  @override
  String get keepBooking => 'الاحتفاظ بالحجز';

  @override
  String get bookingCancelled => 'تم إلغاء الحجز';

  @override
  String get yourBookingHasBeenCancelledSuccessfully => 'تم إلغاء حجزك بنجاح';

  @override
  String get reason => 'السبب';

  @override
  String get done => 'تم';

  @override
  String get areYouSureCancel =>
      'Are you sure you want to cancel this booking?';

  @override
  String get yesCancel => 'Yes, Cancel';

  @override
  String get no => 'No';

  @override
  String get vendorProfile => 'ملف البائع';

  @override
  String get professionalTechnician => 'فني محترف';

  @override
  String get timePeriod => 'فترة زمنية';

  @override
  String get profileVerified => 'تم التحقق من الملف الشخصي';

  @override
  String get policeVerified => 'تم التحقق من الشرطة';

  @override
  String get servicesProvide => 'الخدمات المقدمة';

  @override
  String get orderDone => 'طلب مكتمل';

  @override
  String get typeAMessage => 'اكتب رسالة...';

  @override
  String get noMessagesYet => 'لا توجد رسائل بعد';

  @override
  String startConversationWith(String name) {
    return 'ابدأ محادثة مع $name';
  }

  @override
  String get justNow => 'الآن';

  @override
  String get callingTechnician => 'جاري الاتصال بالفني...';

  @override
  String get helloIWillBeArrivingIn30Minutes =>
      'مرحباً! سأصل خلال 30 دقيقة. يرجى إبقاء منطقة الخدمة جاهزة.';

  @override
  String get okayNotedThankYou => 'حسناً، تم التسجيل. شكراً لك!';

  @override
  String mAgo(int minutes) {
    return 'قبل $minutes د';
  }

  @override
  String hAgo(int hours) {
    return 'قبل $hours س';
  }

  @override
  String get enableNotifications => 'تفعيل الإشعارات';

  @override
  String get getRealTimeUpdatesAboutYourBookings =>
      'احصل على تحديثات فورية حول حجوزاتك';

  @override
  String get notNow => 'ليس الآن';

  @override
  String get allow => 'السماح';

  @override
  String get notificationsEnabledSuccessfully => 'تم تفعيل الإشعارات بنجاح';

  @override
  String get noNotifications => 'لا توجد إشعارات';

  @override
  String get youreAllCaughtUp => 'أنت على اطلاع بكل شيء!';

  @override
  String get markAllRead => 'تحديد الكل كمقروء';

  @override
  String get clearAllNotifications => 'مسح جميع الإشعارات';

  @override
  String get areYouSureYouWantToClearAllNotifications =>
      'هل أنت متأكد أنك تريد مسح جميع الإشعارات؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get newNotifications => 'جديد';

  @override
  String youHaveUnreadNotifications(int count) {
    return 'لديك \$COUNT\$ إشعار غير مقروء';
  }

  @override
  String get notificationDeleted => 'تم حذف الإشعار';

  @override
  String get undo => 'تراجع';

  @override
  String get serviceDetail => 'تفاصيل الخدمة';

  @override
  String get whatsIncluded => 'ما هو مدرج';

  @override
  String get notIncluded => 'غير مدرج';

  @override
  String get anyTypeOfRepair => 'أي نوع من الإصلاح';

  @override
  String get anyTypeOfMaterial => 'أي نوع من المواد';

  @override
  String get ladder => 'سلم';

  @override
  String get addToCart => 'إضافة إلى السلة';

  @override
  String addedToCartSuccessfully(String serviceName) {
    return 'تمت إضافة $serviceName إلى السلة بنجاح!';
  }

  @override
  String get viewCart => 'عرض السلة';

  @override
  String get searchServices => 'البحث عن خدمات...';

  @override
  String get noServicesFound => 'لم يتم العثور على خدمات';

  @override
  String get tryAdjustingYourSearchTerms =>
      'حاول تعديل مصطلحات البحث الخاصة بك';

  @override
  String get chooseMachineType => 'اختر نوع الآلة';

  @override
  String viewServicesForMachines(String type) {
    return 'عرض خدمات آلات $type';
  }

  @override
  String get washingMachine => 'غسالة';

  @override
  String get continueToCheckout => 'المتابعة إلى الدفع';

  @override
  String get homeAddress => 'عنوان المنزل';

  @override
  String get editing => 'التحرير';

  @override
  String get enterYourAddress => 'أدخل عنوانك';

  @override
  String get save => 'حفظ';

  @override
  String get addressUpdatedSuccessfully => 'تم تحديث العنوان بنجاح!';

  @override
  String get addNewAddress => 'إضافة عنوان جديد';

  @override
  String get addNewAddressFeatureComingSoon => 'ميزة إضافة عنوان جديد قريباً!';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get profileUpdatedSuccessfully => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get pleaseEnterYourPhoneNumber => 'الرجاء إدخال رقم هاتفك';

  @override
  String get phoneNumberMustContainOnlyDigits =>
      'يجب أن يحتوي رقم الهاتف على أرقام فقط';

  @override
  String get serviceExpertise => 'الخبرة في الخدمة';

  @override
  String previouslyCompletedServicesBy(String name) {
    return 'الخدمات المكتملة سابقًا بواسطة $name';
  }

  @override
  String get doneCount => 'مكتمل';

  @override
  String get kmAway => 'كم بعيداً';

  @override
  String get serviceLocation => 'موقع الخدمة';

  @override
  String get acServices => 'خدمات مكيفات الهواء';

  @override
  String get homeAppliances => 'أجهزة منزلية';

  @override
  String get plumbing => 'سباكة';

  @override
  String get electric => 'الكهرباء';

  @override
  String get splitAc => 'مكيف سبليت';

  @override
  String get windowAc => 'مكيف نافذة';

  @override
  String get centralAc => 'مكيف مركزي';

  @override
  String get refrigerator => 'ثلاجة';

  @override
  String get oven => 'فرن';

  @override
  String get stove => 'موقد';

  @override
  String get dishwasher => 'غسالة صحون';

  @override
  String get automatic => 'أوتوماتيكي';

  @override
  String get regular => 'عادي';

  @override
  String get semiAutomatic => 'شبه أوتوماتيكي';

  @override
  String get topLoad => 'تحميل علوي';

  @override
  String get frontLoad => 'تحميل أمامي';

  @override
  String get pipeRepair => 'إصلاح الأنابيب';

  @override
  String get drainCleaning => 'تنظيف المصارف';

  @override
  String get waterHeater => 'سخان المياه';

  @override
  String get faucetInstallation => 'تركيب الحنفيات';

  @override
  String get wiring => 'الأسلاك';

  @override
  String get switchSocket => 'المفاتيح والمقابس';

  @override
  String get circuitBreaker => 'قاطع الدائرة';

  @override
  String get lightingInstallation => 'تركيب الإضاءة';

  @override
  String get serviceManagement => 'إدارة الخدمات';

  @override
  String get categories => 'الفئات';

  @override
  String get subcategories => 'الفئات الفرعية';

  @override
  String servicesCount(int count) {
    return '\$COUNT\$ خدمات';
  }

  @override
  String get acWashing => 'غسيل مكيف الهواء (تنظيف الوحدة الداخلية والخارجية)';

  @override
  String get repairingLeaks => 'إصلاح التسريبات';

  @override
  String get cleaningWithFreon => 'تنظيف جميع الوحدات + تعبئة الفريون';

  @override
  String get installNewAc => 'تركيب مكيف هواء جديد';

  @override
  String get disassembleInside => 'تفكيك وتجميع (داخل المنزل)';

  @override
  String get disassembleOutside => 'تفكيك وتجميع (خارج المنزل)';

  @override
  String get electronicBoardService => 'تفكيك وتجميع اللوحة الإلكترونية';

  @override
  String get externalFanService => 'إزالة وتركيب المروحة الخارجية';

  @override
  String get changeDynamo => 'تغيير الدينامو (الخارجي)';

  @override
  String get acWash => 'غسيل مكيف الهواء';

  @override
  String get sewerCleaning => 'تنظيف المجاري';

  @override
  String get installCabinetAc => 'تركيب مكيف الهواء الخزانة';

  @override
  String get cassetteAcInstallation => 'تركيب مكيف هواء كاسيت';

  @override
  String get changeSplitCrystal => 'تغيير الكريستال الداخلي للسبليت';

  @override
  String get changeInternalEngine => 'تغيير دينامو المحرك الداخلي';

  @override
  String get changeCompressor => 'تغيير الضاغط 36-48-60 وحدة';

  @override
  String get changeComponents =>
      'تغيير الأسطوانة - الملف - الأسطوانة - البطارية';

  @override
  String get changeContactor => 'تغيير وتركيب الكونتاكتور';

  @override
  String get disassembleElectronicBoard => 'تفكيك وتجميع اللوحة الإلكترونية';

  @override
  String get disassembleDryingMachine => 'تفكيك وتجميع آلة التجفيف';

  @override
  String get disassembleWashingMachine => 'تفكيك وتجميع الغسالة';

  @override
  String get doorDisassembly => 'تفكيك وتركيب الباب';

  @override
  String get balanceBarService => 'تفكيك وتركيب شريط التوازن';

  @override
  String get waterDrainageMaintenance => 'صيانة تصريف المياه';

  @override
  String get waterFlowMaintenance => 'صيانة تدفق المياه';

  @override
  String get electricalShortCircuit => 'صيانة الدائرة القصيرة الكهربائية';

  @override
  String get powerSupplyRepair => 'إصلاح مصدر الطاقة';

  @override
  String get disassembleTimer => 'تفكيك وتجميع المؤقت';

  @override
  String get compressorChange => 'تغيير الضاغط';

  @override
  String get changeExternalFan => 'تغيير المروحة الخارجية';

  @override
  String get changeInternalFan => 'تغيير المروحة الداخلية';

  @override
  String get changeHeater => 'تغيير السخان';

  @override
  String get changeSensor => 'تغيير مستشعر \"الضاغط\"';

  @override
  String get americanFreonFilling => 'تعبئة الفريون الأمريكي';

  @override
  String get indianFreonFilling => 'تعبئة الفريون الهندي';

  @override
  String get externalLeakageMaintenance => 'صيانة التسرب الخارجي';

  @override
  String get changeTimer => 'تغيير وضبط المؤقت';

  @override
  String get smallCompressorReplacement =>
      'استبدال ضاغط الثلاجة 1/6 - 1/5 - 1/4 - 1/3';

  @override
  String get largeCompressorReplacement => 'استبدال ضاغط الثلاجة 1/2 - 3/4 - 1';

  @override
  String get leakRepairAmericanR134 =>
      'صيانة التسرب الخارجي + تعبئة الفريون الأمريكي R134';

  @override
  String get leakRepairAmericanR12 =>
      'صيانة التسرب الخارجي + تعبئة الفريون الأمريكي R12';

  @override
  String get leakRepairChineseR134 =>
      'صيانة التسرب الخارجي + تعبئة الفريون الصيني R134';

  @override
  String get leakRepairChineseR12 =>
      'صيانة التسرب الخارجي + تعبئة الفريون الصيني R12';

  @override
  String get leakRepairIndianR134 =>
      'صيانة التسرب الخارجي + تعبئة الفريون الهندي R134';

  @override
  String get changeKeys => 'تغيير المفاتيح';

  @override
  String get changeDoorHinges => 'تغيير مفصلات الباب';

  @override
  String get ovenCleaning => 'التنظيف';

  @override
  String get smugglingMaintenance => 'صيانة التسرب';

  @override
  String get microwaveMaintenance => 'صيانة الميكروويف';

  @override
  String get yourCompletedOrderWillAppearHere =>
      'Your completed orders will appear here';

  @override
  String get completeCleaningService => 'خدمة تنظيف كاملة';

  @override
  String get leakRepairService => 'خدمة إصلاح التسرب';

  @override
  String get acServicesDescription => 'تركيب وصيانة مكيفات الهواء الاحترافية';

  @override
  String get homeAppliancesDescription =>
      'خدمات إصلاح الأجهزة المنزلية الكاملة';

  @override
  String get plumbingDescription => 'خدمات السباكة الخبيرة';

  @override
  String get electricDescription => 'خدمات كهربائية احترافية';

  @override
  String get completeServiceWithGasRefill => 'خدمة كاملة مع تعبئة الغاز';

  @override
  String get professionalInstallation => 'تركيب احترافي';

  @override
  String get indoorMountingService => 'تركيب/فك داخلي';

  @override
  String get outdoorMountingService => 'تركيب/فك خارجي';

  @override
  String get controlBoardRepair => 'إصلاح لوحة التحكم';

  @override
  String get externalMotorReplacement => 'استبدال المحرك الخارجي';

  @override
  String get completeCleaning => 'تنظيف كامل';

  @override
  String get serviceWithGasRefill => 'خدمة مع تعبئة الغاز';

  @override
  String get installationService => 'خدمة التركيب';

  @override
  String get drainPipeCleaning => 'تنظيف أنبوب الصرف';

  @override
  String get cabinetInstallation => 'تركيب الخزانة';

  @override
  String get controlBoardService => 'خدمة لوحة التحكم';

  @override
  String get cassetteTypeInstallation => 'تركيب نوع الكاسيت';

  @override
  String get indoorUnitCrystalReplacement => 'استبدال الكريستال الداخلي';

  @override
  String get internalMotorReplacement => 'استبدال المحرك الداخلي';

  @override
  String get compressorReplacementLarge => 'استبدال الضاغط (كبير)';

  @override
  String get majorComponentReplacement => 'استبدال المكونات الرئيسية';

  @override
  String get contactorReplacement => 'استبدال الكونتاكتور';

  @override
  String get balanceBarServiceDesc => 'خدمة شريط التوازن';

  @override
  String get drainSystemService => 'خدمة نظام الصرف';

  @override
  String get waterInletService => 'خدمة مدخل المياه';

  @override
  String get electricalRepair => 'إصلاح كهربائي';

  @override
  String get powerSystemRepair => 'إصلاح نظام الطاقة';

  @override
  String get timerRepair => 'إصلاح المؤقت';

  @override
  String get dryerService => 'خدمة المجفف';

  @override
  String get compressorReplacement => 'استبدال الضاغط';

  @override
  String get externalFanReplacement => 'استبدال المروحة الخارجية';

  @override
  String get internalFanReplacement => 'استبدال المروحة الداخلية';

  @override
  String get heaterReplacement => 'استبدال السخان';

  @override
  String get sensorReplacement => 'استبدال المستشعر';

  @override
  String get fanReplacement => 'استبدال المروحة';

  @override
  String get professionalsService => 'خدمة احترافية';

  @override
  String get testingIncluded => 'يشمل الاختبار';

  @override
  String get motorReplacement => 'استبدال المحرك';

  @override
  String get qualityParts => 'قطع غيار عالية الجودة';

  @override
  String get expertservice => 'خدمة خبيرة';

  @override
  String get deepCleaning => 'تنظيف عميق';

  @override
  String get filterCleaning => 'تنظيف الفلتر';

  @override
  String get performanceCheck => 'فحص الأداء';

  @override
  String get leakDetection => 'كشف التسرب';

  @override
  String get professionalRepair => 'إصلاح احترافي';

  @override
  String get teakRepair => 'إصلاح التسرب';

  @override
  String get teakDetection => 'كشف التسرب';

  @override
  String get professionalsRepair => 'إصلاح احترافي';

  @override
  String get testing => 'اختبار';

  @override
  String get cleaning => 'تنظيف';

  @override
  String get gasRefill => 'تعبئة الغاز';

  @override
  String get performanceOptimization => 'تحسين الأداء';

  @override
  String get indoorUnitCleaning => 'تنظيف الوحدة الداخلية';

  @override
  String get outdoorUnitCleaning => 'تنظيف الوحدة الخارجية';

  @override
  String get warrantyIncluded => 'يشمل الضمان';

  @override
  String get indoorService => 'خدمة داخلية';

  @override
  String get professionalTools => 'أدوات احترافية';

  @override
  String get safeHandling => 'معالجة آمنة';

  @override
  String get outdoorService => 'خدمة خارجية';

  @override
  String get safetyEquipment => 'معدات السلامة';

  @override
  String get expertTechnicians => 'فنيون خبراء';

  @override
  String get electronicRepair => 'إصلاح إلكتروني';

  @override
  String get cleanFinish => 'إنهاء نظيف';

  @override
  String get quickService => 'خدمة سريعة';

  @override
  String get pipeUnclogging => 'إزالة انسداد الأنابيب';

  @override
  String get completeSetup => 'إعداد كامل';

  @override
  String get boardReplacement => 'استبدال اللوحة';

  @override
  String get crystalReplacement => 'استبدال الكريستال';

  @override
  String get componentReplacement => 'استبدال المكونات';

  @override
  String get boardRepair => 'إصلاح اللوحة';

  @override
  String get dryerRepair => 'إصلاح المجفف';

  @override
  String get completeDisassembly => 'تفكيك كامل';

  @override
  String get reassembly => 'إعادة التجميع';

  @override
  String get doorRepair => 'إصلاح الباب';

  @override
  String get sealReplacement => 'استبدال السدادة';

  @override
  String get alignmentCheck => 'فحص المحاذاة';

  @override
  String get balanceBarReplacement => 'استبدال شريط التوازن';

  @override
  String get vibrationReduction => 'تقليل الاهتزاز';

  @override
  String get pumpCheck => 'فحص المضخة';

  @override
  String get inletValveService => 'خدمة صمام المدخل';

  @override
  String get waterFlowOptimization => 'تحسين تدفق المياه';

  @override
  String get electricalDiagnosis => 'تشخيص كهربائي';

  @override
  String get wiringRepair => 'إصلاح الأسلاك';

  @override
  String get safetyCheck => 'فحص السلامة';

  @override
  String get componentCheck => 'فحص المكونات';

  @override
  String get timerReplacement => 'استبدال المؤقت';

  @override
  String get fullService => 'خدمة كاملة';

  @override
  String get expertService => 'خدمة خبيرة';

  @override
  String get professionalService => 'خدمة احترافية';

  @override
  String get textRepair => 'إصلاح النص';

  @override
  String get completeinstallation => 'Complete Installation';

  @override
  String get professionalSetup => 'إعداد احترافي';

  @override
  String get completeservice => 'خدمة كاملة';

  @override
  String get leakRepair => 'إصلاح التسرب';

  @override
  String get completeInstallation => 'تركيب كامل';

  @override
  String get completeService => 'خدمة كاملة';

  @override
  String get selectLocation => 'اختر الموقع';

  @override
  String get selectedLocation => 'الموقع المحدد';

  @override
  String get tapOnMapToSelectLocation => 'اضغط على الخريطة لتحديد الموقع';

  @override
  String get tapToChangeLocation => 'انقر لتغيير الموقع';

  @override
  String get confirmLocation => 'تأكيد الموقع';

  @override
  String get tapToSelectOnMap => 'انقر للتحديد على الخريطة';

  @override
  String get pleaseSelectLocationFromMap => 'يرجى تحديد الموقع من الخريطة';

  @override
  String get tapMapIconToSelectLocation =>
      'انقر على أيقونة الخريطة لتحديد الموقع';

  @override
  String get addressType => 'نوع العنوان';

  @override
  String get additionalLocationDetails =>
      'تفاصيل إضافية عن الموقع (معلم، اسم المبنى، إلخ)';

  @override
  String get selectOnMap => 'تحديد على الخريطة';

  @override
  String get chooseExactLocationOnMap => 'اختر الموقع الدقيق على الخريطة';

  @override
  String get useCurrentLocation => 'استخدم الموقع الحالي';

  @override
  String get detectYourCurrentLocation => 'اكتشف موقعك الحالي تلقائياً';

  @override
  String get continueText => 'متابعة';

  @override
  String get selectDeliveryLocation => 'اختر موقع التسليم';

  @override
  String get hasBeenSaved => 'تم الحفظ';

  @override
  String get cartWithCount => 'السلة (\$COUNT\$)';

  @override
  String get dateAndTime => 'التاريخ والوقت';

  @override
  String get pleaseSelectADateFirst => 'الرجاء تحديد التاريخ أولاً';

  @override
  String get errorPickingImages => 'خطأ في اختيار الصور';

  @override
  String get errorTakingPhoto => 'خطأ في التقاط الصورة';

  @override
  String get other => 'أخرى';

  @override
  String get years => 'سنوات';

  @override
  String get qty => 'الكمية';

  @override
  String get electricalServices => 'خدمات كهربائية';

  @override
  String get splitAcServices => 'خدمات مكيف سبليت';

  @override
  String get windowAcServices => 'خدمات مكيف شباك';

  @override
  String get packageAcServices => 'خدمات مكيف باكج';

  @override
  String get washingMachineServices => 'خدمات الغسالات';

  @override
  String get refrigeratorServices => 'خدمات الثلاجات';

  @override
  String get ovenServices => 'خدمات الأفران';

  @override
  String get pipeLeak => 'تسرب الأنابيب';

  @override
  String get cloggedDrains => 'مصارف مسدودة';

  @override
  String get faucetRepair => 'إصلاح الحنفيات';

  @override
  String get wiringProblems => 'مشاكل الأسلاك';

  @override
  String get switchRepair => 'إصلاح المفاتيح';

  @override
  String get outletRepair => 'إصلاح المنافذ';

  @override
  String get acCleaning => 'غسيل مكيف الهواء (تنظيف الوحدة الداخلية والخارجية)';

  @override
  String get acCleaningDescription => 'مكيف سبليت - خدمة تنظيف كاملة';

  @override
  String get acLeakRepair => 'إصلاح التسريب';

  @override
  String get acWithGasRefill => 'تفكيك وتجميع اللوحة الإلكترونية';

  @override
  String get acInstallation => 'تركيب مكيف هواء جديد';

  @override
  String get acIndoorMounting => 'تركيب/فك داخلي';

  @override
  String get acOutdoorMounting => 'تركيب/فك خارجي';

  @override
  String get externalMotorChange => 'تغيير المحرك الخارجي';

  @override
  String get acFullCleaning => 'تنظيف جميع الوحدات + تعبئة الفريون';

  @override
  String get cleaningAllUnitsGasRefill => 'تنظيف جميع الوحدات + تعبئة الفريون';

  @override
  String get mountingService => 'تركيب الخزانة';

  @override
  String get controlBoardRepairService => 'تفكيك وتجميع اللوحة الإلكترونية';

  @override
  String get cassetteTypeInstallationService => 'تركيب نوع الكاسيت';

  @override
  String get internalCrystalChange => 'تغيير الكريستال الداخلي';

  @override
  String get internalMotorChange => 'تغيير المحرك الداخلي';

  @override
  String get largeCompressorChange => 'تغيير الضاغط (كبير)';

  @override
  String get largeComponentChange => 'تغيير الضاغط الكبير';

  @override
  String get contactorChange => 'تغيير الكونتاكتور';

  @override
  String get completentialation => 'تركيب كامل';

  @override
  String get notificationTitle => 'الإشعارات';

  @override
  String get markAllAsRead => 'تحديد الكل كمقروء';

  @override
  String get newNotification => 'جديد';

  @override
  String get youHaveUnreadNotificationsSingular => 'لديك إشعار واحد غير مقروء';

  @override
  String get youHaveUnreadNotificationsPlural =>
      'لديك \$COUNT\$ إشعارات غير مقروءة';

  @override
  String get bookingConfirmedNotification => 'تم تأكيد الحجز';

  @override
  String get bookingConfirmedMessage =>
      'تم تأكيد خدمة تنظيف المكيف الخاصة بك لغداً في الساعة ١٠:٠٠ صباحاً';

  @override
  String get specialOfferNotification => 'عرض خاص';

  @override
  String get specialOfferMessage =>
      'احصل على خصم ٢٠٪ على جميع خدمات السباكة هذا الأسبوع!';

  @override
  String get serviceReminderNotification => 'تذكير بالخدمة';

  @override
  String get serviceReminderMessage =>
      'تنظيف الغسالة مجدول اليوم في الساعة ٢:٠٠ مساءً';

  @override
  String get serviceCompletedNotification => 'اكتملت الخدمة';

  @override
  String get serviceCompletedMessage =>
      'اكتملت الخدمة! يرجى التحقق من الفاتورة.';

  @override
  String get technicianAssignedNotification => 'تم تعيين فني';

  @override
  String get technicianAssignedMessage =>
      'تم تعيين الفني أحمد لخدمة تنظيف المكيف الخاصة بك';

  @override
  String get workStartedNotification => 'بدأ العمل';

  @override
  String get workStartedMessage => 'بدأ الفني في العمل على خدمتك';

  @override
  String get workCompletedNotification => 'اكتمل العمل';

  @override
  String get workCompletedMessage =>
      'اكتملت خدمتك بنجاح. يرجى المراجعة والتقييم!';

  @override
  String get invoiceGeneratedNotification => 'تم إنشاء الفاتورة';

  @override
  String get invoiceGeneratedMessage =>
      'فاتورتك جاهزة. المبلغ الإجمالي: ريال \$AMOUNT\$';

  @override
  String get timeAgoJustNow => 'الآن';

  @override
  String get timeAgoMinutesAgo => 'منذ \$COUNT\$ دقيقة';

  @override
  String get timeAgoMinutesAgoPlural => 'منذ \$COUNT\$ دقائق';

  @override
  String get timeAgoHoursAgo => 'منذ \$COUNT\$ ساعة';

  @override
  String get timeAgoHoursAgoPlural => 'منذ \$COUNT\$ ساعات';

  @override
  String get timeAgoDaysAgo => 'منذ \$COUNT\$ يوم';

  @override
  String get timeAgoDaysAgoPlural => 'منذ \$COUNT\$ أيام';

  @override
  String get timeAgoWeeksAgo => 'منذ \$COUNT\$ أسبوع';

  @override
  String get timeAgoWeeksAgoPlural => 'منذ \$COUNT\$ أسابيع';

  @override
  String get timeAgoMonthsAgo => 'منذ \$COUNT\$ شهر';

  @override
  String get timeAgoMonthsAgoPlural => 'منذ \$COUNT\$ أشهر';

  @override
  String get currencySAR => 'ريال';

  @override
  String get sar => 'ريال';

  @override
  String get orderId => 'رقم الطلب';

  @override
  String get workCompleted => 'تم الانتهاء من العمل';

  @override
  String get helloArrivingSoon =>
      'مرحباً! سأصل خلال 30 دقيقة. يرجى إبقاء منطقة الخدمة جاهزة.';

  @override
  String get sofaCleaning => 'تنظيف الكنب';

  @override
  String get sevenSeaterSofaCleaning => 'تنظيف كنبة 7 مقاعد';

  @override
  String get fiveSeaterSofaCleaning => 'تنظيف كنبة 5 مقاعد';

  @override
  String get sixSeaterSofaCleaning => 'تنظيف كنبة 6 مقاعد';

  @override
  String get dewanCleaning => 'تنظيف الديوان';

  @override
  String get sofaCumBedCleaning => 'تنظيف الكنبة السرير';

  @override
  String get tenSeaterSofaCleaning => 'تنظيف كنبة 10 مقاعد';

  @override
  String get chairCleaning => 'تنظيف الكراسي - 4 مقاعد';

  @override
  String get deepHouseCleaning => 'تنظيف المنزل العميق';

  @override
  String get carpetCleaning => 'تنظيف السجاد';

  @override
  String get kitchenDeepClean => 'تنظيف المطبخ العميق';

  @override
  String get bathroomSanitization => 'تعقيم الحمام';

  @override
  String get emergencyContactInitiated => 'تم بدء الاتصال في حالات الطوارئ';

  @override
  String get searchLocation => 'ابحث عن الموقع...';

  @override
  String get locationSelected => 'تم اختيار الموقع';

  @override
  String get language => 'اللغة';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get noNotificationsYet => 'لا توجد إشعارات حتى الآن';

  @override
  String get support => 'الدعم';

  @override
  String get errorCreatingBooking =>
      'حدث خطأ أثناء إنشاء الحجز. يرجى المحاولة مرة أخرى أو التحقق من الاتصال.';

  @override
  String get errorTitle => 'خطأ';

  @override
  String get okAction => 'حسناً';

  @override
  String get checkPhoneNumber => 'يرجى التحقق من رقم الهاتف';

  @override
  String get verificationFailed => 'فشل التحقق. يرجى المحاولة مرة أخرى.';

  @override
  String get genericError => 'حدث خطأ. يرجى المحاولة مرة أخرى.';

  @override
  String get autoVerificationFailed =>
      'فشل التحقق التلقائي. الرجاء إدخال الرمز يدوياً.';

  @override
  String get validPhoneNumber => 'رقم هاتف صالح';

  @override
  String get selectCountryCode => 'اختر رمز الدولة';

  @override
  String get saudiArabia => 'المملكة العربية السعودية';

  @override
  String get uae => 'الإمارات العربية المتحدة';

  @override
  String get pakistan => 'باكستان';

  @override
  String get verify => 'تحقق';

  @override
  String get sessionExpired => 'انتهت الجلسة. يرجى العودة والمحاولة مرة أخرى.';

  @override
  String get phoneVerified => 'تم التحقق من رقم الجوال بنجاح!';

  @override
  String get invalidOtp =>
      'رمز التحقق غير صالح. يرجى التحقق والمحاولة مرة أخرى.';

  @override
  String get otpExpired => 'انتهت صلاحية الرمز. يرجى طلب رمز جديد.';

  @override
  String get sessionInvalid =>
      'الجلسة غير صالحة. يرجى العودة والمحاولة مرة أخرى.';

  @override
  String get phoneAlreadyRegistered => 'رقم الهاتف هذا مسجل بالفعل.';

  @override
  String get failedToResendOtp =>
      'فشل في إعادة إرسال الرمز. يرجى المحاولة مرة أخرى.';

  @override
  String get testNumberHint => 'رقم اختبار: استخدم الرمز 124576';

  @override
  String get clearCartTitle => 'مسح السلة';

  @override
  String get invoiceGeneratedTitle => 'تم إنشاء الفاتورة';

  @override
  String invoiceGeneratedBody(String serviceName) {
    return 'الفاتورة لـ $serviceName متوفرة الآن.';
  }

  @override
  String get statusUpdateTitle => 'تحديث الحالة';

  @override
  String serviceStatusUpdateBody(String serviceName, String statusText) {
    return 'خدمة $serviceName الآن $statusText.';
  }

  @override
  String get appSubtitle => 'خدمات منزلية';

  @override
  String get userProfile => 'الملف الشخصي';

  @override
  String get generalSection => 'عام';

  @override
  String get activitySection => 'النشاط';

  @override
  String locationName(int number) {
    return 'الموقع $number';
  }

  @override
  String get errorLoadingBookings => 'خطأ في تحميل الحجوزات';

  @override
  String get currencySar => 'ريال';

  @override
  String get profileUpdatedSuccess => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String dialerLaunchError(String error) {
    return 'تعذر فتح الهاتف: $error';
  }

  @override
  String get customerSupport => 'خدمة العملاء';

  @override
  String get supportSubtitle => 'نحن هنا لمساعدتك!';

  @override
  String get supportDescription =>
      'لأي استفسارات أو مساعدة، يرجى التواصل مع فريق الدعم.';

  @override
  String get callSupport => 'اتصل بالدعم';

  @override
  String get developedBy => 'تطوير:';

  @override
  String get contactSupportTeam => 'تواصل مع فريق الدعم';

  @override
  String get loginToViewNotifications => 'يرجى تسجيل الدخول لعرض الإشعارات';

  @override
  String get serviceDefault => 'خدمة';

  @override
  String bookedFor(String date) {
    return 'محجوز لـ $date';
  }

  @override
  String get invoiceTitle => 'فاتورة';

  @override
  String get serviceProvider => 'مقدم الخدمة';

  @override
  String get billTo => 'فاتورة إلى';

  @override
  String get invoiceDate => 'تاريخ الفاتورة';

  @override
  String get serviceDate => 'تاريخ الخدمة';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get cashOnService => 'نقدًا عند الخدمة';

  @override
  String get creditDebitCard => 'بطاقة ائتمان / مدى';

  @override
  String get stcPayInfo => 'STC Pay: 0535616095';

  @override
  String get price => 'السعر';

  @override
  String get notes => 'ملاحظات:';

  @override
  String get thankYouBusiness => 'شكرا لتعاملك معنا!';

  @override
  String get contactSupportEmail =>
      'لأي استفسار، تواصل معنا عبر support@handyman.com';

  @override
  String get assignedWorker => 'العامل المعين';

  @override
  String fixErrors(String error) {
    return 'يرجى تصحيح الأخطاء: $error';
  }

  @override
  String get noChangesToSave => 'لا توجد تغييرات للحفظ';

  @override
  String get discardChangesTitle => 'تجاهل التغييرات؟';

  @override
  String get discardChangesContent =>
      'لديك تغييرات غير محفوظة. هل أنت متأكد أنك تريد المغادرة؟';

  @override
  String get discard => 'تجاهل';

  @override
  String get unsaved => 'غير محفوظ';

  @override
  String get looksGood => 'يبدو جيداً!';

  @override
  String get addressTypeHome => 'المنزل';

  @override
  String get addressTypeWork => 'العمل';

  @override
  String get addressTypeOther => 'أخرى';

  @override
  String get addressAddedSuccess => 'تمت إضافة العنوان بنجاح!';

  @override
  String get addressDeletedSuccess => 'تم حذف العنوان بنجاح!';

  @override
  String get primaryAddressUpdated => 'تم تحديث العنوان الرئيسي!';

  @override
  String get deleteAddressTitle => 'حذف العنوان';

  @override
  String get deleteAddressContent => 'هل أنت متأكد أنك تريد حذف هذا العنوان؟';

  @override
  String get delete => 'حذف';

  @override
  String get setPrimary => 'تعيين كرئيسي';

  @override
  String get edit => 'تعديل';

  @override
  String get noSavedAddresses => 'لا توجد عناوين محفوظة بعد';

  @override
  String get locationServicesDisabled =>
      'خدمات الموقع غير مفعلة. يرجى تفعيلها.';

  @override
  String get locationPermissionDenied => 'تم رفض إذن الوصول للموقع';

  @override
  String get locationPermissionPermanentlyDenied =>
      'تم رفض إذن الوصول للموقع بشكل دائم';

  @override
  String get unknownLocation => 'موقع غير معروف';

  @override
  String get loadingMap => 'جارٍ تحميل الخريطة...';

  @override
  String searchFailed(Object error) {
    return 'فشل البحث: $error';
  }
}
