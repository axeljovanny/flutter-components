import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {

  final opciones = ['uno','dos','tres','cuatro','cinco'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes Temp'),
      ),
      body: ListView(
        children: _crearItemsCorta()
      ),
    );
  }


  // List<Widget> _crearItems(){

  //   List<Widget> lista = new List<Widget>();
  //   for (var opt in opciones) {
  //     final tempWidget = ListTile(
  //       title: Text(opt),
  //     );
  //   lista.add(tempWidget);
      
  //   }
  //   return lista;
  // }

  List<Widget> _crearItemsCorta(){
    return opciones.map((item){
      return ListTile(
        title: Text(item),
        subtitle: Text('Cualquiercosa'),
        leading: Icon(Icons.account_balance_wallet),
        trailing: Icon(Icons.arrow_right)
      );
    }).toList();
    
  
  }
}
