class Categoria {
  final String? id;
  final String nome;

  Categoria({this.id, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      "nome": nome
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map, String documentId) {
    return Categoria(
      id: documentId,
      nome: map['nome'],
    );
  }
}
