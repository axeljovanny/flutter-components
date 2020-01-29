import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              radius: 23.0,
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQryAHjQUGxQOCiqsnjZTDeSNBjBZHIkr12PSo9UNKOkD1EYLVg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('AJ'),
              backgroundColor: Colors.cyan,
              
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/loading-42.gif'),
          fadeInDuration: Duration(milliseconds: 200),
          image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSkalAwUHK3pS4a63DhhBBXkLeKsFvHVjLDOyOzmtVjdqYuVs4u'),
        ),
      ),
    );
  }
}