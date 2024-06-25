class Disciplina {
  final String nome;
  List<double> notas;

  Disciplina({required this.nome, required this.notas});

  double get media => notas.isNotEmpty
      ? notas.reduce((a, b) => a + b) / notas.length
      : 0.0;
}
