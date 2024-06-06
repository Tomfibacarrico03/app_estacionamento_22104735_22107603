import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class controlGeo extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = ' ';

  localizacao() {
    getPosicao();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
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
        Future.error('Autorize o acesso à localização');
      }
    }
    if(permissao == LocationPermission.deniedForever){
      return Future.error('Precisa de autorizar manualmente a localização');
    }
    return await  Geolocator.getCurrentPosition();
  }
}