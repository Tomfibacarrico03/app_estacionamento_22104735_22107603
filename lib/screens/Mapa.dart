import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app_estacionamento_22104735_22107603/geoLocalizacao/controlador.dart'; // Import location controller

class Mapa extends StatelessWidget {
  const Mapa({super.key});

  @override
  Widget build(BuildContext context) {
    final geo = Provider.of<controlGeo>(context); // Access location controller
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(geo.lat, geo.long),
              zoom: 15,
            ),
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController gmc) {
              geo.onMapCreated(gmc);
              geo.loadMarkers(context); // Passa o contexto para a função loadMarkers
            },
            markers: geo.markersParques,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              centerTitle: true, // Centraliza o título
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0), // Aumente o espaço vertical se necessário.
                child: Container(
                  height: 35,  // Altura fixa
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0), // Espaço ao redor do texto
                  decoration: BoxDecoration(
                    color: Colors.white, // Cor de fundo do retângulo
                    borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                    border: Border.all(
                      color: Colors.lightGreen, // A cor das bordas
                      width: 2.0, // A largura da borda
                    ),
                  ),
                  child: const Text(
                    'Mapa de Parques',
                    style: TextStyle(
                      color: Color(0xFF00486A), // Cor do texto
                      fontSize: 25, // Tamanho do texto
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent, // Torna o fundo da AppBar transparente
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
