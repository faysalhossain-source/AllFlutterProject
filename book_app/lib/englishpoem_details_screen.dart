import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class EnglishpoemDetailsScreen extends StatefulWidget {
  Map EnglishPoem;
  EnglishpoemDetailsScreen(this.EnglishPoem);

  @override
  State<EnglishpoemDetailsScreen> createState() =>
      _EnglishpoemDetailsScreenState();
}

class _EnglishpoemDetailsScreenState extends State<EnglishpoemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color:Colors.white),
        ),
        title: Text(
          '📚 📚 📚 Poem Viewer',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        elevation: 1,
        actions: [
          SizedBox(width: 10),
          InkWell(
            onTap: () {
             
              SharePlus.instance.share(ShareParams(text: widget.EnglishPoem['lines']));
            },
            child: Icon(Icons.share, color: Colors.black),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              Clipboard.setData(
                ClipboardData(text: widget.EnglishPoem['lines']),
                );
               Fluttertoast.showToast(msg: 'copied to clipboard');
            },
            child: Icon(Icons.copy,color: Colors.black),
          ),
          SizedBox(width: 10,)
        ],
      ),
       body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              widget.EnglishPoem['title'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.EnglishPoem['lines'],
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
