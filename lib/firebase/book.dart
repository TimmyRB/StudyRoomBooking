import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:StudyRoomBooking/widgets/booking.dart';

import '../widgets/notFound.dart';

abstract class BaseBooker {
  Future<void> createBooking(String userId, String roomId, String title,
      int startTime, int endTime, List<String> party);

  // Future<void> getBooking(String bookingPath); // Get a Specific Booking

  Future<List<Widget>> getMyBookings(String userId, DateTime date);

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
  Future<List<Widget>> getMyBookings(String userId, DateTime date) async {
    List<Widget> bookingWidgets = [];

    List<dynamic> bookings = await dbRef
        .collection('Users')
        .document(userId)
        .get()
        .then((doc) async {
      if (!doc.exists) return [];

      if (!doc.data.containsKey('bookings')) return [];

      return await doc.data['bookings'];
    });

    bookings.forEach((booking) {
      booking.get().then((doc) async {
        if (!doc.exists) return;

        DateTime end = await doc.data['end'].toDate();

        if (DateTime.now().compareTo(end) >= 0) {
          await booking.delete();
          await dbRef.collection('Users').document(userId).updateData({
            'bookings': FieldValue.arrayRemove([booking])
          });

          return;
        }

        DateTime start = await doc.data['start'].toDate();

        if (start.day != date.day ||
            start.month != date.month ||
            start.year != date.year) return;

        DocumentReference roomRef = await doc.reference.parent().parent();
        var room = await roomRef.get().then((doc) {
          return doc.data;
        });

        bookingWidgets.add(Booking(
            title: doc.data['title'],
            start: start,
            end: end,
            roomName: room['name'],
            chairs: room['chairs'],
            screens: room['screens']));
      });
    });

    await Future.delayed(new Duration(seconds: 1));

    return bookingWidgets;
  }
}
