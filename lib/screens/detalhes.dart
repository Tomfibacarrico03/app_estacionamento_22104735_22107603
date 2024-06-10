import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  late Future<List<Incidente>> incidentesFuture;

  @override
  void initState() {
    super.initState();
    incidentesFuture = _loadIncidentes();
  }
  Future<List<Incidente>> _loadIncidentes() async {
    try {
      // Initialize the database
      final incidentesDatabase = IncidentesDatabase();
      await incidentesDatabase.init();
      // Fetch the incidents for the given parque
      print("PARQUE ID: "+widget.parque.id);
      return await incidentesDatabase.getIncidentesByParqueId(widget.parque.id);
    } catch (e, stackTrace) {
      print('Error loading incidents: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0), // Aqui você pode definir a altura da AppBar
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF), // A cor de fundo da AppBar
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
              'Detalhes do Parque',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF00486A),
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
                letterSpacing: 2.0, // Espaçamento entre as letras
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
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0), // Adiciona algum padding ao redor do texto
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.lightGreen,
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          widget.parque.nome,
                          style: const TextStyle(
                            color: Color(0xFF00486A),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      child: Image.asset(widget.parque.imagem, fit: BoxFit.fitWidth),
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
                      future: incidentesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Erro ao carregar os incidentes'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('Nenhum incidente encontrado'));
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
                    // ... outros detalhes
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
                        builder: (context) => TabBarDemo(initialIndex: 3, registarIncidenteParque: null), // Índice da aba "Registrar Incidente"
                      ));
                    },
                    child: const Text(
                      'Registrar Incidente',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
                    ),
                  ),
                  FutureBuilder<List<Incidente>>(
                    future: incidentesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return Container();
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00486A),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListaIncidentesPage(
                                  incidentes: snapshot.data!,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Ver incidentes',
                            style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
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

