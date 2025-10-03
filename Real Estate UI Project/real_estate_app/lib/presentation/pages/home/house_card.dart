import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../detail/detail_page.dart';

Widget houseCard(String name, String imageUrl, Map<String, String> data) {
  return GestureDetector(
    onTap: () {
      Get.to(
        () => const DetailPage(),
        arguments: {
          "title": data["name"],
          "image": data["image"],
          "location": data["location"] ?? "Jakarta, Indonesia",
          "price": data["price"] ?? "\$250,000",
        },
      );
    },
    child: Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.black.withOpacity(0.5),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    ),
  );
}
