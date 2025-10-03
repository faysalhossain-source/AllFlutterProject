import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  static void showSnack(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  static String formatPrice(num price) {
    return "\$${price.toStringAsFixed(0)}";
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
