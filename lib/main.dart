import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp()); // one-line function
//StatefulWidget

class RandomEnglishWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return new RandomEnglishWordsState(); //return a state's object. Where is the state's class ?
  }
}
//State

class RandomEnglishWordsState  extends State<RandomEnglishWords>{
  final _words = <WordPair>[]; // Words displayed in ListView, 1 row contains 1 word
  final _checkedWords = new Set<WordPair>(); //set contains "on duplicate items"

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordPair = new WordPair.random();
     // Now we repleace this with a Scaffold widget contains a ListView
    return Scaffold(
      appBar: new AppBar(
        title: Text("List of English words"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushToSavedWordsScreen)
        ],
      ),
      body: new ListView.builder(itemBuilder: (context, index){
        // This is an anonymous function
        // index = 0, 1, 2 ,3...
        // This is function return each Row = "a Widget"
      if(index >= _words.length){
        _words.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_words[index], index); // Where is _buildRow ?
      }),
    );
  }

  _pushToSavedWordsScreen(){
    //To navigate, you must have a "route"
    final pageRoute = new MaterialPageRoute(builder: (context){
      // map function = Convert this list ot another list(maybe different object's type)
      //_checkWords(list of WordPair) => map =>
      // converted to a lazy list(Iterable) of ListTiles
      final listTiles = _checkedWords.map((wordPair){
        return new ListTile(
          title: new Text(wordPair.asUpperCase,
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),);
      });
      //now return a widget, we choose "Scaffold"
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Chekced words"),
        ),
        body: new ListView(children: listTiles.toList()), // Lazy list (Iterable) => List
      );
      });
    Navigator.of(context).push(pageRoute);
  }

  Widget _buildRow(WordPair wordPair, int index){
    //This widget is for each row
    final textColor = index % 2 == 0 ? Colors.red : Colors.black;
    final isChecked = _checkedWords.contains(wordPair);

    return new ListTile(
      // leading = left, trailing = right. It is correct ?
      leading: new Icon(
          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color : textColor
      ),
      title: new Text(
        wordPair.asUpperCase,
        style: new TextStyle(fontSize: 18.0, color: textColor),
      ),
      onTap: () {
        setState(() {
          //THis is an anonymous function
          if(isChecked){
            _checkedWords.remove(wordPair);
          } else{
            _checkedWords.add(wordPair);
          }
        });
      },
    );
  }
}


class MyApp extends StatelessWidget{
  //Stateless = immutable = cannot change object's properties
  //Every UI components are widgets
  @override
  Widget build(BuildContext context){
    final wordPair = new WordPair.random();

    // build func returns a "Widget"
    return new MaterialApp(
      title: "This is my first Flutter App",
      home: new RandomEnglishWords()
    );// Widget with "Material Design:

  }
}