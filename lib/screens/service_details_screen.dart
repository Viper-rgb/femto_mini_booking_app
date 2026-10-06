import 'package:flutter/material.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? serviceData;

  const ServiceDetailsScreen({
    super.key,
    this.serviceData,
  });

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  bool _isFavorite = false;
  final int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    const primaryTeal = Color(0xFF0F756D);

    // Fallback/default service values matching design
    final title = widget.serviceData?['title'] ?? 'Ceiling Fan Repair';
    final price = widget.serviceData?['price'] ?? '₹499';
    final rating = widget.serviceData?['rating'] ?? '4.8';
    final reviews = widget.serviceData?['reviews'] ?? '1.2k';
    final duration = widget.serviceData?['duration'] ?? '45–60 min';
    final imageUrl = widget.serviceData?['imageUrl'] ??
        'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=800&q=80';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Hero Image with Overlays
                    Stack(
                      children: [
                        // Service Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(24),
                          ),
                          child: Image.network(
                            imageUrl,
                            height: 280,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 280,
                                color: const Color(0xFFE6F4F1),
                                child: const Center(
                                  child: Icon(
                                    Icons.handyman_outlined,
                                    size: 64,
                                    color: primaryTeal,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Back & Favorite Floating Action Buttons
                        Positioned(
                          top: 48,
                          left: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: Color(0xFF1E293B),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 48,
                          right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: IconButton(
                              icon: Icon(
                                _isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 20,
                                color:
                                    _isFavorite ? Colors.red : const Color(0xFF1E293B),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              },
                            ),
                          ),
                        ),

                        // Pagination Dots
                        Positioned(
                          bottom: 14,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width: _currentImageIndex == index ? 16 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: _currentImageIndex == index
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Details Body Container
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Price Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: primaryTeal,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Rating and Reviews
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '($reviews reviews)',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // Duration Indicator
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.access_time_rounded,
                                  size: 18,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    duration,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  Text(
                                    'Service duration',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Description
                          Text(
                            'Get your ceiling fan fixed by experienced and verified professionals. We handle all brands and types of ceiling fans with genuine parts and proper service guarantee.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Highlights / Feature Badges (3 cards)
                          Row(
                            children: [
                              _buildFeatureBadge(
                                icon: Icons.verified_user_outlined,
                                title: 'Verified',
                                subtitle: 'professionals',
                              ),
                              const SizedBox(width: 10),
                              _buildFeatureBadge(
                                icon: Icons.update_outlined,
                                title: 'Same-day',
                                subtitle: 'service',
                              ),
                              const SizedBox(width: 10),
                              _buildFeatureBadge(
                                icon: Icons.lock_outline_rounded,
                                title: 'Secure',
                                subtitle: 'booking',
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // What's Included Section
                          const Text(
                            "What's Included",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),

                          const SizedBox(height: 12),

                          _buildIncludedItem('Inspection & diagnosis'),
                          _buildIncludedItem('Cleaning and lubrication'),
                          _buildIncludedItem('Parts replacement (if needed)'),
                          _buildIncludedItem('Service warranty'),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Sticky "Book Now" Button Bar
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
                    // Navigate to Screen 4 (Booking Screen)
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
                    'Book Now',
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
      ),
    );
  }

  // Feature badge card builder
  Widget _buildFeatureBadge({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    const primaryTeal = Color(0xFF0F756D);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF4).withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primaryTeal.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryTeal, size: 22),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Included bullet item builder
  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF0F756D),
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }
}
