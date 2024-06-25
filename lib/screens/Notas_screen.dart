import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/disciplina.dart';
import '../providers/disciplinas_provider.dart';

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

  void _updateNota(BuildContext context, String nome, int trimestre, String notaStr) {
    final nota = double.tryParse(notaStr);
    if (nota != null) {
      Provider.of<DisciplinasProvider>(context, listen: false).updateNota(nome, trimestre, nota);
    }
  }

  @override
  Widget build(BuildContext context) {
    final disciplinas = Provider.of<DisciplinasProvider>(context).disciplinas;

    return Scaffold(
      appBar: AppBar(title: Text('Gestão de Notas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome da Disciplina'),
            ),
          ),
          ElevatedButton(
            onPressed: () => _addDisciplina(context),
            child: Text('Adicionar Disciplina'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: disciplinas.length,
              itemBuilder: (context, index) {
                final disciplina = disciplinas[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Disciplina: ${disciplina.nome}'),
                        ...List.generate(3, (i) {
                          return Row(
                            children: [
                              Text('Trimestre ${i + 1}: '),
                              Expanded(
                                child: TextField(
                                  controller: _notaControllers[i],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Nota ${i + 1}',
                                  ),
                                  onSubmitted: (value) => _updateNota(context, disciplina.nome, i + 1, value),
                                ),
                              ),
                            ],
                          );
                        }),
                        Text('Média: ${disciplina.media.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}