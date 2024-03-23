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
            title: const Text('PARK4U'),
          ),
          body: const TabBarView(
            children: [
              MenuPage(),
              Parques(),
              Mapa(),
              Incidentes(),
            ],
          ),
          // Move TabBar to bottomNavigationBar
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home_filled, size: 30), text: "Menu"),
              Tab(icon: Icon(Icons.list, size: 30), text: "Parques"),
              Tab(icon: Icon(Icons.map, size: 30), text: "Mapa"),
              Tab(icon: Icon(Icons.error, size: 30), text: "Incidente"),
            ],
            // Apply a material design so the TabBar looks appropriate at the bottom
            labelColor: Colors.lightGreen,
            unselectedLabelColor: Colors.blueGrey,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
      ),
    );
  }
}
