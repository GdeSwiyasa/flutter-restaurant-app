import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:restaurant_app/common/color.dart';

class CustomSnackBar {
  success(message) {
    return showSimpleNotification(
        Text("Success", style: TextStyle(color: Colors.white)),
        subtitle: Text("- " + message, style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 3),
        slideDismissDirection: DismissDirection.horizontal,
        background: CustomColor().blueLight);
  }

  error(String message) {
    return showSimpleNotification(
        Text("Success", style: TextStyle(color: Colors.white)),
        subtitle: Text("- " + message, style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 3),
        slideDismissDirection: DismissDirection.horizontal,
        background: CustomColor().fieryRose);
  }
}
