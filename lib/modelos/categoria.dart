class Categoria {
  final String nome;

  Categoria({required this.nome});

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      nome: map['nome'],
    );
  }
}
