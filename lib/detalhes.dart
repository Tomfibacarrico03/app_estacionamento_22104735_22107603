import 'package:flutter/material.dart';
import 'classes/estacionamento.dart';

class DetalhesDoParque extends StatelessWidget {
  final Estacionamento parque;

  const DetalhesDoParque({Key? key, required this.parque}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // Aqui você pode definir a altura da AppBar
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF00486A), // A cor de fundo da AppBar
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), // Defina o raio para os cantos inferiores
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Deixa o AppBar transparente
            elevation: 0, // Remove a sombra
            centerTitle: true,
            title: const Text(
              'PARK4U',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
                letterSpacing: 2.0, // Espaçamento entre as letras
                shadows: [ // Sombra para o texto
                  Shadow(
                    offset: Offset(2.0, 1.0),
                    blurRadius: 6.0,
                    color: Color(0xFF3ADF43),
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBar(
              centerTitle: true, // Centraliza o título
              automaticallyImplyLeading: false,
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
                    'Detalhes do parque',
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
            // Inclua o logotipo da EMEL aqui, se necessário
            Card(
              elevation: 4.0, // Elevação da sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Bordas arredondadas do card
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Image.network(parque.urlImagem), // Imagem do estacionamento
                    Text('Morada: ${parque.endereco}'),
                    Text('Distância: ${parque.distancia.toStringAsFixed(2)} km'),
                    Text('Preço: ${parque.preco.toStringAsFixed(2)} €/Hora'),
                    Text('Ocupação: ${parque.ocupado}'),
                    Text('Tipo de Parque: ${parque.tipo}'),
                    // ... outros detalhes
                  ],
                ),
              ),
            ),
            // Botões para ações
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribui os botões uniformemente na linha
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Cor de fundo do botão
                    // Outras personalizações podem ser aplicadas aqui
                  ),
                  onPressed: () {
                    // Ação para registrar incidente
                  },
                  child: Text('Registrar Incidente'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Cor de fundo do botão
                    // Outros personalizações podem ser aplicadas aqui
                  ),
                  onPressed: () {
                    // Ação para avaliar o parque
                  },
                  child: Text('Avaliar o parque'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}