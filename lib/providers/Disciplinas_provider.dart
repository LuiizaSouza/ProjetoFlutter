import 'package:flutter/material.dart';
import '../models/disciplina.dart';

class DisciplinasProvider with ChangeNotifier {
  List<Disciplina> _disciplinas = [];

  List<Disciplina> get disciplinas => _disciplinas;

  void addDisciplina(Disciplina disciplina) {
    _disciplinas.add(disciplina);
    notifyListeners();
  }

  void updateNota(String nome, int trimestre, double nota) {
    final disciplina = _disciplinas.firstWhere((d) => d.nome == nome);
    disciplina.notas[trimestre - 1] = nota;
    notifyListeners();
  }
}
