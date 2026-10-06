import 'package:flutter/material.dart';

class ServiceModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final String price;
  final String duration;
  final String rating;
  final String reviews;
  final String imageUrl;
  final List<String> includedItems;

  ServiceModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.duration,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.includedItems,
  });
}

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class BookingModel {
  final String id;
  final String bookingId;
  final ServiceModel service;
  final String date;
  final String timeSlot;
  final String customerName;
  final String customerPhone;
  final String address;
  final String status; // 'Confirmed' or 'Completed'

  BookingModel({
    required this.id,
    required this.bookingId,
    required this.service,
    required this.date,
    required this.timeSlot,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    this.status = 'Confirmed',
  });
}
