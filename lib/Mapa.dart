import 'package:flutter/material.dart';

class Mapa extends StatelessWidget {
  const Mapa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // A imagem de fundo que cobre toda a tela
          Positioned.fill(
            child: Image.asset(
              'assets/mapa.png',
              fit: BoxFit.cover,
            ),
          ),
          // O conteúdo do body
          Positioned.fill(
            top: MediaQuery.of(context).padding.top + kToolbarHeight, // Deixe espaço para a AppBar
            child: const Column(
            ),
          ),
          // A AppBar sobreposta
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
                centerTitle: true, // Centraliza o título
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0), // Aumente o espaço vertical se necessário.
                  child: Container(
                    height: 35,  // Altura fixa
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
                      'Mapa de Parques',
                      style: TextStyle(
                        color: Color(0xFF00486A), // Cor do texto
                        fontSize: 25, // Tamanho do texto
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent, // Torna o fundo da AppBar transparente
                elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

}

