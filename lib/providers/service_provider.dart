import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceProvider with ChangeNotifier {
  // Pattern A: State Variables
  List<ServiceModel> _services = [];
  List<CategoryModel> _categories = [];
  List<BookingModel> _bookings = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedCategory = 'All';

  // Getters
  List<ServiceModel> get services => _selectedCategory == 'All'
      ? _services
      : _services.where((s) => s.category == _selectedCategory).toList();

  List<ServiceModel> get allServices => _services;
  List<CategoryModel> get categories => _categories;
  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  // Pattern A: Fetch Services Method
  Future<void> fetchServices() async {
    _isLoading = true; // 1. start loading
    _errorMessage = '';
    notifyListeners(); //    tell UI to show spinner

    try {
      // Simulate network / local data load
      await Future.delayed(const Duration(milliseconds: 900));

      // 2. Fill the categories list
      _categories = [
        CategoryModel(
          id: 'cat_1',
          name: 'Electrician',
          icon: Icons.electrical_services_outlined,
        ),
        CategoryModel(
          id: 'cat_2',
          name: 'Plumber',
          icon: Icons.plumbing_outlined,
        ),
        CategoryModel(
          id: 'cat_3',
          name: 'AC Repair',
          icon: Icons.ac_unit_outlined,
        ),
        CategoryModel(
          id: 'cat_4',
          name: 'Cleaning',
          icon: Icons.cleaning_services_outlined,
        ),
        CategoryModel(
          id: 'cat_5',
          name: 'Painting',
          icon: Icons.format_paint_outlined,
        ),
      ];

      // Fill the services list with mock/local data
      _services = [
        ServiceModel(
          id: 'srv_1',
          title: 'Ceiling Fan Repair',
          category: 'Electrician',
          description: 'Fixing noisy, slow or non-working ceiling fans.',
          price: '₹499',
          duration: '45–60 min',
          rating: '4.8',
          reviews: '1.2k',
          imageUrl:
              'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=500&q=80',
          includedItems: [
            'Inspection & diagnosis',
            'Cleaning and lubrication',
            'Parts replacement (if needed)',
            'Service warranty',
          ],
        ),
        ServiceModel(
          id: 'srv_2',
          title: 'Electrical Wiring',
          category: 'Electrician',
          description: 'New wiring, rewiring and panel installation.',
          price: '₹799',
          duration: '60–90 min',
          rating: '4.7',
          reviews: '856',
          imageUrl:
              'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=500&q=80',
          includedItems: [
            'Concealed & open wiring check',
            'Circuit testing',
            'High-voltage safety inspection',
            '30-day warranty',
          ],
        ),
        ServiceModel(
          id: 'srv_3',
          title: 'Switch Board Installation',
          category: 'Electrician',
          description: 'Installation and replacement of switch boards.',
          price: '₹399',
          duration: '20–45 min',
          rating: '4.6',
          reviews: '942',
          imageUrl:
              'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=500&q=80',
          includedItems: [
            'Old board uninstallation',
            'New modular board setup',
            'Load connection check',
          ],
        ),
        ServiceModel(
          id: 'srv_4',
          title: 'MCB & DB Installation',
          category: 'Electrician',
          description: 'Safety switch and distribution board setup.',
          price: '₹699',
          duration: '60–90 min',
          rating: '4.7',
          reviews: '421',
          imageUrl:
              'https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?w=500&q=80',
          includedItems: [
            'Short-circuit protection test',
            'Distribution box wiring',
            'Safety isolator test',
          ],
        ),
        ServiceModel(
          id: 'srv_5',
          title: 'Plumbing Pipe Repair',
          category: 'Plumber',
          description: 'Fixing pipeline leaks, drainage, and blockages.',
          price: '₹399',
          duration: '45 min',
          rating: '4.8',
          reviews: '980',
          imageUrl:
              'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500&q=80',
          includedItems: [
            'Leak detection',
            'Pipe sealing & replacement',
            'Pressure testing',
          ],
        ),
        ServiceModel(
          id: 'srv_6',
          title: 'AC Deep Service',
          category: 'AC Repair',
          description: 'Complete foam & jet wash cleaning of indoor/outdoor units.',
          price: '₹799',
          duration: '1 hr',
          rating: '4.6',
          reviews: '1.5k',
          imageUrl:
              'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=500&q=80',
          includedItems: [
            'Indoor unit jet wash',
            'Cooling coil cleaning',
            'Gas level inspection',
          ],
        ),
      ];

      // Initial active & history bookings
      _bookings = [
        BookingModel(
          id: 'bk_1',
          bookingId: '#FAMTO-584726',
          service: _services[0],
          date: 'Mon, 5 May 2026',
          timeSlot: '10:00 AM',
          customerName: 'John Mathew',
          customerPhone: '+91 98765 43210',
          address: '12/4, Jubilee Road, Kollam, Kerala - 691001',
          status: 'Confirmed',
        ),
        BookingModel(
          id: 'bk_2',
          bookingId: '#FAMTO-412984',
          service: _services[5],
          date: '28 Apr 2026',
          timeSlot: '11:00 AM',
          customerName: 'John Mathew',
          customerPhone: '+91 98765 43210',
          address: '12/4, Jubilee Road, Kollam, Kerala - 691001',
          status: 'Completed',
        ),
        BookingModel(
          id: 'bk_3',
          bookingId: '#FAMTO-398112',
          service: _services[4],
          date: '15 Apr 2026',
          timeSlot: '02:30 PM',
          customerName: 'John Mathew',
          customerPhone: '+91 98765 43210',
          address: '12/4, Jubilee Road, Kollam, Kerala - 691001',
          status: 'Completed',
        ),
      ];
    } catch (e) {
      _errorMessage = 'Failed to load services: $e';
    } finally {
      _isLoading = false; // 3. stop loading
      notifyListeners(); //    tell UI to show data
    }
  }

  // Filter category
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Add a new booking
  void addBooking(BookingModel booking) {
    _bookings.insert(0, booking);
    notifyListeners();
  }

  // Cancel booking
  void cancelBooking(String bookingId) {
    _bookings.removeWhere((b) => b.bookingId == bookingId);
    notifyListeners();
  }
}
