import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/src/providers/casa_provider.dart';

import 'package:formvalidation/src/utils/utils.dart' as utils;

import '../models/casa_model.dart';

class CasaPage extends StatefulWidget {
  @override
  _CasaPageState createState() => _CasaPageState();
}

class _CasaPageState extends State<CasaPage> {
  final formKey = GlobalKey<FormState>();
  final casaProvider = new CasaProvider();

  var _value = "1";
  CasaModel casa = new CasaModel();

  DropdownButton _casasDown() => DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text(
              "Casa",
            ),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(
              "Cuarto",
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
      );

  @override
  Widget build(BuildContext context) {
    final CasaModel casaData = ModalRoute.of(context).settings.arguments;
    if (casaData != null) {
      casa = casaData;
    }
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
                  _crearTipo(),
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

  Widget _crearRenta() {
    return TextFormField(
      initialValue: casa.renta.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => casa.renta = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo Numeros';
        }
      },
    );
  }

  Widget _crearColonia() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Colonia'),
      initialValue: casa.colonia,
      onSaved: (value) => casa.colonia = value,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      label: Text('Gurdar'),
      icon: Icon(Icons.save),
      textColor: Colors.white,
      onPressed: _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    print(casa.tipo);
    print(casa.colonia);
    print(casa.cuartos);
    print(casa.baos);
    print(casa.metros);
    print(casa.descripcion);
    print(casa.renta);
    print(casa.disponible);

    if (casa.id == null) {
      casaProvider.crearCasa(casa);
    } else {
      casaProvider.editarCasa(casa);
    }
  }

  Widget _crearTipo() {
    return Container(
      child: _casasDown(),
    );
  }

  Widget _crearCuartos() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Nº de Cuartos'),
      initialValue: casa.cuartos.toString(),
      onSaved: (value) => casa.cuartos = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo Numeros';
        }
      },
    );
  }

  Widget _crearBanos() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Nº de Baños'),
      initialValue: casa.baos.toString(),
      onSaved: (value) => casa.baos = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo Numeros';
        }
      },
    );
  }

  Widget _crearMetros() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Metros cuadrados'),
      initialValue: casa.metros.toString(),
      onSaved: (value) => casa.metros = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo Numeros';
        }
      },
    );
  }

  Widget _crearDescipcion() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Descripción'),
      initialValue: casa.descripcion,
      onSaved: (value) => casa.descripcion = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
        value: casa.disponible,
        title: Text('Disponible'),
        activeColor: Colors.deepPurple,
        onChanged: (value) => setState(() {
              casa.disponible = value;
            }));
  }
}
