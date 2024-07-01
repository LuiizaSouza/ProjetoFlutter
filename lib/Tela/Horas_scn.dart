import 'package:flutter/material.dart';
import 'package:project/Modelos/Horas_complementares.dart';
import 'package:project/Providers/Horas.dart';
import 'package:provider/provider.dart';



class HorasScreen extends StatefulWidget {
  @override
  _HorasScreenState createState() => _HorasScreenState();
}

class _HorasScreenState extends State<HorasScreen> {
  final TextEditingController _nomeCertificadoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _horasController = TextEditingController();
  int _grupoSelecionado = 1;

  void _addHora(BuildContext context) {
    final nomeCertificado = _nomeCertificadoController.text;
    final descricao = _descricaoController.text;
    final horas = int.tryParse(_horasController.text);
    if (nomeCertificado.isNotEmpty && descricao.isNotEmpty && horas != null) {
      try {
        Provider.of<HorasProvider>(context, listen: false).addHora(
          Hora(
            nomeCertificado: nomeCertificado,
            descricao: descricao,
            grupo: _grupoSelecionado,
            horas: horas,
          ),
        );
        _nomeCertificadoController.clear();
        _descricaoController.clear();
        _horasController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final horasProvider = Provider.of<HorasProvider>(context);
    final horasGrupo1 = horasProvider.getHorasPorGrupo(1);
    final horasGrupo2 = horasProvider.getHorasPorGrupo(2);
    final horasGrupo3 = horasProvider.getHorasPorGrupo(3);

    return Scaffold(
      appBar: AppBar(title: Text('Horas Complementares')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nomeCertificadoController,
              decoration: InputDecoration(labelText: 'Nome do Certificado'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _horasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Horas'),
            ),
          ),
          DropdownButton<int>(
            value: _grupoSelecionado,
            onChanged: (value) {
              setState(() {
                _grupoSelecionado = value!;
              });
            },
            items: [
              DropdownMenuItem(child: Text('Grupo 1 - ENSINO'), value: 1),
              DropdownMenuItem(child: Text('Grupo 2 - EXTENSÃO'), value: 2),
              DropdownMenuItem(child: Text('Grupo 3 - SOCIAL'), value: 3),
            ],
          ),
          ElevatedButton(
          onPressed: () => _addHora(context),
          style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 0, 3, 155), 
          ),
          child: Text('Adicionar Hora'),
            ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text('HORAS ACUMULADAS POR GRUPO:'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Grupo 1 - Ensino: $horasGrupo1 horas'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Grupo 2 - Extensão: $horasGrupo2 horas'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Grupo 3 - Social: $horasGrupo3 horas'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: horasProvider.horas.length,
              itemBuilder: (context, index) {
                final hora = horasProvider.horas[index];
                return ListTile(
                  title: Text(hora.nomeCertificado),
                  subtitle: Text('${hora.descricao} - Grupo ${hora.grupo} - ${hora.horas} horas'),
                );
              },
        ),
      ),
        ],
      ),
    );
  }
}
