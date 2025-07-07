import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri_noticias/modelos/categoria.dart';

class GerenciadorCategoria {
  // Instância do Firestore e referência para a coleção 'categorias'
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _colecaoCategorias = _db.collection('categorias');

  /// Adiciona uma nova categoria ao Firestore.
  static Future<void> adicionarCategoria(Categoria categoria) async {
    try {
      // Converte o objeto Categoria para um Map e o adiciona à coleção.
      // O Firestore gera um ID de documento automaticamente.
      await _colecaoCategorias.add(categoria.toMap());
      print('Categoria adicionada com sucesso!');
    } catch (e) {
      print('Erro ao adicionar categoria: $e');
      throw Exception('ERRO_AO_ADICIONAR');
    }
  }

  /// Carrega todas as categorias do Firestore.
  static Future<List<Categoria>> carregarCategorias() async { 
    try {
      // Pega um "snapshot" (uma foto instantânea) da coleção.
      final snapshot = await _colecaoCategorias.get();

      // Mapeia cada documento do snapshot para um objeto Categoria.
      return snapshot.docs.map((doc) {
        // doc.data() retorna um Map<String, dynamic>
        return Categoria.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Erro ao carregar categorias: $e');
      throw Exception('ERRO_AO_CARREGAR');
    }
  }

  /// Carrega apenas os nomes de todas as categorias.
  static Future<List<String>> carregarNomesCategorias() async {
    final categorias = await carregarCategorias();
    return categorias.map((categoria) => categoria.nome).toList();
  }

  /// Verifica se uma categoria com um nome específico já existe.
  static Future<bool> temCategoria(String nomeCategoria) async {
    try {
      // Cria uma consulta para buscar por nome.
      // O limit(1) otimiza a busca, parando assim que encontrar um resultado.
      final snapshot = await _colecaoCategorias
          .where('nome', isEqualTo: nomeCategoria)
          .limit(1)
          .get();

      // Se a lista de documentos não estiver vazia, a categoria existe.
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Erro ao verificar categoria: $e');
      throw Exception('ERRO_AO_VERIFICAR');
    }
  }
}