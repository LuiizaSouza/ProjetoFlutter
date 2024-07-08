import 'package:flutter/material.dart';
import 'package:project/Tela/Disciplina_scn.dart';
import 'package:project/Tela/Horas_scn.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gestão de Notas e Horas Complementares',
          style: TextStyle(
            fontSize: 40, 
            fontWeight: FontWeight.bold, 
            color: const Color.fromARGB(255, 0, 0, 0), 
            fontFamily: 'OpenSans', 
          ),
        ),
        centerTitle: true, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NotasScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Notas',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'OpenSans', 
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), 
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HorasScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 0, 41, 224),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Horas Complementares',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'OpenSans', 
                  ),
            ),
           ),
            ),
      ],
        ),
  ),
    );
  }
}
