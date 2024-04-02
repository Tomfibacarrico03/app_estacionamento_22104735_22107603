import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'parques.dart';
import 'Mapa.dart';
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0), // Aqui você pode definir a altura da AppBar
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF00486A), // A cor de fundo da AppBar
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0), // Defina o raio para os cantos inferiores
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent, // Deixa o AppBar transparente
              elevation: 0, // Remove a sombra
              centerTitle: true,
              title: const Text(
                'PARK4U',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                  letterSpacing: 2.0, // Espaçamento entre as letras
                  shadows: [ // Sombra para o texto
                    Shadow(
                      offset: Offset(2.0, 1.0),
                      blurRadius: 6.0,
                      color: Color(0xFF3ADF43),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
