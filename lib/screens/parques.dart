import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/estacionamento.dart';
import 'detalhes.dart';
import 'package:app_estacionamento_22104735_22107603/repository/estacionamento_repository.dart';

class ParquesPage extends StatefulWidget {
  @override
  Parques createState() => Parques();
}

class Parques extends State<ParquesPage> {
  @override
  Widget build(BuildContext context) {
    final parques = context.read<EstacionamentosRepository>();
    Future<List<Estacionamento>> listaDeParques = parques.getEstacionamentos();

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
      body: FutureBuilder<List<Estacionamento>>(
        future: listaDeParques,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os parques'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum parque encontrado'));
          } else {
            final parquesList = snapshot.data!;
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
                        MaterialPageRoute(builder: (context) => DetalhesDoParque(parque: estacionamento)),
                      );
                    },
                    child: ListTile(
                      title: Text(estacionamento.nome, style: const TextStyle(color: Color(0xFF00486A))),
                      subtitle: Text(estacionamento.dataAtualizada, style: const TextStyle(color: Color(0xFF00486A))),
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
                          const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF747F98)),
                        ],
                      ),
                      leading: Text('${estacionamento.distancia.toStringAsFixed(1)} km', style: const TextStyle(color: Color(0xFF00486A))),
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
