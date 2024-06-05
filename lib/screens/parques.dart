import 'dart:math';

import 'package:flutter/material.dart';
import '../classes/estacionamento.dart';
import 'detalhes.dart';
import '../globals.dart';
import 'package:app_estacionamento_22104735_22107603/repository/estacionamento_repository.dart';


class ParquesPage extends StatefulWidget {
  @override
  Parques createState() => Parques();
}

class Parques extends State<ParquesPage> {
  Parques({super.key});
  final EstacionamentosRepository estacionamentosRepository = EstacionamentosRepository();

  Future<void> loadData() async {
    try {
      listaDeParques = await estacionamentosRepository.fetchEstacionamentos();
      setState(() {});
    } catch (e) {
      listaDeParques = await estacionamentosRepository.loadEstacionamentosFromLocalStorage();
      setState(() {});
    }
  }
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
                'Lista de Parques',
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
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 6.0,
        radius: const Radius.circular(10),
        child: ListView.builder(
          itemCount: listaDeParques.length,
          itemBuilder: (BuildContext context, int index) {
            final estacionamento = listaDeParques[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DetalhesDoParque(parque: estacionamento)),
                );
              },
              child: ListTile(

                title: Text(estacionamento.nome, style: const TextStyle(color: Color(0xFF00486A))),
                subtitle: Text(estacionamento.endereco, style: const TextStyle(color: Color(0xFF00486A))),
                trailing:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      estacionamento.getOcupacao(),
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        color : getColorForStatus(estacionamento),
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
      ),
    );
  }


}


Color getColorForStatus(Estacionamento parque) {
  // Verifica se a ocupação atual é igual ao máximo de ocupação
  if (parque.atualOcupacao == parque.maximoOcupacao) {
    return Colors.red;
  }
  // Verifica se a ocupação atual é maior ou igual à metade da máxima ocupação
  else if (parque.atualOcupacao! >= parque.maximoOcupacao! / 2) {
    return Colors.orange;
  }
  // Verifica se a ocupação atual é menor que a metade da máxima ocupação
  else if (parque.atualOcupacao! < parque.maximoOcupacao! / 2) {
    return Colors.green;
  }
  // Retorna uma cor padrão para qualquer outro caso não contemplado acima
  else {
    return Colors.grey;
  }
}