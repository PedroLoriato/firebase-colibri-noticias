import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BotaoSocial extends StatelessWidget {
  final Uri link;
  final String nomeBotao;
  final Color primeiraCorGradiente;
  final Color segundaCorGradiente;

  const BotaoSocial({
    super.key,
    required this.link,
    required this.nomeBotao,
    required this.primeiraCorGradiente,
    required this.segundaCorGradiente,
  });

  Future<void> _abrirURL(Uri url, BuildContext context) async {
    // Verifica se está na plataforma Web
    if (kIsWeb) {
      await launchUrl(url, webOnlyWindowName: '_blank');
    } else {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primeiraCorGradiente, segundaCorGradiente],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: () {
          _abrirURL(link, context);
        },
        child: Text(
          nomeBotao,
          style: TextStyle(
            fontSize: 10, 
            fontWeight: FontWeight.w700
            ),
        ),
      ),
    );
  }
}