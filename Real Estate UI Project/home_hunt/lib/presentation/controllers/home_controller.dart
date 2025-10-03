import 'package:get/get.dart';
import '../../data/models/house_model.dart';

class HomeController extends GetxController {
  var selectedCategory = "House".obs;

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // Sample online houses
  var houses = <HouseModel>[
    HouseModel(
      title: "Dreamsville House",
      location: "Jakarta Selatan",
      imageUrl: "https://images.unsplash.com/photo-1568605114967-8130f3a36994",
      price: 250000000,
      bedroom: 5,
      bathroom: 2,
    ),
    HouseModel(
      title: "Orchard House",
      location: "Bangladesh Dhaka",
      imageUrl: "https://images.unsplash.com/photo-1572120360610-d971b9d7767c",
      price: 200000000,
      bedroom: 4,
      bathroom: 2,
    ),
  ].obs;
}
