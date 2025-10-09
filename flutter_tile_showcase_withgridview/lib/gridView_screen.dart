import 'package:flutter/material.dart';

class GridviewScreen extends StatefulWidget {
  const GridviewScreen({super.key});

  @override
  State<GridviewScreen> createState() => _GridviewScreenState();
}

class _GridviewScreenState extends State<GridviewScreen> {
  List<String> Images = [
    'assets/images/Appbar.jpg',
    'assets/images/one.webp',
    'assets/images/two.webp',
    'assets/images/OIP3.webp',
    'assets/images/OIP4.webp',
    'assets/images/OIP5.webp',
    'assets/images/OIP6.webp',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/Appbar.jpg',
              fit: BoxFit.cover, // image take whole Appbar space
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 4,
              title: Row(
                children: [
                  const Icon(Icons.grid_view, color: Colors.white),
                  const SizedBox(width: 10),
                  const Text(
                    '📘 GridView Practice',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // image-এর উপর text দেখা যাবে
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2 / 1,
        ),
        itemCount: Images.length,
        itemBuilder: (context, Index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(Images[Index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
