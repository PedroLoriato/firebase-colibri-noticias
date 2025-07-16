class Colaborador {
  final String? id; 
  final String avatar;
  final String nome;
  final String sobrenome;
  final String cpf;
  final String email; 

  Colaborador({
    this.id,
    required this.avatar,
    required this.nome,
    required this.sobrenome,
    required this.cpf,
    required this.email,
  });

  String nomeCompleto() => '$nome $sobrenome';
  String primeiroNome() => nome.split(' ')[0];

  Map<String, dynamic> toMap() {
    return {
      "avatar": avatar,
      "nome": nome,
      "sobrenome": sobrenome,
      "cpf": cpf,
      "email": email,
    };
  }

  factory Colaborador.fromMap(Map<String, dynamic> map, String documentId) {
    return Colaborador(
      id: documentId,
      avatar: map['avatar'] ?? '',
      nome: map['nome'] ?? '',
      sobrenome: map['sobrenome'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '', 
    );
  }
}