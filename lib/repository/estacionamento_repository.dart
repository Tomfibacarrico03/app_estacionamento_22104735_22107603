import 'dart:io';

import 'package:app_estacionamento_22104735_22107603/geoLocalizacao/controlador.dart';
import 'package:app_estacionamento_22104735_22107603/http/http_client.dart';
import 'package:app_estacionamento_22104735_22107603/screens/parques.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_estacionamento_22104735_22107603/classes/estacionamento.dart';

class EstacionamentosRepository {
  final HttpClient _client;

  EstacionamentosRepository({required HttpClient client}) : _client = client;

  Future<List<Estacionamento>> getEstacionamentos(controlGeo? geo) async {
    final response = await _client.get(
        url: 'https://emel.city-platform.com/opendata/parking/lots',
        headers: {'accept': 'application/json', 'api_key': '93600bb4e7fee17750ae478c22182dda'});

    if (response.statusCode == 200) {
      final responseJSON = jsonDecode(response.body);
      List<Estacionamento> parques = (responseJSON as List)
          .map((data) => Estacionamento.fromMap(data))
          .toList();

      if (geo != null) {
        await Future.wait(parques.map((estacionamento) async {
          estacionamento.distancia = await calculateDistance(geo.lat, geo.long, estacionamento.latitude, estacionamento.longitude);
        }));
      }

      return parques;
    } else {
      throw Exception('Failed to load parking data');
    }
  }

  Future<double> calculateDistance(double startLat, double startLng, double endLat, double endLng) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/distancematrix/json?origins=$startLat,$startLng&destinations=$endLat,$endLng&key=YOUR_API_KEY');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['rows'][0]['elements'][0]['status'] == 'OK') {
        double distanceInMeters = jsonResponse['rows'][0]['elements'][0]['distance']['value'];
        return distanceInMeters / 1000.0; // Convert to kilometers
      } else {
        return 0.0; // Default or error distance
      }
    } else {
      throw Exception('Failed to reach Google API');
    }
  }
}
