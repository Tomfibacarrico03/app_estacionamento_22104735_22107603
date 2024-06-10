import 'package:app_estacionamento_22104735_22107603/classes/estacionamento.dart';
import 'package:app_estacionamento_22104735_22107603/screens/detalhes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../data/parques_database.dart';
import '../repository/estacionamento_repository.dart';

class controlGeo extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = ' ';
  late GoogleMapController _mapsController;
  Set<Marker> markersParques = <Marker>{};

  get mapsController => _mapsController;

  void onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    await getPosicao();
    notifyListeners();  // Notifica a atualização de estado
  }

  void loadMarkers(BuildContext context) async {
    final parquesDB = context.read<PARQUESDatabase>();
    final parquesRepo = context.read<EstacionamentosRepository>();

    List<Estacionamento> estacionamentos = await parquesRepo.getEstacionamentos(null);

    for (var parque in estacionamentos) {
      markersParques.add(
        Marker(
            markerId: MarkerId(parque.id),
            position: LatLng(parque.latitude, parque.longitude),
            icon: await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(),
                'assets/location.png'
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => DetalhesDoParque(parque: parque)
              );
            }
        ),
      );
    }
    notifyListeners();
  }

  Future<void> getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativada = await Geolocator.isLocationServiceEnabled();
    if (!ativada) {
      return Future.error('Ative a localização');
    }
    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Autorize o acesso à localização');
      }
    }
    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Precisa de autorizar manualmente a localização');
    }
    return await Geolocator.getCurrentPosition();
  }
}
