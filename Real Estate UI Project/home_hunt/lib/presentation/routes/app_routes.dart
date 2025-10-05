import 'package:get/get.dart';
import 'package:home_hunt/presentation/pages/login_page.dart';
import '../pages/home_page.dart';
import '../pages/detail_page.dart';
import '../pages/manu_page.dart';

class AppRoutes {
  static const home = '/home';
  static const detail = '/detail';
  static const menu = '/menu';
  static const login = '/login';

  static final routes = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: detail, page: () => DetailPage()),
    GetPage(name: menu, page: () => ManuPage()),
    GetPage(name: login, page: () => LoginPage()),
  ];
}
