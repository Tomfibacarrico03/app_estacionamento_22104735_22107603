import 'package:flutter/material.dart';
import 'estacionamento.dart';

class DetalhesDoParque extends StatelessWidget {
  final Estacionamento parque;

  const DetalhesDoParque({Key? key, required this.parque}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Construa sua página de detalhes aqui
    return Scaffold(
      appBar: AppBar(
        title: Text(parque.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Endereço: ${parque.endereco}'),
            Text('Distância: ${parque.distancia.toStringAsFixed(2)} km'),
            Text('Status: ${parque.ocupado}'),
            // Adicione mais detalhes conforme necessário
          ],
        ),
      ),
    );
  }
}