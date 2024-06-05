import 'package:flutter/cupertino.dart';
import 'incidente.dart';
import 'package:flutter/material.dart';

class Estacionamento {
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
      {  required this.imagem,
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
    if (atualOcupacao! < 0){
      atualOcupacao = atualOcupacao! * (-1);
    }
    if (maximoOcupacao! < 0){
      maximoOcupacao = maximoOcupacao! * (-1);
    }
    return '$atualOcupacao / $maximoOcupacao';
  }

  factory Estacionamento.fromMap(Map<String,dynamic> map){
    print('Estacionamento fromMap: $map');
    return Estacionamento(
        nome: map['nome'],
        maximoOcupacao: map['capacidade_max'],
        atualOcupacao: map['ocupacao'],
        tipo: map['tipo'], imagem: '_', endereco: '_', distancia: 0, preco: 0, dataAtualizada: map['data_ocupacao'],
    );
  }
}
