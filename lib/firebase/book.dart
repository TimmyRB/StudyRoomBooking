import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:StudyRoomBooking/widgets/booking.dart';

import '../widgets/notFound.dart';

abstract class BaseBooker {
  Future<void> createBooking(String userId, String roomId, String title,
      int startTime, int endTime, List<String> party,
      {MaterialColor color});

  // Future<void> getBooking(String bookingPath); // Get a Specific Booking

  Future<List<Widget>> getMyBookings(String userId, DateTime date);

  Future<List<Widget>> getRoomBookings(
      String roomId); // Get all bookings for a room

  // Future<void> getCampusBookings(); // Get all bookings for current campus
}

class Booker implements BaseBooker {
  final dbRef = Firestore.instance;
  final String institute = 'Sheridan';
  final String campus = 'Trafalgar';

  @override
  Future<void> createBooking(String userId, String roomId, String title,
      int startTime, int endTime, List<String> party,
      {MaterialColor color}) async {
    DocumentReference docRef = await dbRef
        .collection(
            'Institutions/$institute/Campuses/$campus/Rooms/$roomId/Bookings')
        .add({
      'start': Timestamp.fromMillisecondsSinceEpoch(startTime),
      'end': Timestamp.fromMillisecondsSinceEpoch(endTime),
      'ownerId': userId,
      'title': title,
      'party': party,
      'color': (color.value != null ? color.value : Colors.red.value)
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

    for (DocumentReference booking in bookings) {
      DocumentSnapshot doc = await booking.get();
      if (!doc.exists) {
        await dbRef.collection('Users').document(userId).updateData({
          'bookings': FieldValue.arrayRemove([booking])
        });
        continue;
      }

      DateTime end = await doc.data['end'].toDate();

      if (DateTime.now().compareTo(end) >= 0) {
        await booking.delete();
        await dbRef.collection('Users').document(userId).updateData({
          'bookings': FieldValue.arrayRemove([booking])
        });

        continue;
      }

      DateTime start = await doc.data['start'].toDate();

      if (end.day != date.day ||
          end.month != date.month ||
          end.year != date.year) continue;

      DocumentReference roomRef = doc.reference.parent().parent();
      var room = await roomRef.get().then((doc) {
        return doc.data;
      });

      bookingWidgets.add(Booking(
          title: doc.data['title'],
          start: start,
          end: end,
          roomName: room['location'],
          chairs: room['chairs'],
          screens: room['screens'],
          partySize: doc.data['party'].length,
          color: new Color((doc.data['color'] != null
              ? doc.data['color']
              : Colors.red.value))));
    }

    if (bookingWidgets.length == 0)
      return [NotFound()];
    else
      return bookingWidgets;
  }

  @override
  Future<List<Widget>> getRoomBookings(String roomId) async {
    List<Widget> bookingWidgets = [];

    List<DocumentSnapshot> bookingDocs = await dbRef
        .collection(
            'Institutions/$institute/Campuses/$campus/Rooms/$roomId/Bookings')
        .orderBy("start")
        .getDocuments()
        .then((data) {
      return data.documents;
    });

    for (DocumentSnapshot booking in bookingDocs) {
      if (!booking.exists) continue;

      DateTime end = await booking.data['end'].toDate();
      DateTime start = await booking.data['start'].toDate();

      if (start.day != DateTime.now().day ||
          start.month != DateTime.now().month ||
          start.year != DateTime.now().year) continue;

      DocumentReference roomRef = booking.reference.parent().parent();
      var room = await roomRef.get().then((doc) {
        return doc.data;
      });

      bookingWidgets.add(Booking(
          title: booking.data['title'],
          start: start,
          end: end,
          roomName: room['location'],
          chairs: room['chairs'],
          screens: room['screens'],
          partySize: booking.data['party'].length,
          color: new Color((booking.data['color'] != null
              ? booking.data['color']
              : Colors.red.value))));
    }

    if (bookingWidgets.length == 0)
      return [NotFound()];
    else
      return bookingWidgets;
  }
}
