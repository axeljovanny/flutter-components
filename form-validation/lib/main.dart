import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/casa_page.dart';

import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/registro_page.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     //final _prefs = PreferenciasUsuario();
     //print(_prefs.token); //mostrar token


    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'casa': (BuildContext context) => CasaPage(),
          'registro': (BuildContext context) => RegistroPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
