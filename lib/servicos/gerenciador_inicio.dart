import 'package:shared_preferences/shared_preferences.dart';

class GerenciadorInicio {
  static const String _chaveOpcaoEscolhida = 'opcaoEscolhida';

  static Future<void> salvarOpcao(String opcao) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveOpcaoEscolhida, opcao);
  }

  static Future<String?> getOpcaoEscolhida() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chaveOpcaoEscolhida);
  }
}