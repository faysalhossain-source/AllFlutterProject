import 'package:flutter/cupertino.dart';
import 'package:food_app/consts/all_colors.dart';
import 'package:food_app/consts/all_size.dart';

class AllStyle {
  static final titleTextStyle = TextStyle(
    fontSize: AllSize.large,
    color: AllColors.lightGrayColors,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
  );
  static final subtitleTextStyle = TextStyle(
    fontSize: AllSize.medium,
    color: AllColors.secondaryColors,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
  );
}
