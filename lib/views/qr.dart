// Packages
import 'package:flutter/material.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/services.dart';

class QRPage extends StatefulWidget {
  QRPage({Key key, String barcode}) : super(key: key);

  @override
  QRState createState() => QRState();
}

class QRState extends State<QRPage> {
  String barcode = "";

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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('$barcode', style: Theme.of(context).textTheme.display1)
              ])
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
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
