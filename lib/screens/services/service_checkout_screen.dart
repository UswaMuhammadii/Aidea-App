// Update service_checkout_screen.dart

class _ServiceCheckoutScreenState extends State<ServiceCheckoutScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.user.address;
  }

  // Add address validation
  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    
    if (value.trim().length < 10) {
      return 'Please enter a complete address';
    }
    
    return null;
  }

  // Add notes validation (optional but with max length)
  String? _validateNotes(String? value) {
    if (value != null && value.trim().length > 500) {
      return 'Notes must be less than 500 characters';
    }
    return null;
  }

  Future<void> _submitRequest() async {
    // Validate date and time
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Please select a service date')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Please select a service time')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Validate the form (address)
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Please provide a valid address')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Check if selected date/time is in the past
    final bookingDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    if (bookingDateTime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Cannot book for past date/time')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    double totalPrice = 0;
    List<Booking> bookings = [];

    if (widget.isFromCart) {
      for (var cartItem in globalCart) {
        final booking = DummyDataService.createBooking(
          userId: widget.user.id,
          serviceId: cartItem.service.id,
          bookingDate: _selectedDate!,
          bookingTime: bookingDateTime,
          totalPrice: cartItem.totalPrice,
          quantity: cartItem.quantity,
          paymentMethod: 'pending',
          notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
        );
        bookings.add(booking);
        totalPrice += cartItem.totalPrice;
      }
      globalCart.clear();
    } else {
      totalPrice = widget.service.price * widget.quantity;
      final booking = DummyDataService.createBooking(
        userId: widget.user.id,
        serviceId: widget.service.id,
        bookingDate: _selectedDate!,
        bookingTime: bookingDateTime,
        totalPrice: totalPrice,
        quantity: widget.quantity,
        paymentMethod: 'pending',
        notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
      );
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
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... existing code

    return Scaffold(
      // ... existing scaffold properties
      body: Container(
        // ... existing container
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... existing service list section

                // ... existing date/time sections

                // ADDRESS SECTION with validation
                Text(
                  'Service Address',
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
                  child: TextFormField(
                    controller: _addressController,
                    style: TextStyle(color: textColor),
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Enter service address',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                      ),
                      filled: true,
                      fillColor: cardColor,
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red, width: 1),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: _validateAddress,
                  ),
                ),
                const SizedBox(height: 16),

                // NOTES SECTION with validation
                Text(
                  'Additional Notes (Optional)',
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
                  child: TextFormField(
                    controller: _notesController,
                    style: TextStyle(color: textColor),
                    maxLines: 3,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: 'Any special requests or notes...',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
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
                      counterText: '',
                    ),
                    validator: _validateNotes,
                  ),
                ),
                const SizedBox(height: 32),

                // ... rest of the build method
              ],
            ),
          ),
        ),
      ),
    );
  }
}
