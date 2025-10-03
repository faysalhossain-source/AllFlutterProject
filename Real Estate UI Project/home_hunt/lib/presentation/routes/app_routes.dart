import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../pages/detail_page.dart';
import '../pages/manu_page.dart';

class AppRoutes {
  static const home = '/home';
  static const detail = '/detail';
  static const menu = '/menu';

  static final routes = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: detail, page: () => DetailPage()),
    GetPage(name: menu, page: () => ManuPage()),
  ];
}
