import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/house_model.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HouseModel house = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(house.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            house.imageUrl,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  house.location,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(
                  "Price: Rp ${house.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.bed, color: Colors.grey[700]),
                    Text(" ${house.bedroom} Bedroom"),
                    const SizedBox(width: 16),
                    Icon(Icons.bathtub, color: Colors.grey[700]),
                    Text(" ${house.bathroom} Bathroom"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
