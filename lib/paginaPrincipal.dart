class PaginaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo!'),
        centerTitle: true,
        backgroundColor: Colors.blue, // Cor do tema da EMEL
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListaParquesProximos(),
            IncidentesTempo(),
            LotacaoMedia(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa de Parques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista de Parques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Registrar Incidente',
          ),
        ],
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}


class ListaParquesProximos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Substitua com seus próprios dados
    final parques = [
      {'nome': 'Estacionamento Alto do Parque', 'distancia': '1.34 KM'},
      {'nome': 'Estacionamento Calçada do Combro', 'distancia': '5.42 KM'},
      {'nome': 'Parking garage Chão do Loureiro', 'distancia': '7.87 KM'},
    ];

    return Column(
      children: parques.map((parque) {
        return Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text(parque['nome'] ?? ''),
            subtitle: Text(parque['distancia'] ?? ''),
          ),
        );
      }).toList(),
    );
  }
}

class IncidentesTempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Substitua com seus próprios dados
    var data = [
      new Incidentes('Jan', 5),
      new Incidentes('Fev', 25),
      new Incidentes('Mar', 100),
      new Incidentes('Abr', 75),
    ];

    var series = [
      new charts.Series<Incidentes, String>(
        id: 'Incidentes',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Incidentes incidentes, _) => incidentes.mes,
        measureFn: (Incidentes incidentes, _) => incidentes.numero,
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                'Incidentes ao longo do tempo',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: chart,
              ),
              Text('Abordamos com sucesso os incidentes principais, reduzindo significativamente sua ocorrência ao longo do tempo! Obrigado'),
            ],
          ),
        ),
      ),
    );
  }
}

class LotacaoMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // A implementação do indicador é um placeholder
    // Substitua com a implementação correta
    return Container(
      height: 100,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_car, color: Colors.red),
          SizedBox(width: 10),
          Icon(Icons.directions_car, color: Colors.yellow),
          SizedBox(width: 10),
          Icon(Icons.directions_car, color: Colors.green),
        ],
      ),
    );
  }
}

class Incidentes {
  Incidentes (String s, int i);

  get mes => null;

  get numero => null;
