import 'package:app_estacionamento_22104735_22107603/classes/estacionamento.dart';
import 'package:app_estacionamento_22104735_22107603/data/parques_database.dart';
import 'package:flutter/material.dart';

import 'gravidade.dart';

class Incidente {
  final String id;
  final String estacionamentoId;
  final DateTime data;
  final TimeOfDay hora;
  final String descricao;
  final Gravidade gravidade;

  Incidente({
    required this.id,
    required this.estacionamentoId,
    required this.data,
    required this.hora,
    required this.descricao,
    required this.gravidade,
  });

  factory Incidente.fromDB(Map<String, dynamic> db) {
    return Incidente(
      id: db['id'],
      estacionamentoId: db['idParque'],
      data: DateTime.parse(db['data']),
      hora: TimeOfDay(
        hour: int.parse(db['hora'].split(':')[0]),
        minute: int.parse(db['hora'].split(':')[1]),
      ),
      descricao: db['descricao'],
      gravidade: Gravidade.values[db['gravidade']],
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'idParque': estacionamentoId,
      'data': data.toIso8601String(),
      'hora': '${hora.hour}:${hora.minute}',
      'descricao': descricao,
      'gravidade': gravidade.index,
    };
  }
}


