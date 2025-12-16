import '../models/user_model.dart';
import '../models/service_model.dart';
import '../models/booking_model.dart';
import '../../gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class DummyDataService {
  static List<Service> _services = [];
  static final List<Booking> _bookings = [];
  static String? _currentLanguage; // ✅ Track current language

  // ✅ NEW: Clear cache when language changes
  static void clearCache() {
    _services = [];
  }

  // ✅ NEW: Check if language changed and clear cache
  static void _checkLanguageChange(String languageCode) {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      clearCache();
    }
  }

  // Helper method to normalize category names for comparison
  static String _normalizeCategoryName(String categoryName) {
    return categoryName.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim();
  }

  static List<Service> _getServices(AppLocalizations l10n) {
    // ✅ Check if language changed first
    _checkLanguageChange(l10n.localeName);

    if (_services.isNotEmpty) return _services;

    _services = [
      // AC Services - Split AC (Services 1-9)
      Service(
        id: '1',
        name: l10n.acWashing,
        description: '${l10n.splitAc} - ${l10n.completeCleaningService}',
        price: 89.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.deepCleaning,
          l10n.indoorUnitCleaning,
          l10n.outdoorUnitCleaning
        ],
      ),
      Service(
        id: '2',
        name: l10n.repairingLeaks,
        description: '${l10n.splitAc} - ${l10n.leakRepairService}',
        price: 128.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.leakDetection,
          l10n.professionalRepair,
          l10n.qualityParts
        ],
      ),
      Service(
        id: '3',
        name: l10n.cleaningWithFreon,
        description: '${l10n.splitAc} - ${l10n.completeServiceWithGasRefill}',
        price: 170.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.completeCleaning,
          l10n.gasRefill,
          l10n.performanceCheck
        ],
      ),
      Service(
        id: '4',
        name: l10n.installNewAc,
        description: '${l10n.splitAc} - ${l10n.professionalInstallation}',
        price: 244.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.professionalInstallation,
          l10n.warrantyIncluded,
          l10n.testing
        ],
      ),
      Service(
        id: '5',
        name: l10n.disassembleInside,
        description: '${l10n.splitAc} - ${l10n.indoorMountingService}',
        price: 244.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.indoorService,
          l10n.professionalTools,
          l10n.safeHandling
        ],
      ),
      Service(
        id: '6',
        name: l10n.disassembleOutside,
        description: '${l10n.splitAc} - ${l10n.outdoorMountingService}',
        price: 361.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.outdoorService,
          l10n.safetyEquipment,
          l10n.expertTechnicians
        ],
      ),
      Service(
        id: '7',
        name: l10n.electronicBoardService,
        description: '${l10n.splitAc} - ${l10n.controlBoardRepair}',
        price: 146.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.electronicRepair,
          l10n.expertService,
          l10n.qualityParts
        ],
      ),
      Service(
        id: '8',
        name: l10n.externalFanService,
        description: '${l10n.splitAc} - ${l10n.fanReplacement}',
        price: 156.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.fanReplacement,
          l10n.professionalService,
          l10n.testingIncluded
        ],
      ),
      Service(
        id: '9',
        name: l10n.changeDynamo,
        description: '${l10n.splitAc} - ${l10n.externalMotorReplacement}',
        price: 146.00,
        category: l10n.acServices,
        subcategory: l10n.splitAc,
        features: [
          l10n.motorReplacement,
          l10n.qualityParts,
          l10n.expertService
        ],
      ),

      // AC Services - Window AC (Services 10-16)
      Service(
        id: '10',
        name: l10n.acWash,
        description: '${l10n.windowAc} - ${l10n.completeCleaning}',
        price: 55.00,
        category: l10n.acServices,
        subcategory: l10n.windowAc,
        features: [
          l10n.deepCleaning,
          l10n.filterCleaning,
          l10n.performanceCheck
        ],
      ),
      Service(
        id: '11',
        name: l10n.repairingLeaks,
        description: '${l10n.windowAc} - ${l10n.leakRepair}',
        price: 97.00,
        category: l10n.acServices,
        subcategory: l10n.windowAc,
        features: [l10n.leakDetection, l10n.professionalRepair, l10n.testing],
      ),
      Service(
        id: '12',
        name: l10n.cleaningWithFreon,
        description: '${l10n.windowAc} - ${l10n.serviceWithGasRefill}',
        price: 89.00,
        category: l10n.acServices,
        subcategory: l10n.windowAc,
        features: [l10n.cleaning, l10n.gasRefill, l10n.performanceOptimization],
      ),
      Service(
        id: '13',
        name: l10n.installNewAc,
        description: '${l10n.windowAc} - ${l10n.installationService}',
        price: 78.00,
        category: l10n.acServices,
        subcategory: l10n.windowAc,
        features: [
          l10n.professionalInstallation,
          l10n.testing,
          l10n.cleanFinish
        ],
      ),
      Service(
        id: '14',
        name: l10n.disassembleInside,
        description: '${l10n.windowAc} - ${l10n.indoorService}',
        price: 87.00,
        category: l10n.acServices,
        subcategory: l10n.windowAc,
        features: [
          l10n.safeHandling,
          l10n.professionalTools,
          l10n.quickService
        ],
      ),
      Service(
        id: '15',
        name: l10n.sewerCleaning,
        description: '${l10n.windowAc} - ${l10n.drainPipeCleaning}',
        price: 97.00,
        category: l10n.acServices,
        subcategory: l10n.windowAc,
        features: [l10n.drainCleaning, l10n.pipeUnclogging, l10n.quickService],
      ),
      Service(
        id: '16',
        name: l10n.changeDynamo,
        description: '${l10n.windowAc} - ${l10n.motorReplacement}',
        price: 113.00,
        category: l10n.acServices,
        subcategory: l10n.windowAc,
        features: [
          l10n.motorReplacement,
          l10n.qualityParts,
          l10n.testingIncluded
        ],
      ),

      // AC Services - Central AC (Services 17-25)
      Service(
        id: '17',
        name: l10n.installCabinetAc,
        description: '${l10n.centralAc} - ${l10n.cabinetInstallation}',
        price: 403.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [
          l10n.professionalInstallation,
          l10n.completeSetup,
          l10n.testing
        ],
      ),
      Service(
        id: '18',
        name: l10n.electronicBoardService,
        description: '${l10n.centralAc} - ${l10n.controlBoardService}',
        price: 173.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [
          l10n.boardReplacement,
          l10n.expertService,
          l10n.qualityParts
        ],
      ),
      Service(
        id: '19',
        name: l10n.externalFanService,
        description: '${l10n.centralAc} - ${l10n.fanReplacement}',
        price: 207.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [l10n.fanReplacement, l10n.professionalService, l10n.testing],
      ),
      Service(
        id: '20',
        name: l10n.cassetteAcInstallation,
        description: '${l10n.centralAc} - ${l10n.cassetteTypeInstallation}',
        price: 782.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [
          l10n.completeInstallation,
          l10n.professionalSetup,
          l10n.warrantyIncluded
        ],
      ),
      Service(
        id: '21',
        name: l10n.changeSplitCrystal,
        description: '${l10n.centralAc} - ${l10n.indoorUnitCrystalReplacement}',
        price: 230.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [
          l10n.crystalReplacement,
          l10n.expertService,
          l10n.qualityParts
        ],
      ),
      Service(
        id: '22',
        name: l10n.changeInternalEngine,
        description: '${l10n.centralAc} - ${l10n.internalMotorReplacement}',
        price: 184.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [
          l10n.motorReplacement,
          l10n.professionalService,
          l10n.testing
        ],
      ),
      Service(
        id: '23',
        name: l10n.changeCompressor,
        description: '${l10n.centralAc} - ${l10n.compressorReplacementLarge}',
        price: 207.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [
          l10n.compressorReplacement,
          l10n.expertTechnicians,
          l10n.qualityParts
        ],
      ),
      Service(
        id: '24',
        name: l10n.changeComponents,
        description: '${l10n.centralAc} - ${l10n.majorComponentReplacement}',
        price: 104.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [
          l10n.componentReplacement,
          l10n.professionalService,
          l10n.testing
        ],
      ),
      Service(
        id: '25',
        name: l10n.changeContactor,
        description: '${l10n.centralAc} - ${l10n.contactorReplacement}',
        price: 115.00,
        category: l10n.acServices,
        subcategory: l10n.centralAc,
        features: [
          l10n.contactorReplacement,
          l10n.expertService,
          l10n.qualityParts
        ],
      ),

      // Home Appliances - Washing Machine - Automatic (Services 26-34)
      Service(
        id: '26',
        name: l10n.disassembleElectronicBoard,
        description: '${l10n.automatic} - ${l10n.controlBoardService}',
        price: 150.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [l10n.boardRepair, l10n.expertService, l10n.qualityParts],
      ),
      Service(
        id: '27',
        name: l10n.disassembleDryingMachine,
        description: '${l10n.automatic} - ${l10n.dryerRepair}',
        price: 219.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [
          l10n.dryerRepair,
          l10n.professionalService,
          l10n.testingIncluded
        ],
      ),
      Service(
        id: '28',
        name: l10n.disassembleWashingMachine,
        description: '${l10n.automatic} - ${l10n.completeService}',
        price: 184.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [
          l10n.completeDisassembly,
          l10n.professionalService,
          l10n.reassembly
        ],
      ),
      Service(
        id: '29',
        name: l10n.doorDisassembly,
        description: '${l10n.automatic} - ${l10n.doorRepair}',
        price: 138.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [l10n.doorRepair, l10n.sealReplacement, l10n.alignmentCheck],
      ),
      Service(
        id: '30',
        name: l10n.balanceBarService,
        description: '${l10n.automatic} - ${l10n.balanceBarServiceDesc}',
        price: 161.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [
          l10n.balanceBarReplacement,
          l10n.vibrationReduction,
          l10n.testing
        ],
      ),
      Service(
        id: '31',
        name: l10n.waterDrainageMaintenance,
        description: '${l10n.automatic} - ${l10n.drainSystemService}',
        price: 150.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [l10n.drainCleaning, l10n.pumpCheck, l10n.quickService],
      ),
      Service(
        id: '32',
        name: l10n.waterFlowMaintenance,
        description: '${l10n.automatic} - ${l10n.waterInletService}',
        price: 127.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [
          l10n.inletValveService,
          l10n.waterFlowOptimization,
          l10n.testing
        ],
      ),
      Service(
        id: '33',
        name: l10n.electricalShortCircuit,
        description: '${l10n.automatic} - ${l10n.electricalRepair}',
        price: 127.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [
          l10n.electricalDiagnosis,
          l10n.wiringRepair,
          l10n.safetyCheck
        ],
      ),
      Service(
        id: '34',
        name: l10n.powerSupplyRepair,
        description: '${l10n.automatic} - ${l10n.powerSystemRepair}',
        price: 92.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.automatic,
        features: [l10n.powerSupplyRepair, l10n.componentCheck, l10n.testing],
      ),

      // Home Appliances - Washing Machine - Regular (Services 35-37)
      Service(
        id: '35',
        name: l10n.disassembleTimer,
        description: '${l10n.regular} - ${l10n.timerRepair}',
        price: 115.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.regular,
        features: [l10n.timerReplacement, l10n.expertService, l10n.testing],
      ),
      Service(
        id: '36',
        name: l10n.disassembleDryingMachine,
        description: '${l10n.regular} - ${l10n.dryerService}',
        price: 156.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.regular,
        features: [l10n.dryerRepair, l10n.componentCheck, l10n.testing],
      ),
      Service(
        id: '37',
        name: l10n.disassembleWashingMachine,
        description: '${l10n.regular} - ${l10n.completeService}',
        price: 144.00,
        category: l10n.homeAppliances,
        subcategory: l10n.washingMachine,
        subSubcategory: l10n.regular,
        features: [l10n.fullService, l10n.professionalRepair, l10n.testing],
      ),

      // Home Appliances - Refrigerator (Services 38-53)
      Service(
        id: '38',
        name: l10n.compressorChange,
        description: '${l10n.refrigerator} - ${l10n.compressorReplacement}',
        price: 196.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [
          l10n.compressorReplacement,
          l10n.professionalService,
          l10n.gasRefill
        ],
      ),
      Service(
        id: '39',
        name: l10n.changeExternalFan,
        description: '${l10n.refrigerator} - ${l10n.externalFanReplacement}',
        price: 150.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.fanReplacement, l10n.expertService, l10n.testing],
      ),
      Service(
        id: '40',
        name: l10n.changeInternalFan,
        description: '${l10n.refrigerator} - ${l10n.internalFanReplacement}',
        price: 150.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.fanReplacement, l10n.professionalService, l10n.testing],
      ),
      Service(
        id: '41',
        name: l10n.changeHeater,
        description: '${l10n.refrigerator} - ${l10n.heaterReplacement}',
        price: 173.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.heaterReplacement, l10n.qualityParts, l10n.testing],
      ),
      Service(
        id: '42',
        name: l10n.changeSensor,
        description: '${l10n.refrigerator} - ${l10n.sensorReplacement}',
        price: 104.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.sensorReplacement, l10n.expertService, l10n.testing],
      ),
      Service(
        id: '43',
        name: l10n.americanFreonFilling,
        description: '${l10n.refrigerator} - R134a gas refill',
        price: 230.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: ['American gas refill', 'Pressure check', 'Leak test'],
      ),
      Service(
        id: '44',
        name: l10n.indianFreonFilling,
        description: '${l10n.refrigerator} - Indian gas refill',
        price: 196.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: ['Indian gas refill', 'Pressure check', 'Testing'],
      ),
      Service(
        id: '45',
        name: l10n.externalLeakageMaintenance,
        description: '${l10n.refrigerator} - External leak repair',
        price: 173.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.leakDetection, l10n.professionalRepair, l10n.gasRefill],
      ),
      Service(
        id: '46',
        name: l10n.changeTimer,
        description: '${l10n.refrigerator} - Timer service',
        price: 104.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.timerReplacement, 'Adjustment', l10n.testing],
      ),
      Service(
        id: '47',
        name: l10n.smallCompressorReplacement,
        description: '${l10n.refrigerator} - Small compressor replacement',
        price: 196.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.compressorReplacement, l10n.gasRefill, l10n.testing],
      ),
      Service(
        id: '48',
        name: l10n.largeCompressorReplacement,
        description: '${l10n.refrigerator} - Large compressor replacement',
        price: 196.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.compressorReplacement, l10n.gasRefill, l10n.testing],
      ),
      Service(
        id: '49',
        name: l10n.leakRepairAmericanR134,
        description: '${l10n.refrigerator} - Leak repair with American gas',
        price: 288.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.leakRepair, 'American gas refill', l10n.testing],
      ),
      Service(
        id: '50',
        name: l10n.leakRepairAmericanR12,
        description: '${l10n.refrigerator} - Leak repair with American R12 gas',
        price: 380.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.leakRepair, 'R12 gas refill', l10n.professionalService],
      ),
      Service(
        id: '51',
        name: l10n.leakRepairChineseR134,
        description: '${l10n.refrigerator} - Leak repair with Chinese R134 gas',
        price: 380.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.leakRepair, 'Chinese gas refill', l10n.testing],
      ),
      Service(
        id: '52',
        name: l10n.leakRepairChineseR12,
        description: '${l10n.refrigerator} - Leak repair with Chinese R12 gas',
        price: 219.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [l10n.leakRepair, 'Chinese R12 gas', l10n.testing],
      ),
      Service(
        id: '53',
        name: l10n.leakRepairIndianR134,
        description: '${l10n.refrigerator} - Leak repair with Indian gas',
        price: 334.00,
        category: l10n.homeAppliances,
        subcategory: l10n.refrigerator,
        features: [
          l10n.leakRepair,
          'Indian gas refill',
          l10n.professionalService
        ],
      ),

      // Home Appliances - Oven (Services 54-58)
      Service(
        id: '54',
        name: l10n.changeKeys,
        description: '${l10n.oven} - Control keys replacement',
        price: 138.00,
        category: l10n.homeAppliances,
        subcategory: l10n.oven,
        features: ['Key replacement', l10n.expertService, l10n.testing],
      ),
      Service(
        id: '55',
        name: l10n.changeDoorHinges,
        description: '${l10n.oven} - Door hinge replacement',
        price: 138.00,
        category: l10n.homeAppliances,
        subcategory: l10n.oven,
        features: ['Hinge replacement', 'Door alignment', l10n.testing],
      ),
      Service(
        id: '56',
        name: l10n.ovenCleaning,
        description: '${l10n.oven} - Deep cleaning service',
        price: 184.00,
        category: l10n.homeAppliances,
        subcategory: l10n.oven,
        features: [
          l10n.deepCleaning,
          'Interior & exterior',
          l10n.professionalService
        ],
      ),
      Service(
        id: '57',
        name: l10n.smugglingMaintenance,
        description: '${l10n.oven} - Seal maintenance',
        price: 184.00,
        category: l10n.homeAppliances,
        subcategory: l10n.oven,
        features: ['Seal replacement', 'Temperature check', l10n.testing],
      ),
      Service(
        id: '58',
        name: l10n.microwaveMaintenance,
        description: '${l10n.oven} - Microwave repair',
        price: 230.00,
        category: l10n.homeAppliances,
        subcategory: l10n.oven,
        features: ['Microwave repair', 'Component check', l10n.testing],
      ),
    ];

    return _services;
  }

  static String getCategoryImage(String categoryName) {
    // Normalize category name for comparison (remove special chars, lowercase)
    final normalized = categoryName.toLowerCase().trim();

    // Category ID mapping (language-independent)
    final categoryIdMap = {
      // AC Services
      'AC Services': 'ac_services',
      'ac services': 'ac_services',
      'AC Repair': 'ac_services', // Added
      'ac repair': 'ac_services', // Added
      'AC Service': 'ac_services', // Added
      'ac service': 'ac_services', // Added
      'خدمات مكيفات الهواء': 'ac_services',
      'خدمات التكييف': 'ac_services',
      'تصليح مكيفات': 'ac_services', // Added common Arabic term

      // Home Appliances
      'Home Appliances': 'home_appliances',
      'home appliances': 'home_appliances',
      'أجهزة منزلية': 'home_appliances',
      'الأجهزة المنزلية': 'home_appliances',

      // Plumbing
      'Plumbing': 'plumbing',
      'plumbing': 'plumbing',
      'سباكة': 'plumbing',
      'السباكة': 'plumbing',

      // Electric
      'Electric': 'electric',
      'electric': 'electric',
      'Electrical': 'electric', // Added
      'electrical': 'electric', // Added
      'الكهرباء': 'electric',
    };

    // Image paths mapped by category ID
    final imagePathMap = {
      'ac_services': 'assets/images/ac_service.png',
      'home_appliances': 'assets/images/home_appliances.png',
      'plumbing': 'assets/images/plumbing.png',
      'electric': 'assets/images/electric.png',
    };

    // Try exact match first
    String? categoryId = categoryIdMap[categoryName];

    // If no exact match, try normalized match
    if (categoryId == null) {
      categoryId = categoryIdMap[normalized];
    }

    // Return image path or default
    return imagePathMap[categoryId] ?? 'assets/images/ac_service.png';
  }

  static List<ServiceCategory> getCategories(AppLocalizations l10n) {
    final services = _getServices(l10n);
    return [
      ServiceCategory(
        id: '1',
        name: l10n.acServices,
        description: l10n.acServicesDescription,
        icon: '❄️',
        services: services.where((s) => s.category == l10n.acServices).toList(),
        subcategories: [l10n.splitAc, l10n.windowAc, l10n.centralAc],
        imageUrl: 'assets/images/ac_service.png',
      ),
      ServiceCategory(
        id: '2',
        name: l10n.homeAppliances,
        description: l10n.homeAppliancesDescription,
        icon: '🏠',
        services:
            services.where((s) => s.category == l10n.homeAppliances).toList(),
        subcategories: [
          l10n.washingMachine,
          l10n.refrigerator,
          l10n.oven,
          l10n.stove,
          l10n.dishwasher
        ],
        imageUrl: 'assets/images/home_appliances.png',
      ),
      ServiceCategory(
        id: '3',
        name: l10n.plumbing,
        description: l10n.plumbingDescription,
        icon: '🔧',
        services: [],
        subcategories: [
          l10n.pipeRepair,
          l10n.drainCleaning,
          l10n.waterHeater,
          l10n.faucetInstallation
        ],
        imageUrl: 'assets/images/plumbing.png',
      ),
      ServiceCategory(
        id: '4',
        name: l10n.electric,
        description: l10n.electricDescription,
        icon: '⚡',
        services: [],
        subcategories: [
          l10n.wiring,
          l10n.switchSocket,
          l10n.circuitBreaker,
          l10n.lightingInstallation
        ],
      ),
    ];
  }

  static List<String> getSubcategories(
      String categoryName, AppLocalizations l10n) {
    try {
      // Get all categories
      final categories = getCategories(l10n);

      // Find category by direct name comparison first
      var category = categories.firstWhere(
        (c) => c.name == categoryName,
        orElse: () => categories.firstWhere(
          (c) =>
              _normalizeCategoryName(c.name) ==
              _normalizeCategoryName(categoryName),
        ),
      );

      return category.subcategories ?? [];
    } catch (e) {
      print("Error getting subcategories for $categoryName: $e");
      // Fallback to direct subcategory mapping
      return _getFallbackSubcategories(categoryName, l10n);
    }
  }

  static List<String> _getFallbackSubcategories(
      String categoryName, AppLocalizations l10n) {
    final normalized = _normalizeCategoryName(categoryName);

    if (normalized.contains('ac') || normalized.contains('تكييف')) {
      return [l10n.splitAc, l10n.windowAc, l10n.centralAc];
    } else if (normalized.contains('home') ||
        normalized.contains('appliance') ||
        normalized.contains('منزلية')) {
      return [
        l10n.washingMachine,
        l10n.refrigerator,
        l10n.oven,
        l10n.stove,
        l10n.dishwasher
      ];
    } else if (normalized.contains('plumb') || normalized.contains('سباك')) {
      return [
        l10n.pipeRepair,
        l10n.drainCleaning,
        l10n.waterHeater,
        l10n.faucetInstallation
      ];
    } else if (normalized.contains('electric') || normalized.contains('كهرب')) {
      return [
        l10n.wiring,
        l10n.switchSocket,
        l10n.circuitBreaker,
        l10n.lightingInstallation
      ];
    }

    return [];
  }

  static List<String> getWashingMachineTypes(AppLocalizations l10n) {
    return [
      l10n.automatic,
      l10n.regular,
      l10n.semiAutomatic,
      l10n.topLoad,
      l10n.frontLoad
    ];
  }

  static List<Service> getWashingMachineServices(
      String type, AppLocalizations l10n) {
    final services = _getServices(l10n);
    return services
        .where((s) =>
            s.category == l10n.homeAppliances &&
            s.subcategory == l10n.washingMachine &&
            s.subSubcategory == type)
        .toList();
  }

  static List<Service> getServicesBySubcategory(
      String categoryName, String subcategory, AppLocalizations l10n) {
    final services = _getServices(l10n);

    // Find services by direct comparison
    return services.where((s) {
      return s.category == categoryName && s.subcategory == subcategory;
    }).toList();
  }

  static Service? getServiceById(String serviceId, AppLocalizations l10n) {
    try {
      final services = _getServices(l10n);
      return services.firstWhere((s) => s.id == serviceId);
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
    required AppLocalizations l10n,
  }) {
    final service = getServiceById(serviceId, l10n);
    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      serviceId: serviceId,
      bookingDate: bookingDate,
      bookingTime: DateFormat('h:mm a').format(bookingTime),
      customerName: 'Test User',
      serviceName: service?.name ?? 'Unknown Service',
      address: '123 Main St, Lahore',
      basePrice: totalPrice,
      commission: 0,
      vat: 0,
      customerLanguage: l10n.localeName,
      status: BookingStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      paymentMethod:
          paymentMethod == 'cash' ? PaymentMethod.cash : PaymentMethod.online,
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

  static void addDummyCompletedBookings(String userId, AppLocalizations l10n) {
    _bookings.add(Booking(
      id: '${DateTime.now().millisecondsSinceEpoch - 100000}',
      userId: userId,
      serviceId: '2',
      bookingDate: DateTime.now().subtract(const Duration(days: 5)),
      bookingTime: DateFormat('h:mm a')
          .format(DateTime.now().subtract(const Duration(days: 5))),
      customerName: 'Test User',
      serviceName: 'Repairing Leaks',
      address: '123 Main St, Lahore',
      basePrice: 120.0,
      commission: 0,
      vat: 0,
      customerLanguage: l10n.localeName,
      status: BookingStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      updatedAt: DateTime.now(),
      paymentMethod: PaymentMethod.cash,
    ));

    _bookings.add(Booking(
      id: '${DateTime.now().millisecondsSinceEpoch - 200000}',
      userId: userId,
      serviceId: '26',
      bookingDate: DateTime.now().subtract(const Duration(days: 12)),
      bookingTime: DateFormat('h:mm a')
          .format(DateTime.now().subtract(const Duration(days: 12))),
      customerName: 'Test User',
      serviceName: 'General Cleaning',
      address: '123 Main St, Lahore',
      basePrice: 85.0,
      commission: 00,
      vat: 0,
      customerLanguage: l10n.localeName,
      status: BookingStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 13)),
      updatedAt: DateTime.now(),
      paymentMethod: PaymentMethod.online,
    ));

    _bookings.add(Booking(
      id: '${DateTime.now().millisecondsSinceEpoch - 300000}',
      userId: userId,
      serviceId: '38',
      bookingDate: DateTime.now().subtract(const Duration(days: 20)),
      bookingTime: DateFormat('h:mm a')
          .format(DateTime.now().subtract(const Duration(days: 20))),
      customerName: 'Test User',
      serviceName: 'Install New AC',
      address: '123 Main St, Lahore',
      basePrice: 240.0,
      commission: 0,
      vat: 0,
      customerLanguage: l10n.localeName,
      status: BookingStatus.accepted,
      createdAt: DateTime.now().subtract(const Duration(days: 21)),
      updatedAt: DateTime.now(),
      paymentMethod: PaymentMethod.online,
    ));
  }
}
