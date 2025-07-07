// modelos/colaborador.dart

class Colaborador {
  final String? id; // UID do Firebase Auth, que é o ID do documento
  final String avatar;
  final String nome;
  final String sobrenome;
  final String cpf;
  final String email; // Essencial para o login com Firebase Auth

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

  // O toMap não precisa incluir o id, pois ele é o nome do documento
  Map<String, dynamic> toMap() {
    return {
      "avatar": avatar,
      "nome": nome,
      "sobrenome": sobrenome,
      "cpf": cpf,
      "email": email,
    };
  }

  // O fromMap agora recebe o ID do documento
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