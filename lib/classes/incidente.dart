import 'package:flutter/material.dart';

class Incidente {
  final DateTime data;
  final TimeOfDay hora;
  final String descricao;
  final int gravidade;

  Incidente({required this.data,required this.hora,required this.descricao,required this.gravidade});

}


