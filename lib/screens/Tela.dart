import 'package:flutter/material.dart';
import 'package:projeto_gestao_notas_horas/screens/Horas_screen.dart';
import 'package:projeto_gestao_notas_horas/screens/Notas_screen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestão de Notas e Horas Complementares')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotasScreen()),
                );
              },
              child: Text('Gestão de Notas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HorasScreen()),
                );
              },
              child: Text('Gestão de Horas Complementares'),
            ),
          ],
        ),
      ),
    );
  }
}