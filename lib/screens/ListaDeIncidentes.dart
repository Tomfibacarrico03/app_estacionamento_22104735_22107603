import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../classes/estacionamento.dart';
import '../classes/gravidade.dart';
import '../classes/incidente.dart';
import 'parques.dart';
import 'package:intl/intl.dart'; // Make sure to import intl package for DateFormat


class ListaIncidentesPage extends StatelessWidget {
  final List<Incidente> incidentes;

  const ListaIncidentesPage({Key? key, required this.incidentes}):super(key: key);

  @override
  Widget build(BuildContext context) {
    String gravidadeText(double gravi) {
      switch (gravi) {
        case 1:
          return "Sem gravidade";
        case 2:
          return "Pouco grave";
        case 3:
          return "Grave";
        case 4:
          return "Muito grave";
        case 5:
          return "Extremamente grave";
        default:
          return "";
      }
    }
    void showIncidenteDetailsBottomSheet(BuildContext context, Incidente incidente) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text('Data: ${DateFormat('dd/MM/yyyy').format(incidente.data)}'),
                ),
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text('Hora: ${incidente.hora.hour.toString().padLeft(2, '0')}:${incidente.hora.minute.toString().padLeft(2, '0')}'),
                ),
                ListTile(
                  leading: const Icon(Icons.warning),
                  title: Text('${(incidente.gravidade)}'),
                  trailing: Icon(
                    Icons.circle,
                    color: getSeverityColor(incidente.gravidade),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: Text('Descrição: ${incidente.descricao}'),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            70.0), // Aqui você pode definir a altura da AppBar
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF), // A cor de fundo da AppBar
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
              'Incidentes do parque',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF00486A),
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
          ),
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 6.0,
        radius: const Radius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: incidentes.length,
                itemBuilder: (BuildContext context, int index) {
                  final incidente = incidentes[index];
                  return InkWell( // Use InkWell for tap effects
                    onTap: () => showIncidenteDetailsBottomSheet(context, incidente),
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Adjust padding as needed
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,// Align items to the start of the row
                        children: <Widget>[
                          Icon(
                            Icons.warning, // Your leading icon
                            color: getSeverityColor(incidente.gravidade),
                          ),
                          const SizedBox(width: 16.0), // Spacing between icon and text

                                Text(
                                  DateFormat('dd/MM/yyyy').format(incidente.data),
                                  style: const TextStyle(
                                    color: Color(0xFF00486A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0), // Spacing between texts
                                Text(
                                  "Hora: ${incidente.hora.hour.toString().padLeft(2, '0')}:${incidente.hora.minute.toString().padLeft(2, '0')}",
                                  style: const TextStyle(color: Color(0xFF00486A)),
                                ),

                          Icon(
                            Icons.arrow_forward_ios_sharp, // Trailing icon aligned to the left
                            color: Theme.of(context).iconTheme.color, // Use the theme's icon color
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
