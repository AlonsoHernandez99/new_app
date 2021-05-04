import 'package:flutter/material.dart';
import 'package:news_app/pages/tab1_page.dart';
import 'package:news_app/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
        currentIndex: _navigationModel.currentPage,
        onTap: (i) => _navigationModel.currentPage = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'For You'),
          BottomNavigationBarItem(
              icon: Icon(Icons.public_sharp), label: 'Headlines')
        ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      //physics: BouncingScrollPhysics(),
      controller: _navigationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = new PageController();

  int get currentPage => _currentPage;
  set currentPage(int value) {
    this._currentPage = value;
    this._pageController.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
