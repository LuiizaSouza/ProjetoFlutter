import 'package:flutter/material.dart';
import 'package:project/Providers/Notas.dart';
import 'package:project/Providers/Horas.dart';
import 'package:project/Tela/Tela_%20inicial%20.dart';
import 'package:provider/provider.dart';

/*falta alterar algumas coisas ainda*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DisciplinasProvider()),
        ChangeNotifierProvider(create: (context) => HorasProvider()),
      ],
      child: MaterialApp(
        title: 'Gestão de Notas e Horas Complementares',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}



