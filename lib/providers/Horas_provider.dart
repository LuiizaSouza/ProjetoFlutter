import 'package:flutter/material.dart';
import '../models/horas.dart';

class HorasProvider with ChangeNotifier {
  final Map<int, int> _limiteHoras = {1: 155, 2: 40, 3: 40};
  List<Hora> _horas = [];

  List<Hora> get horas => _horas;

  int getHorasPorGrupo(int grupo) {
    return _horas.where((h) => h.grupo == grupo).fold(0, (sum, h) => sum + h.horas);
  }

  void addHora(Hora hora) {
    if (getHorasPorGrupo(hora.grupo) + hora.horas <= _limiteHoras[hora.grupo]!) {
      _horas.add(hora);
      notifyListeners();
    } else {
      throw Exception('Limite de horas atingido para o grupo ${hora.grupo}');
    }
  }
}
