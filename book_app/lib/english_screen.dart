import 'package:book_app/englishpoem_details_screen.dart';
import 'package:flutter/material.dart';

class EnglishScreen extends StatefulWidget {
  const EnglishScreen({super.key});

  @override
  State<EnglishScreen> createState() => _EnglishScreenState();
}

class _EnglishScreenState extends State<EnglishScreen> {

  List <Map> poemsENLISH =[
  {
    'title':'The Road Not Taken',
    'author':'Robert Frost',
    'lines':'''
Two roads diverged in a yellow wood,
And sorry I could not travel both
And be one traveler, 
long I stood
And looked down one as far as I could
To where it bent in the undergrowth;
\n\nThen took the other, as just as fair,
\nAnd having perhaps the better claim,
Because it was grassy and wanted wear;
Though as for that the passing there
Had worn them really about the same,
\n\nAnd both that morning equally lay
In leaves no step had trodden black.
Oh, I kept the first for another day!
\nYet knowing how way leads on to way,
I doubted if I should ever come back.
\n\nI shall be telling this with a sigh
Somewhere ages and ages hence:
Two roads diverged in a wood, and I—\nI took the one less traveled by,
And that has made all the difference.''',
  },
  {
    'title':'Stopping by Woods on a Snowy Evening',
    'author':'Robert Frost',
    'lines':'''Whose woods these are I think I know.\nHis house is in the village though;
    He will not see me stopping here\nTo watch his woods fill up with snow.
    My little horse must think it queer\nTo stop without a farmhouse near
  Between the woods and frozen lake\nThe darkest evening of the year.
  \n\nHe gives his harness bells a shake
  To ask if there is some mistake.\nThe only other sound’s the sweep
  Of easy wind and downy flake.\n\nThe woods are lovely, dark and deep,\nBut I have promises to keep,
  \nAnd miles to go before I sleep,\nAnd miles to go before I sleep.''',
  },
  {
    'title':'I Wandered Lonely as a Cloud',
    'author':'William Wordsworth',
    'lines':'''I wandered lonely as a cloud
That floats on high o'er vales and hills,
When all at once I saw a crowd,
A host, of golden daffodils;
Beside the lake, beneath the trees,
Fluttering and dancing in the breeze.
\n\nContinuous as the stars that shine
And twinkle on the Milky Way,
They stretched in never-ending line
Along the margin of a bay:
Ten thousand saw I at a glance,
Tossing their heads in sprightly dance.
\n\nThe waves beside them danced; but they
Out-did the sparkling waves in glee:
A poet could
not but be'''
  },
  {
    'title':'Hope is the thing with feathers',
    'author':'Emily Dickinson',
    'lines':'''“Hope” is the thing with feathers -
That perches in the soul -
And sings the tune without the words -
And never stops - at all -
And sweetest - in the Gale - is heard -
And sore must be the storm -
That could abash the little Bird
That kept so many warm -
I’ve heard it in the chillest land -
And on the strangest Sea -
Yet - never - in Extremity,
It asked a crumb - of me.''',
  },
  {
    'title':'The Tyger',
    'author':'William Blake',
    'lines':'''Tyger Tyger, burning bright,
In the forests of the night;
What immortal hand or eye,
Could frame thy fearful symmetry?
In what distant deeps or skies.
Burnt the fire of thine eyes?
On what wings dare he aspire?
What the hand, dare seize the fire?
And what shoulder, & what art,
Could twist the sinews of thy heart?
And when thy heart began to beat,
What dread hand? & what dread feet?
What the hammer? what the chain?
In what furnace was thy brain?
What the anvil? what dread grasp,
Dare its deadly terrors clasp?
When the stars threw down their spears
And water'd heaven with their tears:
Did he smile his work to see?
Did he who made the Lamb make thee?
Tyger Tyger burning bright,
In the forests of the night:
What immortal hand or eye,
Dare frame thy fearful symmetry?''',
  },
  {
    'title':'Daffodils',
    'author':'William Wordsworth',
    'lines':'''I wandered lonely as a cloud
That floats on high o'er vales and hills,
When all at once I saw a crowd,
A host, of golden daffodils;
Beside the lake, beneath the trees,
Fluttering and dancing in the breeze.
Continuous as the stars that shine
And twinkle on the Milky Way,
They stretched in never-ending line
Along the margin of a bay:
Ten thousand saw I at a glance,
Tossing their heads in sprightly dance.
The waves beside them danced; but they
Out-did the sparkling waves in glee:
A poet could
not but be
In such a jocund company:
I gazed—and gazed—but little thought
What wealth the show to me had brought:
For oft, when on my couch I lie
In vacant or in pensive mood,
They flash upon that inward eye
Which is the bliss of solitude;
And then my heart with pleasure fills,
And dances with the daffodils.''',
  },
  {
    'title':'Annabel Lee',
    'author':'Edgar Allan Poe',
    'lines':'''It was many and many a year ago,
In a kingdom by the sea,
That a maiden there lived whom you may know
By the name of Annabel Lee;
And this maiden she lived with no other thought
Than to love and be loved by me.
\n\nI was a child and she was a child,
In this kingdom by the sea,
But we loved with a love that was more than love—
I and my Annabel Lee—
With a love that the wingèd seraphs of heaven
Coveted her and me.
And this was the reason that, long ago,
In this kingdom by the sea,
A wind blew out of a cloud, chilling
My beautiful Annabel Lee;
So that her highborn kinsmen came
And bore her away from me,
To shut her up in a sepulchre
In this kingdom by the sea.
The angels, not half so happy in heaven,
Went envying her and me—

Yes!—that was
the reason'''
},
{
    'title':'Ozymandias',
    'author':'Percy Bysshe Shelley',
    'lines':'''I met a traveller from an antique land 
    Who said: Two vast and trunkless legs of stone
    Stand in the desert. Near them, on the sand,
    Half sunk, a shattered visage lies, whose frown,
      
      And wrinkled lip, and sneer of cold command,
      Tell that its sculptor well those passions read
      Which yet survive, stamped on these lifeless things,
      The hand that mocked them, and the heart that fed;
      And on the pedestal, these words appear:
      My name is Ozymandias, King of Kings;
      Look on my Works, ye Mighty, and despair!
        Nothing beside remains. Round the decay
        Of that colossal Wreck, boundless and bare
        The lone and level sands stretch far away.''',
        },
        {
    'title':'She Walks in Beauty',
    'author':'Lord Byron',  
    'lines':'''She walks in beauty, like the night
Of cloudless climes and starry skies;
And all that’s best of dark and bright
Meet in her aspect and her eyes;
Thus mellowed to that tender light
Which heaven to gaudy day denies.
One shade the more, one ray the less,
Had half impaired the nameless grace
Which waves in every raven tress,
Or softly lightens o’er her face;
Where thoughts serenely sweet express
How pure, how dear their dwelling-place.
And on that cheek, and o’er that brow,
So soft, so calm, yet eloquent,
The smiles that win, the tints that glow,
But tell of days in goodness spent,
A mind at peace with all below,
A heart whose love is innocent!''',
        },
  {
    'title':'The Raven',
    'author':'Edgar Allan Poe',
    'lines':'''Once upon a midnight dreary, while I pondered, weak and weary,
Over many a quaint and curious volume of forgotten lore—
While I nodded, nearly napping, suddenly there came a tapping,
As of some one gently rapping, rapping at my chamber door.
“’Tis some visitor,” I muttered, “tapping at my chamber door—
Only this and nothing more.”
\n\nAh, distinctly I remember it was in the bleak December;
And each separate dying ember writhed upon the floor.
Eagerly I wished the morrow;—vainly I had sought to borrow
From my books surcease of sorrow—sorrow for the lost Lenore—
For the rare and radiant maiden whom the angels name Lenore—
Nameless here for evermore.
\n\nAnd the silken, sad, uncertain rustling of each purple curtain
Thrilled me—filled me with fantastic terrors never felt before;
So that now, to still the beating of my heart, I stood repeating
“’Tis some visitor entreating entrance at my chamber door—
Some late visitor entreating entrance at my chamber door;—
This it is and nothing more,”

\n\nPresently my soul grew stronger; hesitating then no longer,
“Sir,” said I, “or Madam, truly your forgiveness I implore;
But the fact is I was napping, and so gently you came rapping,
And so faintly you came tapping, tapping at my chamber door,
That I scarce was sure I heard you”—here I opened wide the door;—
Darkness there and nothing more.
\n\nDeep into that darkness peering, long I stood there wondering, fearing,
Doubting, dreaming dreams no mortal ever dared to dream before
But the silence was unbroken, and the darkness gave no token,
And the only word there spoken was the whispered word, “Lenore!”
This I whispered, and an echo murmured back the word, “Lenore!”—
Merely this and nothing more.
\n\nBack into the chamber turning, all my soul within me burning,
Soon again I heard a tapping somewhat louder than before.
“Surely,” said I, “surely that is something at my window lattice;
Let me see then, what thereat is, and this mystery explore—
Let my heart be still a moment and this mystery explore;—
’Tis the wind and nothing more!”''',

  },
  {
    'title':'Invictus',
    'author':'William Ernest Henley',
    'lines':'''Out of the night that covers me,
    Black as the pit from pole to pole,
    I thank whatever gods may be
    For my unconquerable soul.
    In the fell clutch of circumstance
    I have not winced nor cried aloud.
    Under the bludgeonings of chance
    My head is bloody, but unbowed.
    Beyond this place of wrath and tears
    Looms but the Horror of the shade,
    And yet the menace of the years
    Finds and shall find me unafraid.
    It matters not how strait the gate,
    How charged with punishments the scroll,
    I am the master of my fate:
    I am the captain of my soul.''',
    },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: poemsENLISH.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 15,
            endIndent: 15,

          );
        },
        itemBuilder: (context,index){
          Map EnglishPoem = poemsENLISH[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder:(context)=>EnglishpoemDetailsScreen(EnglishPoem))
                );
            },
          leading:CircleAvatar(
            backgroundColor: Colors.brown,
            child: Text((index+1).toString(),style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic),),
          ) ,
          title: Text(EnglishPoem['title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),),
          subtitle: Text('Writer:${EnglishPoem['author']}',style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic),),
          );
        },
        ),
    );
  }
}