import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
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

            Row(
              children: [
                _buildChip("House"),
                const SizedBox(width: 8),
                _buildChip("Apartment"),
                const SizedBox(width: 8),
                _buildChip("Villa"),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Near from you",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // House List
            Column(
              children: controller.houses.map((house) {
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
                    height: 200,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.black.withOpacity(0.5),
                        child: Text(
                          house.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Chip builder method
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
        showCheckmark: false,
        onSelected: (_) => controller.changeCategory(label),
      );
    });
  }
}
