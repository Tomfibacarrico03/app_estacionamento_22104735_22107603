import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'classes/estacionamento.dart';
import 'classes/incidente.dart';
import 'parques.dart';


class ListaIncidentesPage extends StatelessWidget {
  final List<Incidente> incidentes;

  const ListaIncidentesPage({Key? key, required this.incidentes}):super(key: key);

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
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 6.0,
        radius: const Radius.circular(10),
        child: ListView.builder(
          itemCount: incidentes.length,
          itemBuilder: (BuildContext context, int index) {
            final incidente = incidentes[index];
            return InkWell(
              onTap: () {
                //Navigator.of(context).push(
                //  MaterialPageRoute(builder: (context) => DetalhesDoParque(parque: estacionamento)),
                //);
              },
              child: ListTile(

                title: Text(incidente.data.toString(), style: const TextStyle(color: Color(0xFF00486A))),
                subtitle: Text(incidente.hora.toString(), style: const TextStyle(color: Color(0xFF00486A))),
                trailing:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      incidente.gravidade.toString(),
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF747F98)),
                  ],
                ),
                leading: Text(incidente.descricao, style: const TextStyle(color: Color(0xFF00486A))),
              ),
            );
          },
        ),
      ),
    );
  }
}
