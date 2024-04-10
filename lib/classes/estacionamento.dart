import 'incidente.dart';
import 'package:flutter/material.dart';

class Estacionamento {
  final String imagem;
  final String nome;
  final String endereco;
  final int? maximoOcupacao;
  final int? atualOcupacao;
  final String tipo;
  final double distancia;
  final double preco;
  List<Incidente> incidentes = [];

  Estacionamento(
      {required this.imagem,
      required this.nome,
      required this.endereco,
      required this.maximoOcupacao,
      required this.atualOcupacao,
      required this.tipo,
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
}
