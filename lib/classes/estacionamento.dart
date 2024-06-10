import 'package:flutter/cupertino.dart';
import 'incidente.dart';
import 'package:flutter/material.dart';

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
   String tarifa;
   double latitude;
   double longitude;
   List<Incidente> incidentes = [];

  Estacionamento(
      { required this.id ,
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
        required this.tarifa}
      );



  bool addIncidente(Incidente incidente) {

    try {
      incidentes.add(incidente);
      return true;
    } catch (e) {
      return false;
    }
  }

  getIncidentes() {
    return incidentes;
  }

  getMaximo() {
    return atualOcupacao.toString();
  }

  getOcupacao() {
    return '$atualOcupacao / $maximoOcupacao';
  }

  factory Estacionamento.fromMap(Map<String,dynamic> map){
    int ocupacaoAtual =  map['ocupacao'];
    int ocupacaoMax = map['capacidade_max'];

    if (ocupacaoAtual < 0){
      ocupacaoAtual = ocupacaoAtual * (-1);
    }
    if (ocupacaoMax < 0){
      ocupacaoMax = ocupacaoMax * (-1);
    }
    if(ocupacaoAtual > ocupacaoMax){
      ocupacaoAtual = ocupacaoMax;
    }
    print('Estacionamento fromMap: $map');
    return Estacionamento(
      nome: map['nome'] ?? 'Unnamed',
      id: map['id_parque'] ?? 'Unknown',
      maximoOcupacao: ocupacaoMax,
      atualOcupacao: ocupacaoAtual,
      latitude: double.parse(map['latitude']),
      longitude: double.parse(map['longitude']),
      tipo: map['tipo'] ?? 'Unknown', imagem: '_', endereco: '_', distancia: 0, tarifa: map['tarifa']?? 'Unknown', dataAtualizada: map['data_ocupacao'],
    );
  }
   factory Estacionamento.fromDB(Map<String,dynamic> db){
     print('Estacionamento fromDB: $db');
     return Estacionamento(
       id: db['id'] ?? 'Unknown',
       nome: db['nome'] ?? 'Unnamed',
       maximoOcupacao: db['capacidade_max'] ?? 0,
       atualOcupacao: db['ocupacao'] ?? 0,
       latitude: db['latitude'],
       longitude: db['longitude'] ,
       tipo: db['tipo'] ?? 'Unknown', imagem: '_', endereco: '_', distancia: 0, tarifa: db['tarifa']?? 'Unknown', dataAtualizada: db['data_ocupacao'],
     );
   }

   Map<String, dynamic> toDb(){
    return {
      'id': id,
      'nome':nome,
      'capacidade_max': maximoOcupacao,
      'ocupacao':atualOcupacao,
      'tipo':tipo,
      'distancia':distancia,
      'tarifa':tarifa,
      'latitude': latitude,
      'longitude': longitude,
      'data_ocupacao':dataAtualizada
    };
   }
}
