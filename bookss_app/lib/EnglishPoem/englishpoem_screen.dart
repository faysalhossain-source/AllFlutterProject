import 'package:bookss_app/EnglishPoem/english_details_screen.dart';
import 'package:flutter/material.dart';

class EnglishpoemScreen extends StatefulWidget {
  const EnglishpoemScreen({super.key});

  @override
  State<EnglishpoemScreen> createState() => _EnglishpoemScreenState();
}

class _EnglishpoemScreenState extends State<EnglishpoemScreen> {
  List<Map> Epoems = [
    {
      'title': 'The Road Not Taken',
      'author': 'Robert Frost',
      'lines': '''Two roads diverged in a yellow wood,
And sorry I could not travel both
And be one traveler, long I stood
And took the one less traveled by,
And that has made all the difference.''',
    },
    {
      'title': 'If—',
      'author': 'Rudyard Kipling',
      'lines': '''If you can keep your head when all about you
Are losing theirs and blaming it on you,
Yours is the Earth and everything that’s in it,
And—which is more—you’ll be a Man, my son!''',
    },
    {
      'title': 'Daffodils',
      'author': 'William Wordsworth',
      'lines': '''I wandered lonely as a cloud
That floats on high o’er vales and hills,
When all at once I saw a crowd,
A host, of golden daffodils.''',
    },
    {
      'title': 'Ozymandias',
      'author': 'Percy Bysshe Shelley',
      'lines': '''I met a traveller from an antique land
Who said: Two vast and trunkless legs of stone
Stand in the desert...
“Look on my Works, ye Mighty, and despair!”''',
    },
    {
      'title': 'The Tyger',
      'author': 'William Blake',
      'lines': '''Tyger Tyger, burning bright,
In the forests of the night;
What immortal hand or eye,
Could frame thy fearful symmetry?''',
    },
    {
      'title': 'Stopping by Woods on a Snowy Evening',
      'author': 'Robert Frost',
      'lines': '''The woods are lovely, dark and deep,
But I have promises to keep,
And miles to go before I sleep.''',
    },
    {
      'title': 'A Dream Within a Dream',
      'author': 'Edgar Allan Poe',
      'lines': '''All that we see or seem
Is but a dream within a dream.''',
    },
    {
      'title': 'Hope is the Thing with Feathers',
      'author': 'Emily Dickinson',
      'lines': '''Hope is the thing with feathers
That perches in the soul,
And sings the tune without the words,
And never stops at all.''',
    },
    {
      'title': 'Sonnet 18',
      'author': 'William Shakespeare',
      'lines': '''Shall I compare thee to a summer’s day?
Thou art more lovely and more temperate:
So long as men can breathe or eyes can see,
So long lives this, and this gives life to thee.''',
    },
    {
      'title': 'Do Not Go Gentle into That Good Night',
      'author': 'Dylan Thomas',
      'lines': '''Do not go gentle into that good night,
Old age should burn and rave at close of day;
Rage, rage against the dying of the light.''',
    },
    {
      'title': 'Invictus',
      'author': 'William Ernest Henley',
      'lines': '''I am the master of my fate,
I am the captain of my soul.''',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: Epoems.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.amber,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          );
        },
        itemBuilder: (context, index) {
          Map Engpoem = Epoems[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnglishDetailsScreen(Engpoem),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Color(0xff7f8c8d),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              title: Text(
                Engpoem['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              subtitle: Text(
                Engpoem['author'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
