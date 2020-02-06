import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/providers/casa_provider.dart';

import '../models/casa_model.dart';

class HomePage extends StatelessWidget {
  final casasProvider = new CasaProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'casa'),
      backgroundColor: Color.fromRGBO(222, 97, 97, 1.0),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: casasProvider.cargarCasas(),
      builder: (BuildContext context, AsyncSnapshot<List<CasaModel>> snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
