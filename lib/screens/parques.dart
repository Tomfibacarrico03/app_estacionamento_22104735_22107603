import 'dart:async';
import 'dart:math';
import 'package:app_estacionamento_22104735_22107603/data/parques_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../classes/estacionamento.dart';
import 'detalhes.dart';
import 'package:app_estacionamento_22104735_22107603/repository/estacionamento_repository.dart';

class ParquesPage extends StatefulWidget {
  @override
  Parques createState() => Parques();
}

class Parques extends State<ParquesPage> {
  Future<List<Estacionamento>>? listaDeParques;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    await _checkConnectivity();
    setState(() {
      listaDeParques = _getEstacionamentos();
    });
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<List<Estacionamento>> _getEstacionamentos() async {
    final parquesDB = context.read<PARQUESDatabase>();
    final parquesRepo = context.read<EstacionamentosRepository>();

    if (!_isConnected) {
      List<Estacionamento> localEstacionamentos = await parquesDB.getEstacionamentos();
      return localEstacionamentos;
    }

    List<Estacionamento> estacionamentos = await parquesRepo.getEstacionamentos();

    for (var estacionamento in estacionamentos) {
      var existingEstacionamento = await parquesDB.getEstacionamentoById(estacionamento.id);
      if (existingEstacionamento != null) {
        await parquesDB.update(estacionamento);
      } else {
        await parquesDB.insert(estacionamento);
      }    }

    return estacionamentos;
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.lightGreen,
                  width: 2.0,
                ),
              ),
              child: const Text(
                'Lista de Parques',
                style: TextStyle(
                  color: Color(0xFF00486A),
                  fontSize: 25,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: listaDeParques == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Estacionamento>>(
        future: listaDeParques,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Center(
                child: Text(_isConnected
                    ? 'Erro ao carregar os parques'
                    : 'No internet connection'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum parque encontrado'));
          } else {
            final parquesList = snapshot.data!;
            print("Number of parques: ${parquesList.length}");
            return Scrollbar(
              thumbVisibility: true,
              thickness: 6.0,
              radius: const Radius.circular(10),
              child: ListView.builder(
                itemCount: parquesList.length,
                itemBuilder: (BuildContext context, int index) {
                  final estacionamento = parquesList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                DetalhesDoParque(parque: estacionamento)),
                      );
                    },
                    child: ListTile(
                      title: Text(estacionamento.nome,
                          style: const TextStyle(color: Color(0xFF00486A))),
                      subtitle: Text(estacionamento.dataAtualizada,
                          style: const TextStyle(color: Color(0xFF00486A))),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            estacionamento.getOcupacao(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getColorForStatus(estacionamento),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              color: Color(0xFF747F98)),
                        ],
                      ),
                      leading: Text(
                          '${estacionamento.distancia.toStringAsFixed(1)} km',
                          style:
                          const TextStyle(color: Color(0xFF00486A))),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

Color getColorForStatus(Estacionamento parque) {
  if (parque.atualOcupacao == parque.maximoOcupacao) {
    return Colors.red;
  } else if (parque.atualOcupacao! >= parque.maximoOcupacao! / 2) {
    return Colors.orange;
  } else if (parque.atualOcupacao! < parque.maximoOcupacao! / 2) {
    return Colors.green;
  } else {
    return Colors.grey;
  }
}
