import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class PoemDetailsScreen extends StatefulWidget {
  Map Poem;
  PoemDetailsScreen(this.Poem, {super.key});

  @override
  State<PoemDetailsScreen> createState() => _PoemDetailsScreenState();
}

class _PoemDetailsScreenState extends State<PoemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('📚 📚 📚 সম্পূর্ণ কবিতা পড়ুন🔹🔹🔹', style: TextStyle(color: Colors.black)),
        actions: [
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              SharePlus.instance.share(ShareParams(text: widget.Poem['lines']));
            },
            child: Icon(Icons.share, color: Colors.black),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              Clipboard.setData(
                ClipboardData(text: widget.Poem['lines']),
              );
              Fluttertoast.showToast(msg: 'copied to clipboard');
            },
            child: Icon(Icons.copy, color: Colors.black),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              widget.Poem['title'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.Poem['lines'],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
