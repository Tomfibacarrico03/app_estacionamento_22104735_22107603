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
   double preco;
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
        required this.preco}
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
      id: " hsui",
        nome: map['nome'],
        maximoOcupacao: ocupacaoMax,
        atualOcupacao: ocupacaoAtual,
        tipo: map['tipo'], imagem: '_', endereco: '_', distancia: 0, preco: 0, dataAtualizada: map['data_ocupacao'],
    );
  }
   factory Estacionamento.fromDB(Map<String,dynamic> db){
     print('Estacionamento fromMap: $db');
     return Estacionamento(
       id: db['id'],
       nome: db['nome'],
       maximoOcupacao: db['capacidade_max'],
       atualOcupacao: db['ocupacao'],
       tipo: db['tipo'], imagem: '_', endereco: '_', distancia: 0, preco: 0, dataAtualizada: db['data_ocupacao'],
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
      'preco':preco,
      'data_ocupacao':dataAtualizada
    };
   }
}
