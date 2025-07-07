import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri_noticias/modelos/colaborador.dart';

class GerenciadorColaborador {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Armazena os dados do colaborador logado vindos do Firestore
  static Colaborador? colaboradorLogado;

  /// Realiza o login usando E-mail e Senha diretamente.
  static Future<void> login(String email, String senha) async {
    try {
      // ETAPA 1: Fazer login com o Firebase Auth usando e-mail e senha.
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // ETAPA 2: Se o login for bem-sucedido, carregar os dados do colaborador.
      if (userCredential.user != null) {
        await _carregarColaboradorAtual(userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      // Trata erros específicos do Firebase Auth
      // O código 'invalid-credential' é usado para e-mail não encontrado ou senha errada.
      if (e.code == 'invalid-credential') {
        throw Exception('E-mail ou senha inválidos.');
      } else if (e.code == 'invalid-email') {
        throw Exception('O formato do e-mail é inválido.');
      }
      // Você pode adicionar mais tratamentos de erro se necessário
      else {
        throw Exception('Ocorreu um erro durante o login.');
      }
    } catch (e) {
      // Repassa outras exceções
      rethrow;
    }
  }

  /// Verifica se já existe uma sessão de usuário ativa ao iniciar o app.
  static Future<void> verificarSessao() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Se há um usuário na sessão do Firebase, carrega seus dados do Firestore.
      await _carregarColaboradorAtual(user.uid);
    }
  }

  /// Faz o logout do usuário.
  static Future<void> logout() async {
    await _auth.signOut();
    colaboradorLogado = null;
  }

  /// Verifica se o usuário está logado.
  static bool isLogado() {
    // A fonte da verdade é o estado do Firebase Auth.
    return _auth.currentUser != null && colaboradorLogado != null;
  }

  /// Método privado para buscar os dados do colaborador no Firestore e preencher a variável local.
  static Future<void> _carregarColaboradorAtual(String uid) async {
    try {
      final docSnapshot = await _db.collection('colaboradores').doc(uid).get();
      if (docSnapshot.exists) {
        colaboradorLogado = Colaborador.fromMap(docSnapshot.data()!, docSnapshot.id);
      } else {
        // Isso pode acontecer se o usuário do Auth existir, mas o documento no Firestore não.
        // Trate esse caso de erro conforme a regra do seu negócio.
        throw Exception('Dados do colaborador não encontrados no banco de dados.');
      }
    } catch (e) {
      // Se não conseguir carregar os dados, força o logout para evitar um estado inconsistente.
      await logout();
      rethrow;
    }
  }

  /// Carrega a lista de todos os colaboradores do Firestore.
  static Future<List<Colaborador>> carregarColaboradores() async {
    try {
      final snapshot = await _db.collection('colaboradores').get();
      
      if (snapshot.docs.isEmpty) {
        return [];
      }

      // Mapeia cada documento para um objeto Colaborador.
      return snapshot.docs.map((doc) {
        return Colaborador.fromMap(doc.data(), doc.id);
      }).toList();

    } catch (e) {
      print('Erro ao carregar colaboradores: $e');
      // Lança uma exceção para ser tratada na UI.
      throw Exception('Não foi possível carregar os colaboradores.');
    }
  }
}