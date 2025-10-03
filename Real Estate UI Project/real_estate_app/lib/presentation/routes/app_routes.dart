import 'package:get/get.dart';
import '../pages/home/home_page.dart';
import '../pages/menu/menu_page.dart';
import '../pages/detail/detail_page.dart';

class AppRoutes {
  static const home = '/home';
  static const menu = '/menu';
  static const detail = '/detail';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: menu, page: () => MenuPage()),
    GetPage(name: detail, page: () => DetailPage()),
  ];
}
