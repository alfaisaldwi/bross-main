import 'package:flutter/material.dart';

class Booking {
  final String image;
  final String name;
  final DateTime date;
  final String description;

  Booking({
    required this.image,
    required this.name,
    required this.date,
    required this.description,
  });
}

class BookingHistory {
  static List<Booking> bookings = [];

  static void addBooking(Booking booking) {
    bookings.add(booking);
  }
}
