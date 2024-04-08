import 'incidente.dart';
class Estacionamento {
  final String urlImagem;
  final String nome;
  final String endereco;
  final String ocupado;
  final String tipo;
  final double distancia;
  final double preco;
  late List<Incidente> incidentes;

  Estacionamento({required this.urlImagem,required this.nome, required this.endereco, required this.ocupado,required this.tipo, required this.distancia, required this.preco});

  addIncidente(Incidente incidente){
    incidentes.add(incidente);
  }

  getIncidentes(){
    return incidentes;
  }
}


