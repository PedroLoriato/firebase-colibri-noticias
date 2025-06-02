import 'dart:convert';

class Colaborador {
  String imagem;
  String nome;
  String sobrenome;
  String cpf;
  String senha;

  Colaborador({
    required this.imagem,
    required this.nome,
    required this.sobrenome,
    required this.cpf,
    required this.senha,
  });

  String nomeCompleto() {
    return '$nome $sobrenome';
  }

  String primeiroNome() {
    return nome.split(' ')[0];
  }

  Map<String, dynamic> toMap() {
    return {
      "imagem": imagem,
      "nome": nome,
      "sobrenome": sobrenome,
      "cpf": cpf,
      "senha": senha,
    };
  }

  // Método para converter o objeto em uma string JSON
  String toJson() {
    return jsonEncode(toMap());
  }

  factory Colaborador.fromMap(Map<String, dynamic> map) {
    return Colaborador(
      imagem: map['imagem'],
      nome: map['nome'],
      sobrenome: map['sobrenome'],
      cpf: map['cpf'],
      senha: map['senha'],
    );
  }
}
