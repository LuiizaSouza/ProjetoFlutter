class Disciplina {
  final String nome;
  final List<double> notas;
  double _media;

  Disciplina({required this.nome, required this.notas}) : _media = 0;

  double get media => _media;

  set media(double value) {
    _media = value;
  }
}





