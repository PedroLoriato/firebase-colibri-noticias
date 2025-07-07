import 'package:colibri_noticias/modelos/colaborador.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Noticia {
  final String? id;
  final Uri imagemUrl;
  final String fonte;
  final String titulo;
  final String resumo;
  final Uri linkUrl;
  final DateTime dataHoraPublicacao;
  final Colaborador colaborador; // Armazena o nome completo do colaborador
  final DateTime dataHoraAdicao;
  final String categoria;

  Noticia({
    this.id,
    required this.imagemUrl,
    required this.fonte,
    required this.titulo,
    required this.resumo,
    required this.linkUrl,
    required this.colaborador,
    required this.dataHoraPublicacao,
    required this.categoria,
    DateTime? dataHoraAdicao,
  }) : dataHoraAdicao = dataHoraAdicao ?? DateTime.now();

  /// Converte o objeto Noticia para um Map, pronto para ser salvo no Firestore.
  Map<String, dynamic> toMap() {
    return {
      'imagemUrl': imagemUrl,
      'fonte': fonte,
      'titulo': titulo,
      'resumo': resumo,
      'linkUrl': linkUrl,
      'colaborador': colaborador.toMap(),
      'categoria': categoria,
      // Converte DateTime para o tipo Timestamp, que é o correto para o Firestore
      'dataHoraPublicacao': Timestamp.fromDate(dataHoraPublicacao),
      'dataHoraAdicao': Timestamp.fromDate(dataHoraAdicao),
    };
  }

  /// Cria um objeto Noticia a partir de um Map vindo do Firestore.
  factory Noticia.fromMap(Map<String, dynamic> map, String documentId) {
    return Noticia(
      id: documentId,
      imagemUrl: map['imagemUrl'] ?? '',
      fonte: map['fonte'] ?? '',
      titulo: map['titulo'] ?? '',
      resumo: map['resumo'] ?? '',
      linkUrl: map['linkUrl'] ?? '',
      colaborador: map['colaborador'] ?? '',
      categoria: map['categoria'] ?? '',
      // Converte o Timestamp do Firestore de volta para DateTime
      dataHoraPublicacao: (map['dataHoraPublicacao'] as Timestamp).toDate(),
      dataHoraAdicao: (map['dataHoraAdicao'] as Timestamp).toDate(),
    );
  }
}
