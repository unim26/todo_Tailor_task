import 'package:flutter/material.dart';
import 'package:get/get.dart';

void appSnacBar(BuildContext context, {String? message, String? type}) {
  Get.snackbar(
    type ?? 'Alert',
    message ?? 'Something happened',
    animationDuration: Duration(milliseconds: 300),
    backgroundColor: _getSnackbarColor(type),
    borderRadius: 13,
    colorText: Colors.white,
    dismissDirection: DismissDirection.down,
    icon: _getSnackbarIcon(type),
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.all(20),
  );
}

Color _getSnackbarColor(String? type) {
  switch (type?.toLowerCase()) {
    case 'warning':
      return Colors.amber.shade700;
    case 'alert':
      return Colors.blue.shade600;
    case 'success':
      return Colors.green.shade600;
    case 'error':
    default:
      return Colors.redAccent;
  }
}

Icon _getSnackbarIcon(String? type) {
  switch (type?.toLowerCase()) {
    case 'warning':
      return Icon(Icons.warning, color: Colors.white);
    case 'alert':
      return Icon(Icons.info, color: Colors.white);
    case 'success':
      return Icon(Icons.thumb_up, color: Colors.white);
    case 'error':
    default:
      return Icon(Icons.thumb_down, color: Colors.white);
  }
}
