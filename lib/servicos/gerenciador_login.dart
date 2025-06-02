import 'package:colibri_noticias/modelos/colaborador.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GerenciadorLogin {
  static Colaborador? colaboradorLogado;

  static Future<void> login(
    String cpf,
    String senha,
    List<Colaborador> colaboradores,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final Colaborador colaborador = colaboradores.firstWhere(
      (c) => c.cpf == cpf && c.senha == senha,
      orElse:
          () => Colaborador(
            imagem: '',
            nome: '',
            sobrenome: '',
            cpf: '',
            senha: '',
          ),
    );

    if (colaborador.nome.isNotEmpty) {
      colaboradorLogado = colaborador;
      await prefs.setString('imagem', colaborador.imagem);
      await prefs.setString('cpf', colaborador.cpf);
      await prefs.setString('nome', colaborador.nome);
      await prefs.setString('sobrenome', colaborador.sobrenome);
    } else {
      throw FormatException("CPF ou senha inválidos");
    }
  }

  static Future<void> verificarSessao() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagem = prefs.getString('imagem');
    String? cpf = prefs.getString('cpf');
    String? nome = prefs.getString('nome');
    String? sobrenome = prefs.getString('sobrenome');

    if (imagem != null && cpf != null && nome != null && sobrenome != null) {
      colaboradorLogado = Colaborador(
        imagem: imagem,
        nome: nome,
        sobrenome: sobrenome,
        cpf: cpf,
        senha: '',
      );
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    colaboradorLogado = null;
  }

  static bool isLogado() {
    return colaboradorLogado != null;
  }
}
