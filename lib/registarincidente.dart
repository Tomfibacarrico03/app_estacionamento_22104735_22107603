import 'package:app_estacionamento_22104735_22107603/classes/estacionamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'parques.dart';
import 'classes/estacionamento.dart';

// For input formatters if needed

class Incidentes extends StatelessWidget {
  const Incidentes({super.key});


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          centerTitle: true, // Centraliza o título
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            // Aumente o espaço vertical se necessário.
            child: Container(
              height: 35,
              // Altura fixa
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              // Espaço ao redor do texto
              decoration: BoxDecoration(
                color: Colors.white, // Cor de fundo do retângulo
                borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                border: Border.all(
                  color: Colors.lightGreen, // A cor das bordas
                  width: 2.0, // A largura da borda
                ),

              ),
              child: const Text(
                'Registar Incidente',
                style: TextStyle(
                  color: Color(0xFF00486A), // Cor do texto
                  fontSize: 25, // Tamanho do texto
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white, // Torna o fundo da AppBar transparente
          elevation: 0, // Remove a sombra abaixo da AppBar
        ),
      ),


    );
  }
}





