import 'package:flutter/material.dart';

import 'gravidade.dart';

class Incidente {
  final DateTime data;
  final TimeOfDay hora;
  final String descricao;
  final Gravidade gravidade;

  Incidente({required this.data,required this.hora,required this.descricao,required this.gravidade});

}


