import 'package:english_words/english_words.dart';
import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'StartUp Name generator!',
    home: StartUpNameGenerator(),
    theme: ThemeData(
      primaryColor: Colors.purple
    ),);
  }
}

class StartUpNameGenerator extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StartUpNameState();
  }
}

class StartUpNameState extends State<StartUpNameGenerator>{

  List<WordPair> _suggestions = List<WordPair>();
  Set<WordPair> _savedSuggestions = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StartUp Name Generator"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _onPushSaved)
        ],
      ),
      body: _nameInfiniteListGenerator(),
    );
  }

  Widget _nameInfiniteListGenerator(){
    return ListView.builder(
      itemBuilder: (BuildContext context, int i){
        if(i.isOdd){
          return Divider();
        }
        int index = i~/2;
        if(index >= _suggestions.length){
          _suggestions.addAll(prefix0.generateWordPairs().take(10));
        }
        return _returnRow(_suggestions[index]);
      },
    );
    
    //_returnRow();
  }

  Widget _returnRow(WordPair pair){
    bool _alreadySaved = _savedSuggestions.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18),),
      trailing: Icon(
        _alreadySaved? Icons.favorite : Icons.favorite_border,
        color:  _alreadySaved? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(_alreadySaved){
            _savedSuggestions.remove(pair);
          }
          else{
            _savedSuggestions.add(pair);
          }
        });
      },
    );
  }

  _onPushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          Iterable<ListTile> _savedTiles = _savedSuggestions.map((item){
            return ListTile(
              title: Text(item.asPascalCase, style: TextStyle(fontSize: 18),),
            );
          });

          List<Widget> divided = ListTile.divideTiles(
            tiles: _savedTiles,
            context: context
          ).toList();

          return Scaffold(
            appBar: AppBar(title: Text('saved Suggestions')),
            body: ListView(children: divided,),
          );
        }
      )
    );
  }
}