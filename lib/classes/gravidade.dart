import 'dart:ui';

import 'package:flutter/material.dart';

enum Gravidade {
  SemGravidade,
  PoucoGrave,
  Grave,
  MuitoGrave,
  ExtremamenteGrave
}

Color getSeverityColor(Gravidade severity) {
  if (severity == Gravidade.SemGravidade) {
    return Colors.green;
  } else if (severity == Gravidade.ExtremamenteGrave) {
    return Colors.red;
  } else {
    return Colors.orange;
  }
}


  String gravidadeText(double value) {
    switch (value.toInt()) {
      case 1:
        return 'Sem Gravidade';
      case 2:
        return 'Pouco Grave';
      case 3:
        return 'Grave';
      case 4:
        return 'Muito Grave';
      case 5:
        return 'Extremamente Grave';
      default:
        return '';
    }
  }

  Gravidade getGravidade(double value) {
    switch (value.toInt()) {
      case 1:
        return Gravidade.SemGravidade;
      case 2:
        return Gravidade.PoucoGrave;
      case 3:
        return Gravidade.Grave;
      case 4:
        return Gravidade.MuitoGrave;
      case 5:
        return Gravidade.ExtremamenteGrave;
      default:
        return Gravidade.SemGravidade;
    }
}
