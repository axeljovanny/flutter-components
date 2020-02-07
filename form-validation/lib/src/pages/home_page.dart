import 'package:flutter/material.dart';
//import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/providers/casa_provider.dart';

import '../models/casa_model.dart';

class HomePage extends StatelessWidget {
  final casasProvider = new CasaProvider();

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

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
          // Listado de Casas/Cuartos
          final casas = snapshot.data;
          return ListView.builder(
            itemCount: casas.length,
            itemBuilder: (context, i) => _crearItem(context, casas[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, CasaModel casa) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.redAccent,
      ),
      onDismissed: (direction) {
        // Borrar producto
        casasProvider.borrarCasa(casa.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (casa.foto == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(casa.foto)),
            ListTile(
              title: Text('${casa.colonia} - ${casa.renta} /mensuales'),
              subtitle: Row(
                children: <Widget>[
                  Text('Nª Cuartos: ${casa.cuartos.toString()}   '),
                  Text('Nª Baños: ${casa.baos.toString()}  ')
                ],
              ),
              onTap: () =>
                  Navigator.pushNamed(context, 'casa', arguments: casa),
            ),
          ],
        ),
      ),
    );
  }
}
