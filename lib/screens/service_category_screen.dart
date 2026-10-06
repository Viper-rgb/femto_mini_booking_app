import 'package:flutter/material.dart';

class ServiceCategoryScreen extends StatefulWidget {
  final String categoryTitle;

  const ServiceCategoryScreen({
    super.key,
    this.categoryTitle = 'Electrical Services',
  });

  @override
  State<ServiceCategoryScreen> createState() => _ServiceCategoryScreenState();
}

class _ServiceCategoryScreenState extends State<ServiceCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;

  // Filter chips options
  final List<String> _filters = ['All', 'Wiring', 'Repair', 'Installation'];

  // Mock services data for category screen
  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Ceiling Fan Repair',
      'description': 'Fixing noisy, slow or non-working ceiling fans.',
      'rating': '4.8',
      'reviews': '1.2k',
      'duration': '45-60 min',
      'price': '₹499',
      'imageUrl':
          'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=500&q=80',
    },
    {
      'title': 'Electrical Wiring',
      'description': 'New wiring, rewiring and panel installation.',
      'rating': '4.7',
      'reviews': '856',
      'duration': '60-90 min',
      'price': '₹799',
      'imageUrl':
          'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=500&q=80',
    },
    {
      'title': 'Switch Board Installation',
      'description': 'Installation and replacement of switch boards.',
      'rating': '4.6',
      'reviews': '942',
      'duration': '20-45 min',
      'price': '₹399',
      'imageUrl':
          'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=500&q=80',
    },
    {
      'title': 'MCB & DB Installation',
      'description': 'Safety switch and distribution board setup.',
      'rating': '4.7',
      'reviews': '421',
      'duration': '60-90 min',
      'price': '₹699',
      'imageUrl':
          'https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?w=500&q=80',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryTeal = Color(0xFF0F756D);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      // Top AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Color(0xFF1E293B),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF1E293B),
              size: 22,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          // Top search & filters container
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Column(
              children: [
                // Search bar with filter icon
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search electrical services...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                      suffixIcon: Icon(
                        Icons.tune_rounded,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Choice Chips for sub-category filter
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = _selectedFilterIndex == index;
                      return ChoiceChip(
                        label: Text(_filters[index]),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                          }
                        },
                        selectedColor: primaryTeal,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? primaryTeal
                              : Colors.grey.shade300,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        showCheckmark: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Services List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _services.length + 1, // +1 for loading indicator at end
              itemBuilder: (context, index) {
                // Bottom loading indicator
                if (index == _services.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: primaryTeal,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Loading more services...',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final service = _services[index];

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service thumbnail image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            service['imageUrl'] as String,
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 85,
                                height: 85,
                                color: const Color(0xFFE6F4F1),
                                child: const Icon(
                                  Icons.handyman_outlined,
                                  color: primaryTeal,
                                  size: 32,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Service info & Book button
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service['title'] as String,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                service['description'] as String,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Rating and Duration
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${service['rating']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '(${service['reviews']})',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey.shade500,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    service['duration'] as String,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Price & Book button
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    service['price'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: primaryTeal,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryTeal,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 6,
                                      ),
                                      minimumSize: const Size(64, 32),
                                    ),
                                    child: const Text(
                                      'Book',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
