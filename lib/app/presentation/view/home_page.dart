import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:poke_list/app/presentation/view/poke_register_page.dart';

import '../../../core/core_packages.dart';
import '../viewmodel/poke_viewmodel.dart';
import 'dashboard.dart';
import 'poke_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _vm = GetIt.I<PokeViewModel>();
  static const List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    PokeListPage(),
    PokeRegisterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        return Center(
          child: _widgetOptions.elementAt(_vm.currentPage),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Icon(Icons.format_list_bulleted),
            ),
            label: 'Pokelista',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Icon(Icons.add_circle),
            ),
            label: 'Cadastro',
          ),
        ],
        currentIndex: _vm.currentPage,
        onTap: _vm.setCurrentPage,
        backgroundColor: KColors.main,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
