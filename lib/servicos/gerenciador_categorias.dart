import 'dart:convert';
import 'package:colibri_noticias/modelos/categoria.dart';
import 'package:http/http.dart' as http;

class GerenciadorCategoria {
  static const String apiUrl = 'http://127.0.0.1:8000/api';
  static const String token = 'Token 87d00cee9a19159a18e57c9f75b0b76c4252120b';

  // Método para adicionar uma categoria
  static Future<void> adicionarCategoria(Categoria categoria) async {
    final response = await http.post(
      Uri.parse('$apiUrl/categorias/'),
      headers: {
        'Content-Type': 'application/json', 
        'Authorization': token
      },
      body: jsonEncode(categoria.toMap()),
    );

    if (response.statusCode == 201) {
      throw Exception('SUCESSO');
    }
    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    throw Exception('ERRO_DESCONHECIDO');
  }

  // Método para carregar as categorias
  static Future<List<Categoria>> carregarCategorias() async {
    final response = await http.get(
      Uri.parse('$apiUrl/categorias/'),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Categoria.fromMap(item)).toList();
    }
    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    throw Exception('ERRO_DESCONHECIDO');
  }

  static Future<List<String>> carregarNomesCategorias() async {
    return carregarCategorias().then((categorias) {
      return categorias.map((categoria) => categoria.nome).toList();
    });
  }

  static Future<bool> temCategoria(String categoria) async {
    final response = await http.get(
      Uri.parse('$apiUrl/categorias/?search=$categoria'),
      headers: {
        'Content-Type': 'application/json', 
        'Authorization': token
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.isNotEmpty;
    }
    if (response.statusCode == 500) {
      throw Exception('ERRO_SERVIDOR');
    }
    throw Exception('ERRO_DESCONHECIDO');
  }
}
