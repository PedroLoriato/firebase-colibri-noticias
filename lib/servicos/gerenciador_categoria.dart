import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri_noticias/modelos/categoria.dart';

class GerenciadorCategoria {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _colecaoCategorias = _db.collection('categorias');

  static Future<Categoria> adicionarCategoria(Categoria categoria) async {
    try {
      final DocumentReference categoriaRef = await _colecaoCategorias.add(categoria.toMap());
      return (Categoria.fromMap(categoriaRef as Map<String, dynamic>, categoriaRef.id));
    } catch (e) {
      throw Exception('ERRO_AO_ADICIONAR');
    }
  }

  static Future<List<Categoria>> carregarCategorias() async { 
    try {
      final snapshot = await _colecaoCategorias.get();

      return snapshot.docs.map((doc) {
        return Categoria.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('ERRO_AO_CARREGAR');
    }
  }

  static Future<List<String>> carregarNomesCategorias() async {
    final categorias = await carregarCategorias();
    return categorias.map((categoria) => categoria.nome).toList();
  }
  static Future<Categoria?> temCategoria(String nomeCategoria) async {
    final snapshot = await _colecaoCategorias
        .where('nome', isEqualTo: nomeCategoria)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty ? Categoria.fromMap(snapshot.docs.first.data() as Map<String, dynamic>, snapshot.docs.first.id) : null;
  }
  
  static Future<Categoria> carregarCategoriaPorReferencia(
      DocumentReference categoriaRef) async {
    try {
      final docSnapshot = await categoriaRef.get();
      if (docSnapshot.exists) {
        return Categoria.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      } else {
        throw Exception(
            'Categoria referenciada com id ${categoriaRef.id} não foi encontrada.');
      }
    } catch (e) {
      rethrow;
    }
  }
}