import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri_noticias/modelos/noticia.dart';

class GerenciadorNoticia {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _colecaoNoticias = _db.collection('noticias');

  static Future<void> adicionarNoticia(Noticia noticia) async {
    try {
      await _colecaoNoticias.add(noticia.toMap());
    } catch (e) {
      throw Exception('ERRO_AO_ADICIONAR_NOTICIA');
    }
  }

  static Future<List<Noticia>> _converterSnapshotParaLista(
      QuerySnapshot snapshot) {
    final futureNoticias = snapshot.docs.map((doc) {
      return Noticia.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    return Future.wait(futureNoticias);
  }

  static Future<List<Noticia>> carregarNoticias() async {
    try {
      final snapshot = await _colecaoNoticias
          .orderBy('dataHoraPublicacao', descending: true)
          .get();

      return _converterSnapshotParaLista(snapshot);
    } catch (e) {
      throw Exception('ERRO_AO_CARREGAR_NOTICIAS');
    }
  }

  static Future<List<Noticia>> filtrarNoticiasPorCategoria(
      String categoriaNome) async {
    try {
      final categoriaQuery = await _db
          .collection('categorias')
          .where('nome', isEqualTo: categoriaNome)
          .limit(1)
          .get();

      if (categoriaQuery.docs.isEmpty) {
        return [];
      }
      final categoriaRef = categoriaQuery.docs.first.reference;

      final snapshot = await _colecaoNoticias
          .where('categoria', isEqualTo: categoriaRef)
          .orderBy('dataHoraAdicao', descending: true)
          .get();

      return _converterSnapshotParaLista(snapshot);
    } catch (e) {
      throw Exception('ERRO_AO_FILTRAR_NOTICIAS');
    }
  }

  static Future<int> contarNoticiasPorColaborador(String colaboradorId) async {
    try {
      final colaboradorRef = _db.collection('colaboradores').doc(colaboradorId);

      final aggregateQuery = _colecaoNoticias
          .where('colaborador', isEqualTo: colaboradorRef)
          .count();

      final snapshot = await aggregateQuery.get();
      return snapshot.count ?? 0;
    } catch (e) {
      throw Exception('ERRO_AO_CONTAR_NOTICIAS');
    }
  }

  static Future<void> editarNoticia(Noticia noticia) async {
    if (noticia.id == null || noticia.id!.isEmpty) {
      throw Exception('ID da notícia inválido para edição.');
    }
    try {
      await _colecaoNoticias.doc(noticia.id).update(noticia.toMap());
    } catch (e) {
      throw Exception('ERRO_AO_EDITAR_NOTICIA');
    }
  }

  static Future<void> deletarNoticia(String id) async {
    try {
      await _colecaoNoticias.doc(id).delete();
    } catch (e) {
      throw Exception('ERRO_AO_DELETAR_NOTICIA');
    }
  }
}