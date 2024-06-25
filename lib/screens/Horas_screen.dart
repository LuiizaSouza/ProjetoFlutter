import 'package:flutter/material.dart';


class HorasScreen extends StatefulWidget {
  @override
  _HorasPageState createState() => _HorasPageState();
}

class _HorasPageState extends State<HorasScreen> {
  final List<Map<String, dynamic>> _horas = [];
  final TextEditingController _certificadoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _horasController = TextEditingController();
  int _grupoSelecionado = 1;

  final Map<int, int> _limites = {
    1: 155,
    2: 40,
    3: 40,
  };

  final Map<int, int> _totais = {
    1: 0,
    2: 0,
    3: 0,
  };

  void _addHoras() {
    final int horas = int.tryParse(_horasController.text) ?? 0;
    if (_totais[_grupoSelecionado]! + horas > _limites[_grupoSelecionado]!) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Limite de horas excedido para o Grupo $_grupoSelecionado!'),
        ),
      );
    } else {
      setState(() {
        _totais[_grupoSelecionado] = _totais[_grupoSelecionado]! + horas;
        _horas.add({
          'certificado': _certificadoController.text,
          'descricao': _descricaoController.text,
          'grupo': _grupoSelecionado,
          'horas': horas,
        });
        _certificadoController.clear();
        _descricaoController.clear();
        _horasController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Horas Complementares'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _certificadoController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Certificado',
                  ),
                ),
                TextField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                  ),
                ),
                TextField(
                  controller: _horasController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Horas',
                  ),
                ),
                DropdownButton<int>(
                  value: _grupoSelecionado,
                  items: [
                    DropdownMenuItem(child: Text('Grupo 1 - Ensino'), value: 1),
                    DropdownMenuItem(child: Text('Grupo 2 - Extensão'), value: 2),
                    DropdownMenuItem(child: Text('Grupo 3 - Social'), value: 3),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _grupoSelecionado = value!;
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Adicionar'),
                  onPressed: _addHoras,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _horas.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_horas[index]['certificado']),
                    subtitle: Text(_horas[index]['descricao']),
                    trailing: Text(
                      'Grupo ${_horas[index]['grupo']}: ${_horas[index]['horas']} horas',
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Total de horas por Grupo:'),
                Text('Grupo 1 - Ensino: ${_totais[1]} horas'),
                Text('Grupo 2 - Extensão: ${_totais[2]} horas'),
                Text('Grupo 3 - Social: ${_totais[3]} horas'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

