import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/src/providers/casa_provider.dart';

import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

import '../models/casa_model.dart';

class CasaPage extends StatefulWidget {
  @override
  _CasaPageState createState() => _CasaPageState();
}

class _CasaPageState extends State<CasaPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final casaProvider = new CasaProvider();

  var _value = "1";
  CasaModel casa = new CasaModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    final CasaModel casaData = ModalRoute.of(context).settings.arguments;
    if (casaData != null) {
      casa = casaData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Rentas'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _tomarFoto),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
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

  Widget _crearTipo() {
    return Container(
      child: _casasDown(),
    );
  }

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
      onPressed: (_guardando) ? null : _submit,
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

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    if (casa.id == null) {
      casaProvider.crearCasa(casa);
    } else {
      casaProvider.editarCasa(casa);
    }

    // setState(() {
    // _guardando =true;
    // });
    mostrarSnackbar('Registro Guardado');
    Navigator.pop(context);
  }

  Widget _mostrarFoto() {
    if (casa.foto != null) {
      return Container();
    } else {
      return Image(
        image: AssetImage(foto?.path ??
            'assets/no-image.png'), //tiene path? si no mostrar asset
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async{
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async{
    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery);
    if (foto != null) {
      //limpieza

    }

    setState(() {});
  }
}
