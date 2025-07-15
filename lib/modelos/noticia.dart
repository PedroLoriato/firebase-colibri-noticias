import 'package:colibri_noticias/modelos/colaborador.dart';
import 'package:colibri_noticias/modelos/categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri_noticias/servicos/gerenciador_categoria.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';

class Noticia {
  final String? id;
  final Uri imagem;
  final String fonte;
  final String titulo;
  final String resumo;
  final Uri link;
  final DateTime dataHoraPublicacao;
  final Colaborador colaborador; 
  final DateTime dataHoraAdicao;
  final Categoria categoria; 

  Noticia({
    this.id,
    required this.imagem,
    required this.fonte,
    required this.titulo,
    required this.resumo,
    required this.link,
    required this.colaborador,
    required this.dataHoraPublicacao,
    required this.categoria,
    DateTime? dataHoraAdicao,
  }) : dataHoraAdicao = dataHoraAdicao ?? DateTime.now();

  Map<String, dynamic> toMap() {
    final firestore = FirebaseFirestore.instance;

    return {
      'imagem': imagem.toString(),
      'fonte': fonte,
      'titulo': titulo,
      'resumo': resumo,
      'link': link.toString(),
      'categoria': firestore.collection('categorias').doc(categoria.id),
      'dataHoraPublicacao': Timestamp.fromDate(dataHoraPublicacao),
    };
  }

  static Future<Noticia> fromMap(Map<String, dynamic> map, String documentId) async {
    final DocumentReference colaboradorRef = map['colaborador'];
    final DocumentReference categoriaRef = map['categoria'];

    final results = await Future.wait([
      GerenciadorColaborador.carregarColaboradorPorReferencia(colaboradorRef),
      GerenciadorCategoria.carregarCategoriaPorReferencia(categoriaRef),
    ]);

    final Colaborador colaborador = results[0] as Colaborador;
    final Categoria categoria = results[1] as Categoria;

    return Noticia(
      id: documentId,
      imagem: Uri.parse(map['imagem']),
      fonte: map['fonte'],
      titulo: map['titulo'],
      resumo: map['resumo'],
      link: Uri.parse(map['link']),
      colaborador: colaborador,
      categoria: categoria,      
      dataHoraPublicacao: (map['dataHoraPublicacao'] as Timestamp).toDate(),
      dataHoraAdicao: (map['dataHoraAdicao'] as Timestamp).toDate(),
    );
  }
}