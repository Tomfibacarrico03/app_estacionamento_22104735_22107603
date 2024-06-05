import 'dart:io';

import 'package:app_estacionamento_22104735_22107603/http/http_client.dart';
import 'package:app_estacionamento_22104735_22107603/screens/parques.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_estacionamento_22104735_22107603/classes/estacionamento.dart';

class EstacionamentosRepository {
  final HttpClient _client;

  EstacionamentosRepository({required HttpClient client}) : _client = client;

  Future<List<Estacionamento>> getEstacionamentos() async {
    final response = await _client.get(
        url: 'https://emel.city-platform.com/opendata/parking/lots',
        headers: {'accept': 'application/json','api_key': '93600bb4e7fee17750ae478c22182dda'});

    if (response.statusCode == 200) {
      final responseJSON = jsonDecode(response.body);
      List charactersJSON = responseJSON;

      List<Estacionamento> parques = charactersJSON
          .map((charactersJSON) => Estacionamento.fromMap(charactersJSON))
          .toList();

      return parques;
    } else {
      throw Exception('status code: ${response.statusCode}');
    }
  }

}
