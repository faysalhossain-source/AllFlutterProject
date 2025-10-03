import 'package:flutter/material.dart';

class Studentlistpage extends StatefulWidget {
  const Studentlistpage({super.key});

  @override
  State<Studentlistpage> createState() => _StudentlistpageState();
}

class _StudentlistpageState extends State<Studentlistpage> {
  List student = [
    //Without Generics
    'Faysal Hossain',
    'Ayesha Akter',
    'Tanvir Rahman',
    'Nusrat Jahan',
    'Rafiul Islam',
    'Mehedi Hasan',
    'Sadia Sultana',
    'Shuvo Ahmed',
    'Tanjina Haque',
    'Hasibul Kabir',
    'Mim Chowdhury',
    'Rakibul Hasan',
    'Farhana Islam',
    'Jannatul Ferdous',
    'Saif Mahmud',
    'Tawsif Alam',
    'Nayeem Khan',
    'Sumaiya Noor',
    'Rumana Akter',
    'Abrar Fahim',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        backgroundColor: Colors.blueGrey,
      ),
      extendBody: true,
      body: ListView.separated(
        itemCount: student.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
            height: 1,
            indent: 1,
            endIndent: 16,
            thickness: 1,
          );
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 0, 5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 30,
                    child: Text((index + 1).toString()),
                  ),
                  title: Text(
                    student[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
