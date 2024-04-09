import 'package:flutter/material.dart';
import 'estacionamento.dart';
import '../globals.dart';

class DropdownSelector extends StatefulWidget {
  @override
  _DropdownSelectorState createState() => _DropdownSelectorState();
}

class _DropdownSelectorState extends State<DropdownSelector> {
  // Supondo que cada estacionamento tem um nome e você tem uma lista deles

  // Valor atualmente selecionado
  String? selectedEstacionamento;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedEstacionamento,
      hint: Text("Escolha um estacionamento"),
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedEstacionamento = newValue;
        });
      },
      items: listaDeParques.map<DropdownMenuItem<String>>((Estacionamento estacionamento) {
        return DropdownMenuItem<String>(
          value: estacionamento.nome, // Supondo que cada estacionamento tenha um atributo nome
          child: Text(estacionamento.nome),
        );
      }).toList(),
    );
  }
}
