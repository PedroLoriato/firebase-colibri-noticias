import 'package:shared_preferences/shared_preferences.dart';

class GerenciadorInicio {
  // Chave para armazenar a opção escolhida
  static const String _chaveOpcaoEscolhida = 'opcaoEscolhida';

  /// Salva a opção escolhida (leitor ou colaborador) nas preferências.
  static Future<void> salvarOpcao(String opcao) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveOpcaoEscolhida, opcao);
  }

  /// Verifica e retorna a opção escolhida armazenada nas preferências.
  static Future<String?> getOpcaoEscolhida() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chaveOpcaoEscolhida);
  }
}