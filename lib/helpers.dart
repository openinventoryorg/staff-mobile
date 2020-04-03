library helpers;

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openinventory_staff_app/controllers/api.dart';
import 'package:openinventory_staff_app/routes/router.dart';

abstract class Helpers {
  static Future<String> scanQR() async {
    String barcode;
    try {
      barcode = await BarcodeScanner.scan();
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print('The user did not grant the camera permission!');
      } else {
        print('Unknown error: $e');
      }
    } on FormatException {
      // User pressed back
    } catch (e) {
      print('Unknown error: $e');
    }
    return barcode;
  }

  /// Logs the user out
  static Future<void> logout(BuildContext context) async {
    await ApiController.of(context).logOut();
    AppRouter.freshNavigate(context, '/');
  }
}
