import 'package:flutter/material.dart';
import 'package:project/Modelos/Disciplina.dart';
import 'package:project/Providers/Notas.dart';
import 'package:provider/provider.dart';




class NotasScreen extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final List<TextEditingController> _notaControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  void _addDisciplina(BuildContext context) {
    final nome = _nomeController.text;
    if (nome.isNotEmpty) {
      Provider.of<DisciplinasProvider>(context, listen: false).addDisciplina(
        Disciplina(nome: nome, notas: [0, 0, 0]),
      );
      _nomeController.clear();
  }
  }

  void _updateNota(BuildContext context, String nome) {
    for (int i = 0; i < 3; i++) {
      final notaStr = _notaControllers[i].text;
      final nota = double.tryParse(notaStr);
      if (nota != null) {
        Provider.of<DisciplinasProvider>(context, listen: false).updateNota(nome, i + 1, nota);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final disciplinas = Provider.of<DisciplinasProvider>(context).disciplinas;

    return Scaffold(
      appBar: AppBar(title: Text('Notas')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome da Disciplina'),
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _addDisciplina(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  'Adicionar Disciplina',
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: disciplinas.length,
                itemBuilder: (context, index) {
                  final disciplina = disciplinas[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Disciplina: ${disciplina.nome}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          ...List.generate(3, (i) {
                            return Row(
                              children: [
                                Text(
                                  'Trimestre ${i + 1}: ',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _notaControllers[i],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Nota ${i + 1}',
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                ),
                              ),
                              ],
                            );
                          }),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _updateNota(context, disciplina.nome);
                                Provider.of<DisciplinasProvider>(context, listen: false)
                                    .calcularMedia(disciplina.nome);
                            },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                            ),
                              child: Text(
                                'Calcular Média',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                              ),
                          ),
                         ),
                       ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Média: ${disciplina.media.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                      ),
                      ],
                   ),
                 ),
                  );
                },
             ),
        ],
       ),
        ),
    ),
    );
  }
}
