import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri_noticias/modelos/noticia.dart';

class GerenciadorNoticia {
  // Instância do Firestore e referência para a coleção 'noticias'
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _colecaoNoticias = _db.collection('noticias');

  /// Adiciona uma nova notícia ao Firestore.
  static Future<void> adicionarNoticia(Noticia noticia) async {
    try {
      await _colecaoNoticias.add(noticia.toMap());
    } catch (e) {
      print('Erro ao adicionar notícia: $e');
      throw Exception('ERRO_AO_ADICIONAR_NOTICIA');
    }
  }

  /// Carrega todas as notícias do Firestore, ordenadas pela mais recente.
  static Future<List<Noticia>> carregarNoticias() async {
    try {
      final snapshot = await _colecaoNoticias
          .orderBy('dataHoraAdicao', descending: true)
          .get();
      
      return snapshot.docs.map((doc) => 
        Noticia.fromMap(doc.data() as Map<String, dynamic>, doc.id)
      ).toList();
    } catch (e) {
      print('Erro ao carregar notícias: $e');
      throw Exception('ERRO_AO_CARREGAR_NOTICIAS');
    }
  }

  /// Filtra as notícias por uma categoria específica, ordenadas pela mais recente.
  static Future<List<Noticia>> filtrarNoticiasPorCategoria(String categoria) async {
    try {
      final snapshot = await _colecaoNoticias
          .where('categoria', isEqualTo: categoria)
          .orderBy('dataHoraAdicao', descending: true)
          .get();
      
      return snapshot.docs.map((doc) => 
        Noticia.fromMap(doc.data() as Map<String, dynamic>, doc.id)
      ).toList();
    } catch (e) {
      print('Erro ao filtrar notícias: $e');
      throw Exception('ERRO_AO_FILTRAR_NOTICIAS');
    }
  }

  /// Conta quantas notícias um colaborador específico publicou.
  static Future<int> contarNoticiasPorColaborador(String nomeColaborador) async {
    try {
      // O método count() é mais eficiente pois não baixa os documentos.
      final aggregateQuery = _colecaoNoticias
          .where('colaborador', isEqualTo: nomeColaborador)
          .count();
          
      final snapshot = await aggregateQuery.get();
      return snapshot.count ?? 0;
    } catch (e) {
      print('Erro ao contar notícias do colaborador: $e');
      throw Exception('ERRO_AO_CONTAR_NOTICIAS');
    }
  }

  /// Edita uma notícia existente no Firestore.
  static Future<void> editarNoticia(Noticia noticia) async {
    // Garante que a notícia tenha um ID para ser editada.
    if (noticia.id == null || noticia.id!.isEmpty) {
      throw Exception('ID da notícia inválido para edição.');
    }
    try {
      await _colecaoNoticias.doc(noticia.id).update(noticia.toMap());
    } catch (e) {
      print('Erro ao editar notícia: $e');
      throw Exception('ERRO_AO_EDITAR_NOTICIA');
    }
  }

  /// Deleta uma notícia do Firestore usando seu ID.
  static Future<void> deletarNoticia(String id) async {
    try {
      await _colecaoNoticias.doc(id).delete();
    } catch (e) {
      print('Erro ao deletar notícia: $e');
      throw Exception('ERRO_AO_DELETAR_NOTICIA');
    }
  }
}