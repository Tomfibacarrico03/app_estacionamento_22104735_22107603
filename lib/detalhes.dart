import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'classes/estacionamento.dart';
import 'registarincidente.dart';
import 'ListaDeIncidentes.dart';



class DetalhesDoParque extends StatelessWidget {
  final Estacionamento parque;

  const DetalhesDoParque({Key? key, required this.parque}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            70.0), // Aqui você pode definir a altura da AppBar
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF00486A), // A cor de fundo da AppBar
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                  20.0), // Defina o raio para os cantos inferiores
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
                shadows: [
                  // Sombra para o texto
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  // Espaço ao redor do texto
                  decoration: BoxDecoration(
                    color: Colors.white, // Cor de fundo do retângulo
                    borderRadius:
                        BorderRadius.circular(20), // Bordas arredondadas
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
              backgroundColor:
                  Colors.white, // Torna o fundo da AppBar transparente
              elevation: 0, // Remove a sombra abaixo da AppBar
            ),
            // Inclua o logotipo da EMEL aqui, se necessário
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,30.0,0,10.0),
                    child: Image.network(parque.urlImagem),
                  ),
                  // Imagem do estacionamento
                  Center(
                      child: Text(' ${parque.nome}',
                          style: const TextStyle(
                            color: Color(0xFF00486A),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ))),
                  const Text(
                    'Morada',
                    style: TextStyle(
                        color: Color(0xFF00486A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    parque.endereco,
                    style: const TextStyle(
                        color: Color(0xff696969),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Distância',
                    style: TextStyle(
                        color: Color(0xFF00486A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${parque.distancia.toStringAsFixed(2)} km',
                    style: const TextStyle(
                        color: Color(0xff696969),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Preço:',
                    style: TextStyle(
                        color: Color(0xFF00486A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${parque.preco.toStringAsFixed(2)} €/Hora',
                    style: const TextStyle(
                        color: Color(0xff696969),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Ocupação',
                    style: TextStyle(
                        color: Color(0xFF00486A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    parque.ocupado,
                    style: const TextStyle(
                        color: Color(0xff696969),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Tipo de Parque',
                    style: TextStyle(
                        color: Color(0xFF00486A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    parque.tipo,
                    style: const TextStyle(
                        color: Color(0xff696969),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  // ... outros detalhes
                ],
              ),
            ),
            // Botões para ações
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Distribui os botões uniformemente na linha
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00486A), // Cor de fundo do botão
                    // Outras personalizações podem ser aplicadas aqui
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Incidentes()),);
                  },
                  child: const Text('Registrar Incidente',style: TextStyle(color: Color(0xFFFFFFFF),fontWeight: FontWeight.w600),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color(0xFF00486A), // Cor de fundo do botão
                    // Outros personalizações podem ser aplicadas aqui
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ListaIncidentesPage(incidentes: parque.incidentes)),);
                  },
                  child: const Text('Ver incidentes',style: TextStyle(color: Color(0xFFFFFFFF),fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
