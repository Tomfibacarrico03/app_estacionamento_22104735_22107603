import 'package:flutter/material.dart';

class Incidentes extends StatelessWidget {
  const Incidentes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            centerTitle: true, // Centraliza o título
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Aumente o espaço vertical se necessário.
              child: Container(
                height: 35, // Altura fixa
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0), // Espaço ao redor do texto
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
      body: const Center(
        child: Text('Welcome to the incidentes screen!'),
      ),
    );
  }
}
