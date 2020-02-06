import 'package:flutter/material.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class CasaPage extends StatefulWidget {
  @override
  _CasaPageState createState() => _CasaPageState();
}

class _CasaPageState extends State<CasaPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rentas'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _crearTipo()
                  _crearColonia(),
                  _crearCuartos(),
                  _crearBanos(),
                  _crearMetros(),
                  _crearDescipcion(),
                  _crearRenta(),
                  _crearDisponible(),
                  _crearBoton()
                ],
              )),
        ),
      ),
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo Numeros';
        }
      },
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Casas'),
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.deepPurple,
        label: Text('Gurdar'),
        icon: Icon(Icons.save),
        textColor: Colors.white,
        onPressed: _submit,
    );
  }

  void _submit() {
    if(!formKey.currentState.validate()) return ;


  }
}
