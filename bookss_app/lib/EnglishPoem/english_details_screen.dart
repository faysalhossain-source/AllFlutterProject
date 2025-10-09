import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class EnglishDetailsScreen extends StatefulWidget {
  Map engpoem;
  EnglishDetailsScreen(this.engpoem);

  @override
  State<EnglishDetailsScreen> createState() => _EnglishDetailsScreenState();
}

class _EnglishDetailsScreenState extends State<EnglishDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3E3EFC), // Royal blue
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '📘 English Poem',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(text: widget.engpoem['lines']),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.engpoem['lines']));
              Fluttertoast.showToast(msg: 'copied successfully!!');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.engpoem['title'] ?? '',
                    style: TextStyle(
                      fontSize: screenWidth < 400 ? 20 : 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        widget.engpoem['lines'] ?? '',
                        style: TextStyle(
                          fontSize: screenWidth < 400 ? 16 : 18,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
