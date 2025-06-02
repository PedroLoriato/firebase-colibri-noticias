import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:colibri_noticias/componentes/botao_social.dart';

class CartaoColaborador extends StatelessWidget {
  final String imagem;
  final String nomeCompleto;
  final int numPublicacoes;
  final List<BotaoSocial> botoesSociais;

  const CartaoColaborador({
    super.key,
    required this.imagem,
    required this.nomeCompleto,
    required this.numPublicacoes,
    required this.botoesSociais,
  }) : assert(botoesSociais.length >= 0 && botoesSociais.length <= 3);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: GradientBoxBorder(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColor,
                  ],
                ),
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child:
                  constraints.maxWidth < 450
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _buildCardContent(),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _buildCardContent(),
                      ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildCardContent() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagem),
            radius: 40,
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Text(
                nomeCompleto,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: botoesSociais,
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 20, child: Divider(color: Colors.black, thickness: 1)),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$numPublicacoes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "PUBLICAÇÕES",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ];
  }
}
