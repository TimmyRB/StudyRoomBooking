import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QRPage extends StatefulWidget {
  QRPage({Key key}) : super(key: key);

  @override
  QRState createState() => QRState();
}

class QRState extends State<QRPage> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              scan();
              print(barcode);
            },
            child: Text('QR Scanner')
          )
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
    } on PlatformException catch(e) {
      if (e.code == BarcodeScanner.CameraAccessDenied){
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