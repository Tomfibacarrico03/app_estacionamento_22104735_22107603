import 'incidente.dart';
import 'package:flutter/material.dart';

class Estacionamento {
  final String urlImagem;
  final String nome;
  final String endereco;
  final int? maximoOcupacao;
  final  int?  atualOcupacao;
  final String tipo;
  final double distancia;
  final double preco;
  late List<Incidente> incidentes;

  Estacionamento({required this.urlImagem,required this.nome, required this.endereco, required this.maximoOcupacao,required this.atualOcupacao,required this.tipo, required this.distancia, required this.preco});

  addIncidente(Incidente incidente){
    incidentes.add(incidente);
  }

  getIncidentes(){
    return incidentes;
  }

  getMaximo(){
    return atualOcupacao.toString();
  }

  getOcupacao(){
    return '$atualOcupacao / $maximoOcupacao';
  }
}


