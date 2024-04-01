import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'parques.dart';
import 'mapa.dart';
import 'incidente.dart';

void main() {
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Use DefaultTabController to manage tab selection
    return MaterialApp(
        home: DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('PARK4'),
        ),
        body: const TabBarView(
          children: [
            MenuPage(),
            Parques(),
            Mapa(),
            Incidentes(),
          ],
        ),
        // Move TabBar to bottomNavigationBar+
        bottomNavigationBar: const ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), // Raio da borda superior esquerda
            topRight: Radius.circular(20), // Raio da borda superior direita
          ),
          child: SizedBox(
            height: 90,
            child: Material(
              color: Color(0xFF00486A),
              child: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home_filled, size: 40), text: "Menu"),
                  Tab(icon: Icon(Icons.list, size: 40), text: "Parques"),
                  Tab(icon: Icon(Icons.map, size: 40), text: "Mapa"),
                  Tab(icon: Icon(Icons.error, size: 40), text: "Incidente"),
                ],
                // Apply a material design so the TabBar looks appropriate at the bottom
                labelColor: Colors.lightGreen,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.blueGrey,
                labelStyle:
                    TextStyle(fontSize: 17), // Aumento do tamanho do texto
                unselectedLabelStyle: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
