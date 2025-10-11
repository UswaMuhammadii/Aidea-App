import '../models/user_model.dart';
import '../models/service_model.dart';
import '../models/booking_model.dart';

class DummyDataService {
  static final List<Service> _services = [
    // AC Services - Split AC
    Service(
      id: '1',
      name: 'AC Washing (Cleaning indoor and outdoor unit)',
      description: 'Split AC - Complete cleaning service',
      price: 89.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Deep cleaning', 'Indoor unit cleaning', 'Outdoor unit cleaning'],
    ),
    Service(
      id: '2',
      name: 'Repairing leaks',
      description: 'Split AC - Leak repair service',
      price: 128.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Leak detection', 'Professional repair', 'Quality parts'],
    ),
    Service(
      id: '3',
      name: 'Cleaning all units + Freon filling',
      description: 'Split AC - Complete service with gas refill',
      price: 170.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Complete cleaning', 'Gas refill', 'Performance check'],
    ),
    Service(
      id: '4',
      name: 'Installing a new air conditioner',
      description: 'Split AC - Professional installation',
      price: 244.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Professional installation', 'Warranty included', 'Testing'],
    ),
    Service(
      id: '5',
      name: 'Disassembly and assembly (inside the house)',
      description: 'Split AC - Indoor mounting/dismounting',
      price: 244.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Indoor service', 'Professional tools', 'Safe handling'],
    ),
    Service(
      id: '6',
      name: 'Disassembly and assembly (outside the house)',
      description: 'Split AC - Outdoor mounting/dismounting',
      price: 361.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Outdoor service', 'Safety equipment', 'Expert technicians'],
    ),
    Service(
      id: '7',
      name: 'Disassembling and assembling an electronic board',
      description: 'Split AC - Control board repair',
      price: 146.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Electronic repair', 'Expert service', 'Quality parts'],
    ),
    Service(
      id: '8',
      name: 'Removing and installing an external fan',
      description: 'Split AC - Fan replacement',
      price: 156.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Fan replacement', 'Professional service', 'Testing included'],
    ),
    Service(
      id: '9',
      name: 'Change the dynamo (external)',
      description: 'Split AC - External motor replacement',
      price: 146.00,
      category: 'AC Services',
      subcategory: 'Split AC',
      features: ['Motor replacement', 'Quality parts', 'Expert service'],
    ),

    // AC Services - Window AC
    Service(
      id: '10',
      name: 'Air conditioner wash',
      description: 'Window AC - Complete cleaning',
      price: 55.00,
      category: 'AC Services',
      subcategory: 'Window AC',
      features: ['Deep cleaning', 'Filter cleaning', 'Performance check'],
    ),
    Service(
      id: '11',
      name: 'Repairing leaks',
      description: 'Window AC - Leak repair',
      price: 97.00,
      category: 'AC Services',
      subcategory: 'Window AC',
      features: ['Leak detection', 'Professional repair', 'Testing'],
    ),
    Service(
      id: '12',
      name: 'Cleaning + Freon filling',
      description: 'Window AC - Service with gas refill',
      price: 89.00,
      category: 'AC Services',
      subcategory: 'Window AC',
      features: ['Cleaning', 'Gas refill', 'Performance optimization'],
    ),
    Service(
      id: '13',
      name: 'Installing a new air conditioner',
      description: 'Window AC - Installation service',
      price: 78.00,
      category: 'AC Services',
      subcategory: 'Window AC',
      features: ['Professional installation', 'Testing', 'Clean finish'],
    ),
    Service(
      id: '14',
      name: 'Disassembly and assembly (inside the house)',
      description: 'Window AC - Indoor service',
      price: 87.00,
      category: 'AC Services',
      subcategory: 'Window AC',
      features: ['Safe handling', 'Professional tools', 'Quick service'],
    ),
    Service(
      id: '15',
      name: 'Sewer cleaning',
      description: 'Window AC - Drain pipe cleaning',
      price: 97.00,
      category: 'AC Services',
      subcategory: 'Window AC',
      features: ['Drain cleaning', 'Pipe unclogging', 'Quick service'],
    ),
    Service(
      id: '16',
      name: 'Change the dynamo',
      description: 'Window AC - Motor replacement',
      price: 113.00,
      category: 'AC Services',
      subcategory: 'Window AC',
      features: ['Motor replacement', 'Quality parts', 'Testing included'],
    ),

    // AC Services - Central AC
    Service(
      id: '17',
      name: 'Installing a cabinet air conditioner',
      description: 'Central AC - Cabinet installation',
      price: 403.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Professional installation', 'Complete setup', 'Testing'],
    ),
    Service(
      id: '18',
      name: 'Installing and removing an electronic board',
      description: 'Central AC - Control board service',
      price: 173.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Board replacement', 'Expert service', 'Quality parts'],
    ),
    Service(
      id: '19',
      name: 'Installing and removing an external fan',
      description: 'Central AC - Fan replacement',
      price: 207.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Fan replacement', 'Professional service', 'Testing'],
    ),
    Service(
      id: '20',
      name: 'Cassette air conditioner installation',
      description: 'Central AC - Cassette type installation',
      price: 782.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Complete installation', 'Professional setup', 'Warranty included'],
    ),
    Service(
      id: '21',
      name: 'Change the split interior crystal',
      description: 'Central AC - Indoor unit crystal replacement',
      price: 230.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Crystal replacement', 'Expert service', 'Quality parts'],
    ),
    Service(
      id: '22',
      name: 'Change the internal engine dynamo',
      description: 'Central AC - Internal motor replacement',
      price: 184.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Motor replacement', 'Professional service', 'Testing'],
    ),
    Service(
      id: '23',
      name: 'Changing the compressor 36-48-60 units',
      description: 'Central AC - Compressor replacement (large)',
      price: 207.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Compressor replacement', 'Expert technicians', 'Quality parts'],
    ),
    Service(
      id: '24',
      name: 'Change the cylinder - coil - cylinder - battery',
      description: 'Central AC - Major component replacement',
      price: 104.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Component replacement', 'Professional service', 'Testing'],
    ),
    Service(
      id: '25',
      name: 'Changing and installing a contactor',
      description: 'Central AC - Contactor replacement',
      price: 115.00,
      category: 'AC Services',
      subcategory: 'Central AC',
      features: ['Contactor replacement', 'Expert service', 'Quality parts'],
    ),

    // Washing Machine Services - Automatic
    Service(
      id: '26',
      name: 'Disassembling and assembling the electronic board',
      description: 'Automatic - Control board service',
      price: 150.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Board repair', 'Expert service', 'Quality parts'],
    ),
    Service(
      id: '27',
      name: 'Disassembling and assembling the drying machine',
      description: 'Automatic - Dryer repair',
      price: 219.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Dryer repair', 'Professional service', 'Testing included'],
    ),
    Service(
      id: '28',
      name: 'Disassembling and assembling the washing machine',
      description: 'Automatic - Complete service',
      price: 184.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Complete disassembly', 'Professional service', 'Reassembly'],
    ),
    Service(
      id: '29',
      name: 'Door disassembly and installation',
      description: 'Automatic - Door repair',
      price: 138.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Door repair', 'Seal replacement', 'Alignment check'],
    ),
    Service(
      id: '30',
      name: 'Dismantling and installing the balance bar',
      description: 'Automatic - Balance bar service',
      price: 161.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Balance bar replacement', 'Vibration reduction', 'Testing'],
    ),
    Service(
      id: '31',
      name: 'Water drainage maintenance',
      description: 'Automatic - Drain system service',
      price: 150.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Drain cleaning', 'Pump check', 'Quick service'],
    ),
    Service(
      id: '32',
      name: 'Water flow maintenance',
      description: 'Automatic - Water inlet service',
      price: 127.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Inlet valve service', 'Water flow optimization', 'Testing'],
    ),
    Service(
      id: '33',
      name: 'Electrical short circuit maintenance',
      description: 'Automatic - Electrical repair',
      price: 127.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Electrical diagnosis', 'Wiring repair', 'Safety check'],
    ),
    Service(
      id: '34',
      name: 'Repairing the power supply',
      description: 'Automatic - Power system repair',
      price: 92.00,
      category: 'Washing Machine Service',
      subcategory: 'Automatic Washing Machines',
      features: ['Power supply repair', 'Component check', 'Testing'],
    ),

    // Washing Machine Services - Regular
    Service(
      id: '35',
      name: 'Disassembling and assembling the timer',
      description: 'Regular - Timer repair',
      price: 115.00,
      category: 'Washing Machine Service',
      subcategory: 'Regular Washing Machines',
      features: ['Timer replacement', 'Expert service', 'Testing'],
    ),
    Service(
      id: '36',
      name: 'Disassembling and assembling the drying machine',
      description: 'Regular - Dryer service',
      price: 156.00,
      category: 'Washing Machine Service',
      subcategory: 'Regular Washing Machines',
      features: ['Dryer repair', 'Component check', 'Testing'],
    ),
    Service(
      id: '37',
      name: 'Disassembling and assembling the washing machine',
      description: 'Regular - Complete service',
      price: 144.00,
      category: 'Washing Machine Service',
      subcategory: 'Regular Washing Machines',
      features: ['Full service', 'Professional repair', 'Testing'],
    ),

    // Refrigerator Services
    Service(
      id: '38',
      name: 'Compressor change',
      description: 'Refrigerator - Compressor replacement',
      price: 196.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Compressor replacement', 'Professional service', 'Gas refill'],
    ),
    Service(
      id: '39',
      name: 'Change the external fan',
      description: 'Refrigerator - External fan replacement',
      price: 150.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Fan replacement', 'Expert service', 'Testing'],
    ),
    Service(
      id: '40',
      name: 'Change the internal fan',
      description: 'Refrigerator - Internal fan replacement',
      price: 150.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Fan replacement', 'Professional service', 'Testing'],
    ),
    Service(
      id: '41',
      name: 'Change the heater',
      description: 'Refrigerator - Heater replacement',
      price: 173.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Heater replacement', 'Quality parts', 'Testing'],
    ),
    Service(
      id: '42',
      name: 'Change the "Depressor" sensor',
      description: 'Refrigerator - Sensor replacement',
      price: 104.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Sensor replacement', 'Expert service', 'Testing'],
    ),
    Service(
      id: '43',
      name: 'American Freon filling',
      description: 'Refrigerator - R134a gas refill',
      price: 230.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['American gas refill', 'Pressure check', 'Leak test'],
    ),
    Service(
      id: '44',
      name: 'Indian Freon filling',
      description: 'Refrigerator - Indian gas refill',
      price: 196.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Indian gas refill', 'Pressure check', 'Testing'],
    ),
    Service(
      id: '45',
      name: 'External leakage maintenance',
      description: 'Refrigerator - External leak repair',
      price: 173.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Leak detection', 'Professional repair', 'Gas refill'],
    ),
    Service(
      id: '46',
      name: 'Change and adjust the timer',
      description: 'Refrigerator - Timer service',
      price: 104.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Timer replacement', 'Adjustment', 'Testing'],
    ),
    Service(
      id: '47',
      name: 'Refrigerator compressor replacement 1/6 - 1/5 - 1/4 - 1/3',
      description: 'Refrigerator - Small compressor replacement',
      price: 196.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Compressor replacement', 'Gas refill', 'Testing'],
    ),
    Service(
      id: '48',
      name: 'Refrigerator compressor replacement 1/2 - 3/4 - 1',
      description: 'Refrigerator - Large compressor replacement',
      price: 196.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Compressor replacement', 'Gas refill', 'Testing'],
    ),
    Service(
      id: '49',
      name: 'External leakage maintenance + American R134 Freon filling',
      description: 'Refrigerator - Leak repair with American gas',
      price: 288.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Leak repair', 'American gas refill', 'Testing'],
    ),
    Service(
      id: '50',
      name: 'External leakage maintenance + American R12 Freon filling',
      description: 'Refrigerator - Leak repair with American R12 gas',
      price: 380.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Leak repair', 'R12 gas refill', 'Professional service'],
    ),
    Service(
      id: '51',
      name: 'External leakage maintenance + Chinese R134 Freon filling',
      description: 'Refrigerator - Leak repair with Chinese R134 gas',
      price: 380.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Leak repair', 'Chinese gas refill', 'Testing'],
    ),
    Service(
      id: '52',
      name: 'External leakage maintenance + Chinese R12 Freon filling',
      description: 'Refrigerator - Leak repair with Chinese R12 gas',
      price: 219.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Leak repair', 'Chinese R12 gas', 'Testing'],
    ),
    Service(
      id: '53',
      name: 'External leakage maintenance + Indian R134 Freon filling',
      description: 'Refrigerator - Leak repair with Indian gas',
      price: 334.00,
      category: 'Refrigerator Service',
      subcategory: 'Refrigerator',
      features: ['Leak repair', 'Indian gas refill', 'Professional service'],
    ),

    // Oven Services
    Service(
      id: '54',
      name: 'Change keys',
      description: 'Oven - Control keys replacement',
      price: 138.00,
      category: 'Other Services',
      subcategory: 'Oven',
      features: ['Key replacement', 'Expert service', 'Testing'],
    ),
    Service(
      id: '55',
      name: 'Change door hinges',
      description: 'Oven - Door hinge replacement',
      price: 138.00,
      category: 'Other Services',
      subcategory: 'Oven',
      features: ['Hinge replacement', 'Door alignment', 'Testing'],
    ),
    Service(
      id: '56',
      name: 'Cleaning',
      description: 'Oven - Deep cleaning service',
      price: 184.00,
      category: 'Other Services',
      subcategory: 'Oven',
      features: ['Deep cleaning', 'Interior & exterior', 'Professional service'],
    ),
    Service(
      id: '57',
      name: 'Smuggling maintenance',
      description: 'Oven - Seal maintenance',
      price: 184.00,
      category: 'Other Services',
      subcategory: 'Oven',
      features: ['Seal replacement', 'Temperature check', 'Testing'],
    ),
    Service(
      id: '58',
      name: 'Microwave maintenance',
      description: 'Oven - Microwave repair',
      price: 230.00,
      category: 'Other Services',
      subcategory: 'Oven',
      features: ['Microwave repair', 'Component check', 'Testing'],
    ),
  ];

  static String getCategoryImage(String categoryName) {
    switch (categoryName) {
      case 'AC Services':
        return 'assets/images/ac_service.png';
      case 'Washing Machine Service':
        return 'assets/images/washing_machine.png';
      case 'Refrigerator Service':
        return 'assets/images/refrigerator.png';
      case 'Other Services':
        return 'assets/images/oven.png';
      default:
        return 'assets/images/ac_service.png';
    }
  }

  static final List<ServiceCategory> _categories = [
    ServiceCategory(
      id: '1',
      name: 'AC Services',
      description: 'Professional AC installation and maintenance',
      icon: '❄️',
      services: _services.where((s) => s.category == 'AC Services').toList(),
      subcategories: ['Split AC', 'Window AC', 'Central AC'],
    ),
    ServiceCategory(
      id: '2',
      name: 'Washing Machine Service',
      description: 'Complete washing machine services',
      icon: '🧺',
      services: _services.where((s) => s.category == 'Washing Machine Service').toList(),
      subcategories: ['Automatic Washing Machines', 'Regular Washing Machines'],
    ),
    ServiceCategory(
      id: '3',
      name: 'Refrigerator Service',
      description: 'Professional refrigerator repair and maintenance',
      icon: '🧊',
      services: _services.where((s) => s.category == 'Refrigerator Service').toList(),
      subcategories: ['Refrigerator'],
    ),
    ServiceCategory(
      id: '4',
      name: 'Other Services',
      description: 'Oven and microwave repair services',
      icon: '🔥',
      services: _services.where((s) => s.category == 'Other Services').toList(),
      subcategories: ['Oven'],
    ),
  ];

  static final List<Booking> _bookings = [];

  static List<ServiceCategory> getCategories() {
    return _categories;
  }

  static List<String> getSubcategories(String categoryName) {
    try {
      final category = _categories.firstWhere((c) => c.name == categoryName);
      return category.subcategories ?? [];
    } catch (e) {
      return [];
    }
  }

  static List<Service> getServicesByCategory(String categoryId) {
    final category = _categories.firstWhere((c) => c.id == categoryId);
    return category.services;
  }

  static List<Service> getServicesBySubcategory(String categoryName, String subcategory) {
    return _services.where((s) =>
    s.category == categoryName && s.subcategory == subcategory
    ).toList();
  }

  static Service? getServiceById(String serviceId) {
    try {
      return _services.firstWhere((s) => s.id == serviceId);
    } catch (e) {
      return null;
    }
  }

  static List<Booking> getUserBookings(String userId) {
    return _bookings.where((b) => b.userId == userId).toList();
  }

  static Booking createBooking({
    required String userId,
    required String serviceId,
    required DateTime bookingDate,
    required DateTime bookingTime,
    required double totalPrice,
    int quantity = 1,
    String paymentMethod = 'cash',
    String? notes,
  }) {
    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      serviceId: serviceId,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      totalPrice: totalPrice,
      status: BookingStatus.pending,
      createdAt: DateTime.now(),
      notes: notes,
      service: getServiceById(serviceId),
      quantity: quantity,
      paymentMethod: paymentMethod,
    );

    _bookings.add(booking);
    return booking;
  }

  static User createUser({
    required String email,
    required String name,
    required String phone,
  }) {
    return User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      phone: phone,
      createdAt: DateTime.now(),
    );
  }

  static void addDummyCompletedBookings(String userId) {
    _bookings.add(Booking(
      id: '${DateTime.now().millisecondsSinceEpoch - 100000}',
      userId: userId,
      serviceId: '2',
      bookingDate: DateTime.now().subtract(const Duration(days: 5)),
      bookingTime: DateTime.now().subtract(const Duration(days: 5)),
      totalPrice: 128.00,
      status: BookingStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      service: getServiceById('2'),
      quantity: 1,
      paymentMethod: 'cash',
    ));

    _bookings.add(Booking(
      id: '${DateTime.now().millisecondsSinceEpoch - 200000}',
      userId: userId,
      serviceId: '26',
      bookingDate: DateTime.now().subtract(const Duration(days: 12)),
      bookingTime: DateTime.now().subtract(const Duration(days: 12)),
      totalPrice: 150.00,
      status: BookingStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 13)),
      service: getServiceById('26'),
      quantity: 1,
      paymentMethod: 'card',
    ));

    _bookings.add(Booking(
      id: '${DateTime.now().millisecondsSinceEpoch - 300000}',
      userId: userId,
      serviceId: '38',
      bookingDate: DateTime.now().subtract(const Duration(days: 20)),
      bookingTime: DateTime.now().subtract(const Duration(days: 20)),
      totalPrice: 196.00,
      status: BookingStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 21)),
      service: getServiceById('38'),
      quantity: 1,
      paymentMethod: 'cash',
    ));
  }
}