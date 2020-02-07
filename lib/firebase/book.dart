import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseBooker {
  Future<void> createBooking(String userId, String roomId, String title,
      int startTime, int endTime, List<String> party);

  // Future<void> getBooking(String bookingPath); // Get a Specific Booking

  Future<Widget> getMyBookings(String userId);

  // Future<void> getRoomBookings(String roomId); // Get all bookings for a room

  // Future<void> getCampusBookings(); // Get all bookings for current campus
}

class Booker implements BaseBooker {
  final dbRef = Firestore.instance;
  final String institute = 'Sheridan';
  final String campus = 'Trafalgar';

  @override
  Future<void> createBooking(String userId, String roomId, String title,
      int startTime, int endTime, List<String> party) async {
    DocumentReference docRef = await dbRef
        .collection(
            'Institutions/$institute/Campuses/$campus/Rooms/$roomId/Bookings')
        .add({
      'start': Timestamp.fromMillisecondsSinceEpoch(startTime),
      'end': Timestamp.fromMillisecondsSinceEpoch(endTime),
      'ownerId': userId,
      'title': title,
      'party': party
    });
    dbRef.collection('Users').document(userId).updateData({
      'bookings': FieldValue.arrayUnion([docRef])
    });
  }

  @override
  Future<Widget> getMyBookings(String userId) async {
    List<dynamic> bookings =
        await dbRef.collection('Users').document(userId).get().then((doc) {
      if (!doc.exists) return [];

      if (!doc.data.containsKey('bookings')) return [];

      return doc.data['bookings'];
    });

    bookings.forEach((booking) {
      booking.get().then((doc) {
        if (!doc.exists) return;

        DateTime end = doc.data['end'].toDate();

        if (DateTime.now().compareTo(end) >= 0) {
          booking.delete();
          dbRef.collection('Users').document(userId).updateData({
            'bookings': FieldValue.arrayRemove([booking])
          });
          return;
        }
      });
    });
    return null;
  }
}
