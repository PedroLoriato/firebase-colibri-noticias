import 'package:flutter/foundation.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Noticia {
  String? id;
  final Uri imagem;
  final String fonte;
  final String titulo;
  final String resumo;
  final Uri link;
  final DateTime dataHoraPublicacao;
  final String colaborador;
  final DateTime dataHoraAdicao;
  final String categoria;

  Noticia({
    required this.imagem,
    required this.fonte,
    required this.titulo,
    required this.resumo,
    required this.link,
    required this.colaborador,
    required this.dataHoraPublicacao,
    required this.categoria,
    DateTime? dataHoraAdicao,
    this.id,
  }) : dataHoraAdicao = dataHoraAdicao ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      "imagem": imagem.toString(),
      "fonte": fonte,
      "titulo": titulo,
      "resumo": resumo,
      "link": link.toString(),
      "dataHoraPublicacao": dataHoraPublicacao.toIso8601String(),
      "colaborador": colaborador,
      "categoria": categoria,
    };
  }

  factory Noticia.fromMap(Map<String, dynamic> map) {
    final saoPaulo = tz.getLocation('America/Sao_Paulo');

    return Noticia(
      id: map['id'],
      imagem: Uri.parse(map['imagem']),
      fonte: map['fonte'],
      titulo: map['titulo'],
      resumo: map['resumo'],
      link: Uri.parse(map['link']),
      dataHoraPublicacao: tz.TZDateTime.from(DateTime.parse(map['dataHoraPublicacao']), saoPaulo),
      dataHoraAdicao: tz.TZDateTime.from(DateTime.parse(map['dataHoraAdicao']), saoPaulo),
      colaborador: map['colaborador'],
      categoria: map['categoria'],
    );
  }
}
