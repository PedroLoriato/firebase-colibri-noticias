import 'package:colibri_noticias/modelos/colaborador.dart';
import 'package:colibri_noticias/paginas/acesso.dart';
import 'package:colibri_noticias/paginas/inicio.dart';
import 'package:colibri_noticias/servicos/gerenciador_inicio.dart';
import 'package:colibri_noticias/servicos/gerenciador_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:colibri_noticias/paginas/noticias.dart';
import 'package:colibri_noticias/paginas/sobre.dart';
import 'package:colibri_noticias/componentes/barra_navegacao.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

List<Colaborador> listaColaboradores = [
  Colaborador(
    imagem: 'assets/imagens/pedro-avatar.jpg',
    nome: 'Pedro Henrique',
    sobrenome: 'Loriato',
    cpf: '123.456.789-00',
    senha: 'senha123',
  ),
  Colaborador(
    imagem: 'assets/imagens/katiane-avatar.jpg',
    nome: 'Katiane',
    sobrenome: 'Maciel do Nascimento',
    cpf: '123.456.789-01',
    senha: 'senha234',
  ),
];

void main() {
  tz.initializeTimeZones();
  runApp(const ColibriNoticias());
}

class ColibriNoticias extends StatelessWidget {
  const ColibriNoticias({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colibri Notícias',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(
          primary: Colors.green[900],
          secondary: Colors.blueAccent[700],
        ),
        primaryColor: const Color.fromRGBO(0, 255, 13, 1),
        primaryColorDark: Colors.green[700],
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          240,
          240,
          220,
        ), // Fundo do app
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white, // Cor do texto na AppBar
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.loraTextTheme(),
        canvasColor: Colors.transparent,
      ),
      home: const TelaPrincipal(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Inglês
        Locale('pt', 'BR'), // Português do Brasil
      ],
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _verificarSessao();
  }

  Future<void> _verificarSessao() async {
    String? opcao = await GerenciadorInicio.getOpcaoEscolhida();
    if (opcao == null) {
      // Se não houver opção escolhida, redireciona para a tela de início
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Inicio()),
        );
      }
    } else if (opcao == 'colaborador') {
      await GerenciadorLogin.verificarSessao();
      // Se a opção for colaborador, verifica se está logado
      if (!GerenciadorLogin.isLogado()) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Acesso()),
          );
        }
      }
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [Noticias(), Sobre()],
      ),
      bottomNavigationBar: BarraNavegacao(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
