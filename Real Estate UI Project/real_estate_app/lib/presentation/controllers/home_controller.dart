import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedCategory = 'House'.obs;

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}
