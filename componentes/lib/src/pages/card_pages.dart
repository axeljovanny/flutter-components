import 'package:flutter/material.dart';

class CardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[_cartTipo1(), SizedBox(height: 30), _cartTipo2(),
        SizedBox(height: 30),_cartTipo1(), SizedBox(height: 30), _cartTipo2(),
        SizedBox(height: 30),_cartTipo1(), SizedBox(height: 30), _cartTipo2(),
        SizedBox(height: 30),_cartTipo1(), SizedBox(height: 30), _cartTipo2(),],
      ),
    );
  }

  Widget _cartTipo1() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue),
            title: Text('Puto el que lo lea'),
            subtitle: Text(
                'No es cierto, que tengas un excelente día, cuidate mucho, bye'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }

  _cartTipo2() {
    final card = Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRNVSESHsjgbW1KFG_7wr_7fpxGX0KR9nP_uuIEt-YlCydsOaxR'),
            placeholder: AssetImage('assets/loading-42.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          Container(
            child: Text('A perro'),
            padding: EdgeInsets.all(10.0),
          )
        ],
      ),
    );
    return Container(
      child: ClipRRect(
        child: card,
        borderRadius: BorderRadius.circular(30.0),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )]),
    );
  }
}
