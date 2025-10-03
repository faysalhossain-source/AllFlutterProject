import 'package:get/get.dart';

import '../../data/models/house_model.dart';

class HomeController extends GetxController {
  var selectedCategory =
      "House".obs; //Category selection (House, Apartment, Hotel, Villa)

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  final houses = <HouseModel>[
    HouseModel(
      title: "Dreamsville House",
      location: "Jl. Sultan Iskandar Muda",
      imageUrl: "https://images.unsplash.com/photo-1568605114967-8130f3a36994",
      price: 2500000000,
      bedroom: 5,
      bathroom: 2,
      isNearby: true,
      distance: 1.8,
    ),
    HouseModel(
      title: "Ascot House",
      location: "Jl. Cisandak Timur",
      imageUrl: "https://images.unsplash.com/photo-1572120360610-d971b9d7767c",
      price: 2200000000,
      bedroom: 4,
      bathroom: 2,
      isNearby: true,
    ),
    HouseModel(
      title: "Orchid House",
      location: "Jl. Kebayoran Baru",
      imageUrl: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
      price: 2500000000,
      bedroom: 6,
      bathroom: 4,
      isRecommended: true,
    ),
    HouseModel(
      title: "The Hollies House",
      location: "Jl. Pondok Indah",
      imageUrl: "https://images.unsplash.com/photo-1599423300746-b62533397364",
      price: 2800000000,
      bedroom: 5,
      bathroom: 2,
      isRecommended: true,
    ),
  ].obs;
}
