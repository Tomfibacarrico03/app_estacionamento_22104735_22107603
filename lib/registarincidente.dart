import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'parques.dart';
import 'classes/estacionamento.dart';
import 'classes/dropDown.dart';
import 'globals.dart';

// For input formatters if needed


class RegistarIncidentes extends StatefulWidget {
  const RegistarIncidentes({super.key});

  @override
  _formIncidente createState() => _formIncidente();

}

class _formIncidente extends State<RegistarIncidentes>{
  Estacionamento? estacionamentoSelecionado;
  final _formKey = GlobalKey<FormState>();
  final _formData = TextEditingController();
  final _formHora = TextEditingController();
  final _formDescricao = TextEditingController();
  final _formGravidade = TextEditingController();
  final _formFoto = TextEditingController();



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
                'Registar Incidente',
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
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            DropdownButtonFormField<Estacionamento>(
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.lightGreen, width: 3),
                ),
              ),
              value: estacionamentoSelecionado,
              hint: const Text("Escolha um estacionamento"),
              onChanged: (Estacionamento? newValue) {
                setState(() {
                  estacionamentoSelecionado = newValue;
                });
              },
              items: listaDeParques.map<DropdownMenuItem<Estacionamento>>((Estacionamento estacionamento) {
                return DropdownMenuItem<Estacionamento>(
                  value: estacionamento,
                  child: Text(estacionamento.endereco),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}





