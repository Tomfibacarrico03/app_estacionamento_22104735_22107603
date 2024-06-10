import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/estacionamento.dart';
import '../classes/incidente.dart';
import '../data/incidentes_database.dart';
import '../main.dart';
import 'registarincidente.dart';
import 'ListaDeIncidentes.dart';

class DetalhesDoParque extends StatefulWidget {
  final Estacionamento parque;

  const DetalhesDoParque({Key? key, required this.parque}) : super(key: key);

  @override
  _DetalhesDoParqueState createState() => _DetalhesDoParqueState();
}

class _DetalhesDoParqueState extends State<DetalhesDoParque> {
  late Future<List<Incidente>> _futureIncidentes;

  @override
  void initState() {
    super.initState();
    _futureIncidentes = _fetchIncidentes();
  }

  Future<List<Incidente>> _fetchIncidentes() async {
    final incidentesDatabase = IncidentesDatabase();
    await incidentesDatabase.init();
    return await incidentesDatabase.getIncidentesByParqueId(widget.parque.id);
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppBar(
                centerTitle: true, // Centraliza o título
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      child: Image.asset(widget.parque.imagem, fit: BoxFit.fitWidth),
                    ),
                    Center(
                      child: Text(
                        widget.parque.nome,
                        style: const TextStyle(
                          color: Color(0xFF00486A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'Morada',
                      style: TextStyle(
                          color: Color(0xFF00486A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.parque.endereco,
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
                      '${widget.parque.distancia.toStringAsFixed(2)} km',
                      style: const TextStyle(
                          color: Color(0xff696969),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Preço',
                      style: TextStyle(
                          color: Color(0xFF00486A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.parque.tarifa,
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
                      widget.parque.getOcupacao(),
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
                      widget.parque.tipo,
                      style: const TextStyle(
                          color: Color(0xff696969),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Número de Incidentes',
                      style: TextStyle(
                          color: Color(0xFF00486A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<List<Incidente>>(
                      future: _futureIncidentes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Erro ao carregar incidentes');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Text('Nenhum incidente registrado');
                        } else {
                          return Text(
                            snapshot.data!.length.toString(),
                            style: const TextStyle(
                                color: Color(0xff696969),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00486A),
                    ),
                    onPressed: () {
                      // Volta para a tela principal
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      // Abre a tela principal com o índice da aba desejada
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const TabBarDemo(initialIndex: 3, registarIncidenteParque: null), // Índice da aba "Registrar Incidente"
                      ));
                    },
                    child: const Text(
                      'Registrar Incidente',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
                    ),
                  ),
                    FutureBuilder<List<Incidente>>(
                      future: _futureIncidentes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Erro ao carregar incidentes');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const SizedBox.shrink(); // No incidents, return an empty box
                        } else {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00486A),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListaIncidentesPage(incidentes: snapshot.data!),
                                ),
                              );
                            },
                            child: const Text(
                              'Ver incidentes',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
