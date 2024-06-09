import 'package:app_estacionamento_22104735_22107603/screens/detalhes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import Google Maps package
import 'package:app_estacionamento_22104735_22107603/globals.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../classes/estacionamento.dart';
import 'package:app_estacionamento_22104735_22107603/geoLocalizacao/controlador.dart'; // Import location controller

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  final TextEditingController parque = TextEditingController();
  List<Estacionamento> filteredList = [];
  bool showSearchResults = false;
  Estacionamento? parkWithMostIncidents;
  List<Estacionamento> listaDeParques = [];

  @override
  void initState() {
    super.initState();
    findParkWithMostIncidents();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<controlGeo>(context, listen: false).getPosicao(); // Request location after widget loads
    });
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      filteredList = [];
      showSearchResults = false;
    } else {
      filteredList = listaDeParques
          .where(
              (park) => park.nome.toLowerCase().contains(query.toLowerCase()))
          .toList();
      showSearchResults = true;
    }
    setState(() {});
  }

  void findParkWithMostIncidents() {
    if (listaDeParques.isEmpty) {
      parkWithMostIncidents = null;
    } else {
      parkWithMostIncidents = listaDeParques.reduce((current, next) {
        return (current.incidentes.length > next.incidentes.length)
            ? current
            : next;
      });
      // Check if the highest incident count is 0
      if (parkWithMostIncidents!.incidentes.isEmpty) {
        parkWithMostIncidents = null;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final geo = Provider.of<controlGeo>(context); // Access location controller

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.lightGreen, width: 2.0),
                    ),
                    child: const Text('Dashboard',
                        style: TextStyle(color: Color(0xFF00486A), fontSize: 25)),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              const SizedBox(height: 10),
              if (parkWithMostIncidents != null)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    side: const BorderSide(color: Colors.lightGreen, width: 2.0), // Border color and width
                  ),
                  child: ListTile(
                    tileColor: Colors.white, // Background color of the ListTile
                    leading: const Icon(Icons.warning,
                        color: Color(0xFF00486A), // Text color
                        size: 40), // Leading icon with a warning sign
                    title: Text(
                      '${parkWithMostIncidents!.nome} é o parque com mais incidentes',
                      style: const TextStyle(
                        color: Color(0xFF00486A), // Text color
                        fontWeight: FontWeight.bold, // Bold text for emphasis
                        fontSize: 16.5, // Font size for title
                      ),
                    ),
                  ),
                ),
              if (parkWithMostIncidents == null)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Sem registo de incidentes 🥳",
                    style: TextStyle(
                      color: Color(0xFF00486A), // Text color
                      fontWeight: FontWeight.bold, // Bold text for emphasis
                      fontSize: 16.5, // Font size for title
                    ),),
                ),
              const SizedBox(height: 10),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  side: const BorderSide(color: Colors.lightGreen, width: 6.0), // Border color and width
                ),
                color : const Color(0xFF00486A),

                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: const Text('Parque mais perto: ',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold, // Bold text for emphasis
                      fontSize: 14, // Font size for title
                    ),
                  ),
                  subtitle: listaDeParques.isNotEmpty
                      ? Text('${listaDeParques[1].nome} -> ${listaDeParques[1].distancia} km',
                    style: const TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold, // Bold text for emphasis
                      fontSize: 17, // Font size for title
                    ),
                  )
                      : const Text('Nenhum parque encontrado',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold, // Bold text for emphasis
                      fontSize: 17, // Font size for title
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  side: const BorderSide(color: Colors.lightGreen, width: 2.0), // Border color and width
                ),
                color : const Color(0xFFFFFFFF),
                elevation: 5, // Elevation for shadow
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Minimum size based on content
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child:  const ListTile(
                        leading: Icon(Icons.pin_drop, size: 30, color: Color(0xFF00486A)),
                        title: Text('Veja os parques mais próximos', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00486A))),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      height: 275.0,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(geo.lat, geo.long), // Use actual coordinates from the provider
                          zoom: 13.0,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('current_location'),
                            position: LatLng(geo.lat, geo.long),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
