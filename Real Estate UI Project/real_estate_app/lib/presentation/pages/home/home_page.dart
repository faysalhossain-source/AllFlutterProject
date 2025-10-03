import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'house_card.dart';
import '../../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Controller inject
  final HomeController controller = Get.put(HomeController());

  // House list data
  final List<Map<String, String>> houseList = [
    {
      "name": "Dreamsville House",
      "image": "https://images.unsplash.com/photo-1568605114967-8130f3a36994",
      "location": "Jakarta, Indonesia",
      "price": "\$250,000",
    },
    {
      "name": "Ascot House",
      "image": "https://images.unsplash.com/photo-1572120360610-d971b9d7767c",
      "location": "Jakarta, Indonesia",
      "price": "\$300,000",
    },
    {
      "name": "Orchard House",
      "image": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
      "location": "Jakarta, Indonesia",
      "price": "\$280,000",
    },
    {
      "name": "The Hollies House",
      "image": "https://images.unsplash.com/photo-1599423300746-b62533397364",
      "location": "Jakarta, Indonesia",
      "price": "\$320,000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Location",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Row(
              children: const [
                Text(
                  "Jakarta",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
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

      // Body section
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search bar
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

          // Category Filter
          Row(
            children: [
              _buildCategoryChip("House"),
              const SizedBox(width: 8),
              _buildCategoryChip("Apartment"),
              const SizedBox(width: 8),
              _buildCategoryChip("Villa"),
            ],
          ),
          const SizedBox(height: 20),

          // House Section Title
          const Text(
            "Near from you",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Horizontal scrollable house cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: houseList
                  .map(
                    (house) =>
                        houseCard(house["name"]!, house["image"]!, house),
                  )
                  .toList(),
            ),
          ),
        ],
      ),

      // Drawer section
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        child: ListView(
          children: const [
            DrawerHeader(
              child: Text("Menu", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Corrected Obx usage with Get.find()
  Widget _buildCategoryChip(String category) {
    final controller = Get.find<HomeController>(); // Safe scoped access
    return Obx(
      () => ChoiceChip(
        label: Text(
          category,
          style: TextStyle(
            color: controller.selectedCategory.value == category
                ? Colors.white
                : Colors.black,
          ),
        ),
        selected: controller.selectedCategory.value == category,
        onSelected: (_) => controller.changeCategory(category),
        selectedColor: Colors.blueAccent,
        backgroundColor: Colors.grey[200],
        showCheckmark: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }
}
