import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_estacionamento_22104735_22107603/classes/estacionamento.dart';

class EstacionamentosRepository {
  Future<List<Estacionamento>> fetchEstacionamentos() async {
    final response = await http.get(Uri.parse('URL_DA_API_DA_EMEL')); // Substitua pela URL da API da EMEL

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Estacionamento> estacionamentos = jsonData.map((item) => Estacionamento.fromJson(item)).toList();
      await saveEstacionamentosLocally(estacionamentos);
      return estacionamentos;
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<void> saveEstacionamentosLocally(List<Estacionamento> estacionamentos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonData = estacionamentos.map((estacionamento) => json.encode(estacionamento.toJson())).toList();
    await prefs.setStringList('estacionamentos', jsonData);
  }

  Future<List<Estacionamento>> loadEstacionamentosFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonData = prefs.getStringList('estacionamentos');
    if (jsonData != null) {
      return jsonData.map((item) => Estacionamento.fromJson(json.decode(item))).toList();
    } else {
      return [];
    }
  }
}
