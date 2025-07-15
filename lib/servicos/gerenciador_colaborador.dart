import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri_noticias/modelos/colaborador.dart';

class GerenciadorColaborador {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Colaborador? colaboradorLogado;

  static Future<void> login(String email, String senha) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      if (userCredential.user != null) {
        await _carregarColaboradorAtual(userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw Exception('E-mail ou senha inválidos.');
      } else if (e.code == 'invalid-email') {
        throw Exception('O formato do e-mail é inválido.');
      }
      else {
        throw Exception('Ocorreu um erro durante o login.');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> verificarSessao() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _carregarColaboradorAtual(user.uid);
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
    colaboradorLogado = null;
  }

  static bool isLogado() {
    return _auth.currentUser != null && colaboradorLogado != null;
  }

  static Future<void> _carregarColaboradorAtual(String uid) async {
    try {
      final docSnapshot = await _db.collection('colaboradores').doc(uid).get();
      if (docSnapshot.exists) {
        colaboradorLogado = Colaborador.fromMap(docSnapshot.data()!, docSnapshot.id);
      } else {
        throw Exception('Dados do colaborador não encontrados no banco de dados.');
      }
    } catch (e) {
      await logout();
      rethrow;
    }
  }

  static Future<List<Colaborador>> carregarColaboradores() async {
    try {
      final snapshot = await _db.collection('colaboradores').get();
      
      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) {
        return Colaborador.fromMap(doc.data(), doc.id);
      }).toList();

    } catch (e) {
      throw Exception('Não foi possível carregar os colaboradores.');
    }
  }

   static Future<Colaborador> carregarColaboradorPorReferencia(
      DocumentReference colaboradorRef) async {
    try {
      final docSnapshot = await colaboradorRef.get();
      if (docSnapshot.exists) {
        return Colaborador.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      } else {
        throw Exception(
            'Colaborador referenciado com id ${colaboradorRef.id} não foi encontrado.');
      }
    } catch (e) {
      rethrow;
    }
  }
}