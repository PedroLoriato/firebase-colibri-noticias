import 'package:flutter/material.dart';
class BarraNavegacao extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BarraNavegacao({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BarraNavegacao> createState() => _BarraNavegacaoState();
}

class _BarraNavegacaoState extends State<BarraNavegacao>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
        ),
      ),
      child: Material(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          onTap: (index) {
            widget.onTap(index);
            setState(() {
              _controller.reset();
              _controller.forward();
            });
          },
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              activeIcon: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 10 * _animation.value,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(100, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.article,
                      color: const Color.fromARGB(200, 255, 255, 255),
                    ),
                  );
                },
              ),
              label: 'Notícias',
              tooltip: 'Notícias',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              activeIcon: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 12 * _animation.value,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(100, 255, 255, 255),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.info,
                      color: const Color.fromARGB(200, 255, 255, 255),
                    ),
                  );
                },
              ),
              label: 'Sobre',
              tooltip: 'Sobre',
            ),
          ],
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
          selectedIconTheme: IconThemeData(
            size: 24,
            color: Colors.green,
            shadows: [
              BoxShadow(
                color: Colors.greenAccent.withValues(alpha: 0.4),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
