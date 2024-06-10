import 'package:app_estacionamento_22104735_22107603/data/parques_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'classes/estacionamento.dart';
import 'screens/dashboard.dart';
import 'screens/parques.dart';
import 'screens/mapa.dart';
import 'screens/registarincidente.dart';
import 'repository/estacionamento_repository.dart';
import 'http/http_client.dart';
import 'geoLocalizacao/controlador.dart'; // Importação do controlador de geolocalização


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    MultiProvider(
      providers: [
        Provider<EstacionamentosRepository>(
            create: (_) => EstacionamentosRepository(client: HttpClient())),
        Provider<PARQUESDatabase>(create: (_) => PARQUESDatabase()),
        ChangeNotifierProvider<controlGeo>( // Adição do controlador de geolocalização
          create: (_) => controlGeo(),
        ),
      ],
      child: const TabBarDemo(),
    ),
  );
}

class TabBarDemo extends StatefulWidget {
  final int initialIndex;
  final Estacionamento? registarIncidenteParque;
  const TabBarDemo(
      {super.key, this.initialIndex = 0, this.registarIncidenteParque});

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {

  @override
  Widget build(BuildContext context) {
    final parquesDatabase = context.read<PARQUESDatabase>();

    return FutureBuilder(
      future: parquesDatabase.init(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: DefaultTabController(
              length: 4, // Number of tabs
              initialIndex: widget.initialIndex, // Use the initial index here
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(
                      70.0), // Set the height of the AppBar
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF00486A), // Background color of the AppBar
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            20.0), // Radius for bottom left corner
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: AppBar(
                      backgroundColor:
                      Colors.transparent, // Make the AppBar transparent
                      elevation: 0, // Remove the shadow
                      centerTitle: true,
                      title: const Text(
                        'PARK4U',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          letterSpacing: 2.0, // Letter spacing
                          shadows: [
                            // Shadow for the text
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
                body: TabBarView(
                  children: [
                    const DashBoard(),
                    ParquesPage(),
                    const Mapa(),
                    RegistarIncidentes(parque: widget.registarIncidenteParque),
                  ],
                ),
                bottomNavigationBar: const ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), // Radius for top left corner
                    topRight: Radius.circular(20), // Radius for top right corner
                  ),
                  child: SizedBox(
                    height: 90,
                    child: Material(
                      color: Color(0xFF00486A),
                      child: TabBar(
                        tabs: [
                          Tab(
                              icon: Icon(Icons.dashboard, size: 40),
                              text: "Dashboard"),
                          Tab(
                              icon: Icon(Icons.list, size: 40),
                              text: "Parques"),
                          Tab(icon: Icon(Icons.map, size: 40), text: "Mapa"),
                          Tab(
                              icon: Icon(Icons.error, size: 40),
                              text: "Incidente"),
                        ],
                        labelColor: Colors.lightGreen,
                        unselectedLabelColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.blueGrey,
                        labelStyle:
                        TextStyle(fontSize: 17), // Increase text size
                        unselectedLabelStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return MaterialApp(
            home: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
