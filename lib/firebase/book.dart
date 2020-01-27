import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseBooker {
  Future<void> createBooking(String userId, String roomId, String title, Timestamp startTime, Timestamp endTime, List<String> party);

  // Future<void> getBooking(String bookingPath); // Get a Specific Booking

  // Future<void> getMyBookings(String userId);

  // Future<void> getRoomBookings(String roomId); // Get all bookings for a room

  // Future<void> getCampusBookings(); // Get all bookings for current campus
}

class Booker implements BaseBooker {
  final dbRef = Firestore.instance;
  final String institute = 'Sheridan';
  final String campus = 'Trafalgar';

  Future<void> createBooking(String userId, String roomId, String title, Timestamp startTime, Timestamp endTime, List<String> party) async {
    await dbRef.collection('Institutions/$institute/Campuses/$campus/Rooms/$roomId/Bookings').add({
      'start': startTime,
      'end': endTime,
      'ownerId': userId,
      'title': title,
      'party': party
    });
  }

}
