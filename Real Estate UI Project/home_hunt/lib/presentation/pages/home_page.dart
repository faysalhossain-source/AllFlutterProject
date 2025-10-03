import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_hunt/presentation/controllers/home_controller.dart';

import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => Get.toNamed(AppRoutes.menu),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Location",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              "Jakarta",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 🔍 Search Field
            TextField(
              decoration: InputDecoration(
                hintText: "Search address, or near you",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 8,
              children: [
                _buildChip("House"),
                _buildChip("Apartment"),
                _buildChip("Hotel"),
                _buildChip("Villa"),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Near from you",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildNearbyList(),

            const SizedBox(height: 24),

            const Text(
              "Best for you",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBestList(),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Obx(() {
      final isSelected = controller.selectedCategory.value == label;

      return ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        selected: isSelected,
        selectedColor: Colors.blue,
        backgroundColor: Colors.grey[200],
        onSelected: (_) => controller.changeCategory(label),
        showCheckmark: false,
      );
    });
  }

  Widget _buildNearbyList() {
    final nearby = controller.houses.where((h) => h.isNearby).toList();

    return Column(
      children: nearby.map((house) {
        return GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.detail, arguments: house),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(house.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            height: 180,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      house.title,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      house.location,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    if (house.distance != null)
                      Text(
                        "${house.distance} km",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // Best for you list
  Widget _buildBestList() {
    final best = controller.houses.where((h) => h.isRecommended).toList();

    return Column(
      children: best.map((house) {
        return GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.detail, arguments: house),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    house.imageUrl,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        house.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rp ${house.price} / Year",
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${house.bedroom} Bedroom • ${house.bathroom} Bathroom",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
