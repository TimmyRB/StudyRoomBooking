// Packages
import 'package:flutter/material.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/services.dart';

import '../firebase/book.dart';
import '../widgets/notFound.dart';

class QRPage extends StatefulWidget {
  QRPage({Key key, String barcode, this.booker}) : super(key: key);

  final BaseBooker booker;

  @override
  QRState createState() => QRState();
}

class QRState extends State<QRPage> {
  String barcode = "";
  Widget _bookings = NotFound();

  @override
  void initState() {
    super.initState();
    scan();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[BoxShadow(blurRadius: 6.0)],
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Container(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: _bookings),
                  ))
            ]));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      this.barcode = barcode;
      widget.booker.getRoomBookings(barcode).then((list) {
        setState(() {
          _bookings = ListView(children: list);
        });
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = "Camera Access Denied";
        });
      } else {
        setState(() {
          this.barcode = "Unknown Error $e";
        });
      }
    } on FormatException {
      setState(() {
        this.barcode = "User Interrupt";
      });
    } catch (e) {
      setState(() {
        this.barcode = "Unknown Error $e";
      });
    }
  }
}
