import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../gen_l10n/app_localizations.dart';
import '../../models/user_model.dart';
import '../../models/service_model.dart';
import '../../models/booking_model.dart';
import '../../models/cart_model.dart';

import '../../services/firestore_service.dart';
import '../booking/booking_confirmation_screen.dart';
import '../maps/map_selection_screen.dart'; // ✅ ADD THIS IMPORT
import '../../utils/icons_helper.dart';
import '../../utils/formatting_utils.dart';
import '../../utils/app_colors.dart';

class ServiceCheckoutScreen extends StatefulWidget {
  final Service service;
  final User user;
  final int quantity;
  final bool isFromCart;

  const ServiceCheckoutScreen({
    super.key,
    required this.service,
    required this.user,
    this.quantity = 1,
    this.isFromCart = false,
  });

  @override
  State<ServiceCheckoutScreen> createState() => _ServiceCheckoutScreenState();
}

class _ServiceCheckoutScreenState extends State<ServiceCheckoutScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;

  // ✅ ADD THESE VARIABLES FOR MAP INTEGRATION
  double? _selectedLatitude;
  double? _selectedLongitude;

  Widget _getIconForServiceItem(Service service) {
    return IconHelper.getServiceIcon(
      category: service.category,
      subcategory: service.subcategory,
      subSubcategory: service.subSubcategory,
      serviceName: service.name,
      color: Colors.blue,
      size: 28,
    );
  }

  @override
  void initState() {
    super.initState();
    // Use the primary saved address if available, otherwise fallback to the profile address
    if (widget.user.savedAddresses.isNotEmpty) {
      final primaryAddress = widget.user.savedAddresses.firstWhere(
        (addr) => addr.isPrimary,
        orElse: () => widget.user.savedAddresses.first,
      );
      _addressController.text = primaryAddress.fullAddress;
    } else {
      _addressController.text = widget.user.address;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // ✅ ADD THIS METHOD FOR MAP SELECTION
  void _openMapSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSelectionScreen(
          initialAddress: _addressController.text.isNotEmpty
              ? _addressController.text
              : null,
          onLocationSelected: (address, lat, lng) {
            setState(() {
              _addressController.text = address;
              _selectedLatitude = lat;
              _selectedLongitude = lng;
            });

            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text('${l10n.selectedLocation}: $address'),
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final l10n = AppLocalizations.of(context)!;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTime = null;
      });
    }
  }

  Future<void> _selectTime() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedDate == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.pleaseSelectADateFirst),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _getLocalizedServiceName(Service service, AppLocalizations l10n) {
    if (l10n.localeName != 'ar') {
      return service.name;
    }
    return service.nameArabic.isNotEmpty ? service.nameArabic : service.name;
  }

  Future<void> _submitRequest() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedDate == null || _selectedTime == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.pleaseSelectBothDateAndTime),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (_addressController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.pleaseEnterYourAddress),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() => _isLoading = true);

    final bookingDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    // Format time as HH:mm
    final formattedTime = DateFormat('HH:mm').format(bookingDateTime);

    final firestoreService = FirestoreService();
    List<Booking> bookings = [];
    double totalPrice = 0;

    try {
      if (widget.isFromCart) {
        for (var cartItem in globalCart) {
          final bookingId = DateTime.now().millisecondsSinceEpoch.toString() +
              cartItem.service.id.substring(0, 3);
          final booking = Booking(
            id: bookingId,
            userId: widget.user.id,
            customerName: widget.user.name,
            customerLanguage: l10n.localeName,
            serviceId: cartItem.service.id,
            serviceName: cartItem.service.name,
            serviceNameArabic: cartItem.service.nameArabic,
            address: _addressController.text,
            bookingDate: _selectedDate!,
            bookingTime: formattedTime,
            status: BookingStatus.pending,
            basePrice: cartItem.service.basePrice,
            commission: cartItem.service.commission,
            vat: cartItem.service.vat,
            // totalPrice is a getter in Booking that uses basePrice + extras.
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            notes:
                _notesController.text.isNotEmpty ? _notesController.text : null,
          );

          await firestoreService.createBooking(booking);
          bookings.add(booking);
          totalPrice += cartItem.totalPrice;
        }
        globalCart.clear();
      } else {
        totalPrice = widget.service.price * widget.quantity;
        final bookingId = DateTime.now().millisecondsSinceEpoch.toString() +
            widget.service.id.substring(0, 3);

        final booking = Booking(
          id: bookingId,
          userId: widget.user.id,
          customerName: widget.user.name,
          customerLanguage: l10n.localeName,
          serviceId: widget.service.id,
          serviceName: widget.service.name,
          serviceNameArabic: widget.service.nameArabic,
          address: _addressController.text,
          bookingDate: _selectedDate!,
          bookingTime: formattedTime,
          status: BookingStatus.pending,
          basePrice: widget.service.basePrice,
          commission: widget.service.commission,
          vat: widget.service.vat,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          notes:
              _notesController.text.isNotEmpty ? _notesController.text : null,
        );

        await firestoreService.createBooking(booking);
        bookings.add(booking);
      }

      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingConfirmationScreen(
              bookings: bookings,
              user: widget.user,
              totalAmount: totalPrice,
              l10n: l10n,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error creating booking: $e');
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating booking: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    final shadowOpacity = isDark ? 0.3 : 0.05;

    double totalPrice = widget.isFromCart
        ? globalCart.fold(0.0, (sum, item) => sum + item.totalPrice)
        : widget.service.price * widget.quantity;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(l10n.bookService),
        centerTitle: true,
        backgroundColor: cardColor,
        foregroundColor: textColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SELECTED SERVICES SECTION
              Text(
                l10n.selectedServices,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(shadowOpacity),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: widget.isFromCart
                      ? globalCart.map((item) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF334155)
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: _getIconForServiceItem(item.service),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getLocalizedServiceName(
                                            item.service, l10n),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  FormattingUtils.formatCurrency(
                                      item.totalPrice, l10n, locale),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList()
                      : [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF334155)
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: _getIconForServiceItem(widget.service),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getLocalizedServiceName(
                                            widget.service, l10n),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  FormattingUtils.formatCurrency(
                                      totalPrice, l10n, locale),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                ),
              ),
              const SizedBox(height: 24),

              // DATE SELECTION SECTION
              Text(
                l10n.selectDate,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(shadowOpacity),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Card(
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      _selectedDate != null
                          ? FormattingUtils.formatDateLong(
                              context, _selectedDate!)
                          : l10n.chooseADate,
                      style: TextStyle(color: textColor),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: _selectDate,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // TIME SELECTION SECTION
              Text(
                l10n.selectTime,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(shadowOpacity),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Card(
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(
                      Icons.access_time,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      _selectedTime != null
                          ? _selectedTime!.format(context)
                          : l10n.chooseATime,
                      style: TextStyle(color: textColor),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: _selectTime,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ✅ UPDATED ADDRESS SECTION WITH MAP INTEGRATION
              Text(
                l10n.serviceAddress,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(shadowOpacity),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _addressController,
                  style: TextStyle(color: textColor),
                  maxLines: 2,
                  readOnly:
                      true, // ✅ Make it read-only since we select from map
                  onTap: _openMapSelection, // ✅ Open map on tap
                  decoration: InputDecoration(
                    hintText: l10n.enterServiceAddress,
                    hintStyle: TextStyle(
                      color:
                          isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    ),
                    filled: true,
                    fillColor: cardColor,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.map,
                        color: AppColors.electricBlue,
                      ),
                      onPressed: _openMapSelection,
                      tooltip: 'Select from map',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              if (_selectedLatitude != null && _selectedLongitude != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Location coordinates saved',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),

              // NOTES SECTION
              Text(
                l10n.additionalNotesOptional,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(shadowOpacity),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _notesController,
                  style: TextStyle(color: textColor),
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: l10n.anySpecialRequestsOrNotes,
                    hintStyle: TextStyle(
                      color:
                          isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    ),
                    filled: true,
                    fillColor: cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // BOOKING SUMMARY SECTION (LIGHT BLUE)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      AppColors.electricBlue.withOpacity(0.1), // ✅ LIGHT BLUE
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(shadowOpacity),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.receipt_long,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.requestSummary,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${l10n.services}:',
                            style: TextStyle(color: subtitleColor),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: widget.isFromCart
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: globalCart.map((item) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          _getLocalizedServiceName(
                                              item.service, l10n),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: textColor,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : Text(
                                    _getLocalizedServiceName(
                                        widget.service, l10n),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: textColor,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${l10n.date}:',
                              style: TextStyle(color: subtitleColor)),
                          Text(
                            _selectedDate != null
                                ? FormattingUtils.formatDateShort(
                                    context, _selectedDate!)
                                : l10n.notSelected,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${l10n.time}:',
                              style: TextStyle(color: subtitleColor)),
                          Text(
                            _selectedTime != null
                                ? _selectedTime!.format(context)
                                : l10n.notSelected,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.estimatedPrice,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                          ),
                          Text(
                            FormattingUtils.formatCurrency(
                                totalPrice, l10n, locale),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // SUBMIT REQUEST BUTTON (ELECTRIC BLUE)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.electricBlue, // ✅ ELECTRIC BLUE
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.electricBlue.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _submitRequest,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.send, size: 20),
                              const SizedBox(width: 12),
                              Text(
                                l10n.submitRequest,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
