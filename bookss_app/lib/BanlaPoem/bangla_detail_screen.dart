import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class BanglaDetailScreen extends StatefulWidget {
  Map bpoem;
  BanglaDetailScreen(this.bpoem);

  //BanglaDetailScreen(Map bpoem);

  @override
  State<BanglaDetailScreen> createState() => _BanglaDetailScreenState();
}

class _BanglaDetailScreenState extends State<BanglaDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E3EFC),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '📖 কবিতা',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(text: widget.bpoem['lines']),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.bpoem['lines']));
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.bpoem['title'] ?? '',
                    style: TextStyle(
                      fontSize: constraints.maxWidth < 400 ? 20 : 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.bpoem['lines'] ?? '',
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 400 ? 16 : 18,
                          height: 1.5,
                        ),
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
