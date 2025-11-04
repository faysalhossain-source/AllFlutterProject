import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/consts/all_colors.dart';
import 'package:food_app/consts/all_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    'All',
    'Combos',
    'Sliders',
    'Classic',
    'Combos',
    'Sliders',
    'Classic',
  ];
  int sellectCategory = 0;
  List<Map> foodlist = [
    {
      'image': 'assets/images/png/bargur1.png',
      'title': 'Cheeseburger',
      'description': 'Wendys Burger',
      'rating': 4.0,
    },
    {
      'image': 'assets/images/png/bargur2.png',
      'title': 'Cheeseburger',
      'description': 'Veggie Burger',
      'rating': 5.0,
    },
    {
      'image': 'assets/images/png/bargur3.png',
      'title': 'Cheeseburger',
      'description': 'Chicken Burger',
      'rating': 6.0,
    },
    {
      'image': 'assets/images/png/bargur4.png',
      'title': 'Cheeseburger',
      'description': 'Fried Chicken Burger',
      'rating': 10.0,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 30.0),
            SizedBox(
              height: 100.0,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/png/logo.png'),
                        Text(
                          'Order your favourite food!',
                          style: AllStyle.titleTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset('assets/images/png/profile.png'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: AllColors.whiteColors,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15.0),
                          hintText: 'Search',
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: AllColors.primaryColors,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/images/svg/filter_icons.svg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return sellectCategory == index
                      ? selectCategoriesVeiw(categories[index])
                      : unselectCategoriesVeiw(categories[index], index);
                },
              ),
            ),
            SizedBox(height: 15.0),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: foodlist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                  childAspectRatio: 4 / 6,
                ),
                itemBuilder: (contex, index) {
                  return foodViewItem(foodlist[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  foodViewItem(Map food) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(food['image']),
            ),
            Text(
              food['title'],
              style: AllStyle.titleTextStyle.copyWith(
                fontSize: 20.0,
                color: AllColors.secondaryColors,
              ),
            ),
            Text(
              food['description'],
              style: AllStyle.subtitleTextStyle.copyWith(
                // fontSize: 20.0,
                color: AllColors.lightGrayColors,
              ),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(height: 10),
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 10),
                    Text(
                      food['rating'].toString(),
                      style: AllStyle.subtitleTextStyle,
                    ),
                  ],
                ),
                Icon(Icons.favorite_outline),
              ],
            ),
          ],
        ),
      ),
    );
  }

  unselectCategoriesVeiw(String category, index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            sellectCategory = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: AllColors.categoryColors,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: 12.0,
              left: 12.0,
            ),
            child: Center(
              child: Text(category, style: AllStyle.titleTextStyle),
            ),
          ),
        ),
      ),
    );
  }

  selectCategoriesVeiw(String category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AllColors.lightGrayColors,
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
          color: AllColors.primaryColors,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            right: 12.0,
            left: 12.0,
          ),
          child: Center(
            child: Text(
              category,
              style: AllStyle.titleTextStyle.copyWith(
                color: AllColors.whiteColors,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
