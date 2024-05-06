import 'package:app_estacionamento_22104735_22107603/screens/detalhes.dart';
import 'package:flutter/material.dart';
import 'package:app_estacionamento_22104735_22107603/globals.dart';
import '../classes/estacionamento.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final TextEditingController parque = TextEditingController();
  List<Estacionamento> filteredList = [];
  bool showSearchResults = false;
  Estacionamento? parkWithMostIncidents;

  @override
  void initState() {
    super.initState();
    findParkWithMostIncidents();
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      filteredList = [];
      showSearchResults = false;
    } else {
      filteredList = listaDeParques
          .where(
              (park) => park.nome.toLowerCase().contains(query.toLowerCase()))
          .toList();
      showSearchResults = true;
    }
    setState(() {});
  }

  void findParkWithMostIncidents() {
    parkWithMostIncidents = listaDeParques.reduce((current, next) {
      return (current.incidentes.length > next.incidentes.length)
          ? current
          : next;
    });
    // Check if the highest incident count is 0
    if (parkWithMostIncidents!.incidentes.isEmpty) {
      parkWithMostIncidents = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.lightGreen, width: 2.0),
                    ),
                    child: const Text('Dashboard',
                        style: TextStyle(color: Color(0xFF00486A), fontSize: 25)),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              const SizedBox(height: 10),
              if (parkWithMostIncidents != null)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Cantos arredondados
                    side: const BorderSide(color: Colors.lightGreen, width: 2.0), // Cor e largura da borda
                  ),
                  child: ListTile(
                    tileColor: Colors.white, // Background color of the ListTile
                    leading: const Icon(Icons.warning,
                        color: Color(0xFF00486A), // Cor do texto
                        size: 40), // Leading icon with a warning sign
                    title: Text(
                      '${parkWithMostIncidents!.nome} é o parque com mais incidentes',
                      style: const TextStyle(
                        color: Color(0xFF00486A), // Cor do texto
                        fontWeight: FontWeight.bold, // Bold text for emphasis
                        fontSize: 16.5, // Font size for title
                      ),
                    ),
                  ),
                ),
              if (parkWithMostIncidents == null)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Sem registo de incidentes 🥳",
                    style: TextStyle(
                      color: Color(0xFF00486A), // Cor do texto
                      fontWeight: FontWeight.bold, // Bold text for emphasis
                      fontSize: 16.5, // Font size for title
                    ),),
                ),
              const SizedBox(height: 10),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Cantos arredondados
                  side: const BorderSide(color: Colors.lightGreen, width: 6.0), // Cor e largura da borda
                ),
                color : const Color(0xFF00486A),

                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  // Background color of the ListTile
                  // Leading icon with a warning sign
                  title: const Text('Parque mais perto: ',
                    style: TextStyle(
                      color: Colors.white, // Cor do texto
                      fontWeight: FontWeight.bold, // Bold text for emphasis
                      fontSize: 14, // Font size for title
                    ),
                  ),
                  subtitle: Text('${listaDeParques[1].nome} -> ${listaDeParques[1].distancia} km' ,
                    style: const TextStyle(
                      color: Colors.white, // Cor do texto
                      fontWeight: FontWeight.bold, // Bold text for emphasis
                      fontSize: 17, // Font size for title
                    ),
                  ),

                ),
              ),
              const SizedBox(height: 10),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Cantos arredondados
                  side: const BorderSide(color: Colors.lightGreen, width: 2.0), // Bordas coloridas e definidas
                ),
                color : const Color(0xFFFFFFFF),
                elevation: 5, // Elevação para sombra
                child: Column(

                  mainAxisSize: MainAxisSize.min, // Tamanho mínimo baseado no conteúdo
                  children: <Widget>[
                    Container(
                      color: Colors.white, // Set the background color to black
                      child:  const ListTile(
                        leading: Icon(Icons.pin_drop, size: 30, color: Color(0xFF00486A), // Cor do texto
                        ),
                        title: Text('Localização', style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF00486A) )),
                        subtitle: Text('Local onde se encontra', style: TextStyle(color: Color(0xFF00486A) )),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      height: 275.0,
                      child: Image.asset(
                        'assets/mapa.png',
                        width: 375.0,// Substitua com seu caminho de imagem
                        fit: BoxFit.fitWidth, // Cobrir o espaço disponível
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
