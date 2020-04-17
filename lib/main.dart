import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Module Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestionWords = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18);

  Widget build(BuildContext context) {
    //Return 1 wordpair
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);

    //Return a list of wordpairs
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestion(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            }
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,  
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Favorite Words'),
            ),
            body: ListView(
              children: divided,
            ),    
          );
        }
      )
    );
  }

  Widget _buildSuggestion() {
    return SafeArea(
      child: ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          print(i);

          final index = i ~/ 2;
          if (index >= _suggestionWords.length) {
            _suggestionWords.addAll(generateWordPairs().take(10));
            //final someWords = generateWordPairs().take(10);
          }
          return _buildRow(_suggestionWords[index]);
        },
        itemCount: _suggestionWords.length,
      ),
      bottom: true,
      top: true,
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      leading: Icon(
        Icons.account_circle
      ),
      subtitle: Text(
        pair.asLowerCase
      ),
      isThreeLine: true,
      enabled: true,
      selected: false,
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onLongPress: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          }
          else {
            _saved.add(pair);
          }
        });
      },
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          }
          else {
            _saved.add(pair);
          }
        });
      },
    );
  }

}

class RandomWords extends StatefulWidget {
  RandomWordsState createState() => RandomWordsState();
}