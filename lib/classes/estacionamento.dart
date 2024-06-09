import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'incidente.dart';

class Estacionamento {
  String id = 'P';
  String imagem;
  String nome;
  String endereco;
  int? maximoOcupacao;
  int? atualOcupacao;
  String tipo;
  String dataAtualizada;
  double distancia;
  double latitude;
  double longitude;
  String tarifa;
  List<Incidente> incidentes = [];

  Estacionamento({
    required this.id,
    required this.imagem,
    required this.nome,
    required this.endereco,
    required this.maximoOcupacao,
    required this.atualOcupacao,
    required this.tipo,
    required this.dataAtualizada,
    required this.distancia,
    required this.latitude,
    required this.longitude,
    required this.tarifa
  });

  bool addIncidente(Incidente incidente) {
    try {
      incidentes.add(incidente);
      return true;
    } catch (e) {
      print('Failed to add incident: $e');
      return false;
    }
  }

  List<Incidente> getIncidentes() {
    try {
      return incidentes;
    } catch (e) {
      print('Error getting incidents: $e');
      return [];
    }
  }

  String getMaximo() {
    try {
      return atualOcupacao.toString();
    } catch (e) {
      print('Error getting maximum occupancy: $e');
      return 'Error';
    }
  }

  String getOcupacao() {
    try {
      return '$atualOcupacao / $maximoOcupacao';
    } catch (e) {
      print('Error getting current occupancy: $e');
      return 'Error';
    }
  }

  static Estacionamento fromMap(Map<String, dynamic> map) {
    try {
      int ocupacaoAtual = map['ocupacao'];
      int ocupacaoMax = map['capacidade_max'];

      if (ocupacaoAtual < 0) {
        ocupacaoAtual = -ocupacaoAtual;
      }
      if (ocupacaoMax < 0) {
        ocupacaoMax = -ocupacaoMax;
      }
      if (ocupacaoAtual > ocupacaoMax) {
        ocupacaoAtual = ocupacaoMax;
      }
      return Estacionamento(
        nome: map['nome'] ?? 'Unnamed',
        id: map['id_parque'] ?? 'Unknown',
        maximoOcupacao: ocupacaoMax,
        atualOcupacao: ocupacaoAtual,
        latitude: double.parse(map['latitude']),
        longitude: double.parse(map['longitude']),
        tipo: map['tipo'] ?? 'Unknown',
        imagem: '_',
        endereco: '_',
        distancia: 0,
        tarifa: map['tarifa'] ?? 'Unknown',
        dataAtualizada: map['data_ocupacao'],
      );
    } catch (e) {
      print('Error creating Estacionamento from map: $e');
      return Estacionamento(
        nome: 'Error',
        id: 'Error',
        maximoOcupacao: 0,
        atualOcupacao: 0,
        latitude: 0.0,
        longitude: 0.0,
        tipo: 'Error',
        imagem: '_',
        endereco: '_',
        distancia: 0,
        tarifa: 'Error',
        dataAtualizada: 'Error',
      );
    }
  }

  static Estacionamento fromDB(Map<String, dynamic> db) {
    try {
      return Estacionamento(
        id: db['id'] ?? 'Unknown',
        nome: db['nome'] ?? 'Unnamed',
        maximoOcupacao: db['capacidade_max'] ?? 0,
        atualOcupacao: db['ocupacao'] ?? 0,
        latitude: db['latitude'],
        longitude: db['longitude'],
        tipo: db['tipo'] ?? 'Unknown',
        imagem: '_',
        endereco: '_',
        distancia: 0,
        tarifa: db['tarifa'] ?? 'Unknown',
        dataAtualizada: db['data_ocupacao'],
      );
    } catch (e) {
      print('Error creating Estacionamento from DB: $e');
      return Estacionamento(
        nome: 'Error',
        id: 'Error',
        maximoOcupacao: 0,
        atualOcupacao: 0,
        latitude: 0.0,
        longitude: 0.0,
        tipo: 'Error',
        imagem: '_',
        endereco: '_',
        distancia: 0,
        tarifa: 'Error',
        dataAtualizada: 'Error',
      );
    }
  }

  Map<String, dynamic> toDb() {
    try {
      return {
        'id': id,
        'nome': nome,
        'capacidade_max': maximoOcupacao,
        'ocupacao': atualOcupacao,
        'tipo': tipo,
        'distancia': distancia,
        'tarifa': tarifa,
        'latitude': latitude,
        'longitude': longitude,
        'data_ocupacao': dataAtualizada,
      };
    } catch (e) {
      print('Error converting to DB map: $e');
      return {};
    }
  }
}
