import 'dart:convert';
import 'package:colibri_noticias/modelos/noticia.dart';
import 'package:http/http.dart' as http;

class GerenciadorNoticia {
  static const String apiUrl = 'http://127.0.0.1:8000/api';
  static const String token = 'Token 87d00cee9a19159a18e57c9f75b0b76c4252120b';

  // Método para adicionar uma notícia
  static Future<void> adicionarNoticia(Noticia noticia) async {
    final response = await http.post(
      Uri.parse('$apiUrl/noticias/'),
      headers: {
        'Content-Type': 'application/json', 
        'Authorization': token
      },
      body: jsonEncode(noticia.toMap()),
    );

    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    if (response.statusCode == 400) {
      throw Exception('ERRO_REQUISICAO');
    }
    if (response.statusCode != 201) {
      throw Exception('ERRO_DESCONHECIDO');
    }
  }

  // Método para carregar as notícias
  static Future<List<Noticia>> carregarNoticias() async {
    final response = await http.get(
      Uri.parse('$apiUrl/noticias/?ordering=-dataHoraAdicao'),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Noticia.fromMap(item)).toList();
    }
    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    throw Exception('ERRO_DESCONHECIDO');
  }

  // Método para filtrar as notícias por categoria
  static Future<List<Noticia>> filtrarNoticiasPorCategoria(
    String categoria,
  ) async {
    final response = await http.get(
      Uri.parse('$apiUrl/noticias/?categoria=$categoria&ordering=-dataHoraAdicao'),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Noticia.fromMap(item)).toList();
    }

    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    throw Exception('ERRO_DESCONHECIDO');
  }

  // Método para contagem de notícias de um colaborador
  static Future<int> contarNoticiasPorColaborador(String colaborador) async {
    final response = await http.get(
      Uri.parse('$apiUrl/noticias/count/?colaborador=$colaborador'),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['count'];
    }
    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    throw Exception('ERRO_DESCONHECIDO');
  }

  // Método para editar uma notícia
  static Future<void> editarNoticia(Noticia noticia) async {
    final response = await http.put(
      Uri.parse('$apiUrl/noticias/${noticia.id}/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      },
      body: jsonEncode(noticia.toMap()),
    );

    if (response.statusCode == 200) {
      return;
    }
    if (response.statusCode == 400) {
      throw Exception('ERRO_REQUISICAO');
    }
    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    throw Exception('ERRO_DESCONHECIDO');
  }

  //Método para deletar uma notícia
  static Future<void> deletarNoticia(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/noticias/$id/'),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );

    if (response.statusCode == 204) {
      return;
    }
    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    throw Exception('ERRO_DESCONHECIDO');
  }
}
