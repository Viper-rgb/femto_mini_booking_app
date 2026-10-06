import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/service_model.dart';
import '../providers/service_provider.dart';
import 'confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic>? serviceData;

  const BookingScreen({
    super.key,
    this.serviceData,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _nameController =
      TextEditingController(text: 'John Mathew');
  final TextEditingController _phoneController =
      TextEditingController(text: '+91 98765 43210');
  final TextEditingController _addressController =
      TextEditingController(text: '12/4, Jubilee Road, Kollam, Kerala');

  // Selected date & time slots
  int _selectedDateIndex = 0;
  String _selectedTimeSlot = '10:00 AM';

  // Dates list
  final List<Map<String, String>> _availableDates = [
    {'day': 'Mon', 'date': '5', 'month': 'May'},
    {'day': 'Tue', 'date': '6', 'month': 'May'},
    {'day': 'Wed', 'date': '7', 'month': 'May'},
    {'day': 'Thu', 'date': '8', 'month': 'May'},
    {'day': 'Fri', 'date': '9', 'month': 'May'},
    {'day': 'Sat', 'date': '10', 'month': 'May'},
  ];

  // Time slots grouped by period
  final List<String> _morningSlots = ['08:00 AM', '09:00 AM', '10:00 AM'];
  final List<String> _afternoonSlots = ['12:00 PM', '01:00 PM', '02:00 PM'];
  final List<String> _eveningSlots = ['04:00 PM', '05:00 PM', '06:00 PM'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Open Flutter DatePicker (from PDF cheat sheet)
  Future<void> _pickCustomDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2026, 5, 5),
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2027, 12, 31),
      helpText: 'Select service date',
      confirmText: 'OK',
      cancelText: 'CANCEL',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0F756D),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Date selected: ${picked.day}/${picked.month}/${picked.year}',
          ),
          backgroundColor: const Color(0xFF0F756D),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryTeal = Color(0xFF0F756D);

    final title = widget.serviceData?['title'] ?? 'Ceiling Fan Repair';
    final price = widget.serviceData?['price'] ?? '₹499';
    final rating = widget.serviceData?['rating'] ?? '4.8';
    final reviews = widget.serviceData?['reviews'] ?? '1.2k';
    final duration = widget.serviceData?['duration'] ?? '45–60 min';
    final imageUrl = widget.serviceData?['imageUrl'] ??
        'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=500&q=80';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF1E293B),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Book Service',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stepper Indicator (1 Service -> 2 Schedule -> 3 Details)
                    _buildStepper(primaryTeal),

                    const SizedBox(height: 18),

                    // Selected Service Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              width: 65,
                              height: 65,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 65,
                                  height: 65,
                                  color: const Color(0xFFE6F4F1),
                                  child: const Icon(
                                    Icons.handyman_outlined,
                                    color: primaryTeal,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$price  •  $duration',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryTeal,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      '$rating ($reviews)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Date Selection Header & Custom Picker Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            color: primaryTeal,
                            size: 20,
                          ),
                          onPressed: _pickCustomDate,
                          tooltip: 'Pick date from calendar',
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Horizontal Date Cards
                    SizedBox(
                      height: 72,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _availableDates.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final dateItem = _availableDates[index];
                          final isSelected = _selectedDateIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDateIndex = index;
                              });
                            },
                            child: Container(
                              width: 54,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryTeal : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? primaryTeal
                                      : Colors.grey.shade200,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dateItem['day']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey.shade500,
                                    ),
                                  ),
                                  Text(
                                    dateItem['date']!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF1E293B),
                                    ),
                                  ),
                                  Text(
                                    dateItem['month']!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Time Slot Selection Header
                    const Text(
                      'Select Time Slot',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Morning Slots
                    _buildTimeSlotSection('Morning', _morningSlots, primaryTeal),
                    const SizedBox(height: 10),

                    // Afternoon Slots
                    _buildTimeSlotSection(
                        'Afternoon', _afternoonSlots, primaryTeal),
                    const SizedBox(height: 10),

                    // Evening Slots
                    _buildTimeSlotSection('Evening', _eveningSlots, primaryTeal),

                    const SizedBox(height: 24),

                    // Customer Details Header
                    const Text(
                      'Customer Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Customer Form Container
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter your name',
                              prefixIcon: const Icon(
                                Icons.person_outline_rounded,
                                color: primaryTeal,
                                size: 20,
                              ),
                              suffixIcon: const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF10B981),
                                size: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 14),

                          // Phone Number Field
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'Enter phone number',
                              prefixIcon: const Icon(
                                Icons.phone_outlined,
                                color: primaryTeal,
                                size: 20,
                              ),
                              suffixIcon: const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF10B981),
                                size: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Phone number is required';
                              }
                              if (value.trim().length < 10) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 14),

                          // Address Field
                          TextFormField(
                            controller: _addressController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              hintText: 'Enter service address',
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: primaryTeal,
                                size: 20,
                              ),
                              suffixIcon: const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF10B981),
                                size: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Address is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Continue Button Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, -3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final selectedDate = _availableDates[_selectedDateIndex];
                    final fullDateStr =
                        '${selectedDate['day']}, ${selectedDate['date']} ${selectedDate['month']} 2026';

                    final serviceModel = ServiceModel(
                      id: 'srv_${DateTime.now().millisecondsSinceEpoch}',
                      title: widget.serviceData?['title'] ?? 'Ceiling Fan Repair',
                      category: 'Electrician',
                      description: 'Doorstep service appointment',
                      price: widget.serviceData?['price'] ?? '₹499',
                      duration: widget.serviceData?['duration'] ?? '45–60 min',
                      rating: widget.serviceData?['rating'] ?? '4.8',
                      reviews: widget.serviceData?['reviews'] ?? '1.2k',
                      imageUrl: widget.serviceData?['imageUrl'] ??
                          'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=500&q=80',
                      includedItems: ['Standard inspection', 'Service warranty'],
                    );

                    final bookingModel = BookingModel(
                      id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
                      bookingId: '#FAMTO-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                      service: serviceModel,
                      date: fullDateStr,
                      timeSlot: _selectedTimeSlot,
                      customerName: _nameController.text.trim(),
                      customerPhone: _phoneController.text.trim(),
                      address: _addressController.text.trim(),
                      status: 'Confirmed',
                    );

                    context.read<ServiceProvider>().addBooking(bookingModel);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationScreen(
                          bookingData: {
                            'title': bookingModel.service.title,
                            'price': bookingModel.service.price,
                            'duration': bookingModel.service.duration,
                            'rating': bookingModel.service.rating,
                            'reviews': bookingModel.service.reviews,
                            'imageUrl': bookingModel.service.imageUrl,
                            'date': bookingModel.date,
                            'timeSlot': bookingModel.timeSlot,
                            'address': bookingModel.address,
                            'customerName': bookingModel.customerName,
                            'customerPhone': bookingModel.customerPhone,
                            'bookingId': bookingModel.bookingId,
                          },
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryTeal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Visual Stepper (1 Service -> 2 Schedule -> 3 Details)
  Widget _buildStepper(Color primaryTeal) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepNode(number: '1', label: 'Service', isDone: true, primaryTeal: primaryTeal),
          _buildStepDivider(isActive: true, primaryTeal: primaryTeal),
          _buildStepNode(number: '2', label: 'Schedule', isCurrent: true, primaryTeal: primaryTeal),
          _buildStepDivider(isActive: false, primaryTeal: primaryTeal),
          _buildStepNode(number: '3', label: 'Details', isPending: true, primaryTeal: primaryTeal),
        ],
      ),
    );
  }

  Widget _buildStepNode({
    required String number,
    required String label,
    bool isDone = false,
    bool isCurrent = false,
    bool isPending = false,
    required Color primaryTeal,
  }) {
    Color bgColor;
    Color textColor;
    if (isDone || isCurrent) {
      bgColor = primaryTeal;
      textColor = Colors.white;
    } else {
      bgColor = const Color(0xFFF1F5F9);
      textColor = Colors.grey.shade500;
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: bgColor,
          child: isDone
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : Text(
                  number,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
            color: isCurrent ? const Color(0xFF1E293B) : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildStepDivider({required bool isActive, required Color primaryTeal}) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
        color: isActive ? primaryTeal : Colors.grey.shade300,
      ),
    );
  }

  // Time slot section builder
  Widget _buildTimeSlotSection(
    String period,
    List<String> slots,
    Color primaryTeal,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          period,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: slots.map((slot) {
            final isSelected = _selectedTimeSlot == slot;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTimeSlot = slot;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryTeal : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? primaryTeal : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        slot,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
