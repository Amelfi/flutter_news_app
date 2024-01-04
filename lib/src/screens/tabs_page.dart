import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/screens/screens.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _NavigationModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigate(),
      ),
    );
  }
}

class _Navigate extends StatelessWidget {
  const _Navigate();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        onTap: (valor) => navegacionModel.paginaActual = valor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Para ti'),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), label: 'Encabezados'),
        ]);
  }
}

class _Pages extends StatelessWidget {
  const _Pages();

  @override
  Widget build(BuildContext context) {
    final changePage = Provider.of<_NavigationModel>(context);
    // final newsService = Provider.of<NewsService>(context);
    return PageView(
      // physics: const BouncingScrollPhysics(),
      controller: changePage.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget> [
        Tab1Screen(),
        Tab2Screen()
      ],
    );
  }
}

class _NavigationModel extends ChangeNotifier {
  int _paginaActual = 0;
  final _pageController = PageController();
  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
