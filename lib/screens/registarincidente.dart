import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../classes/incidente.dart';
import 'detalhes.dart';
import 'parques.dart';
import '../classes/estacionamento.dart';
import '../classes/dropDown.dart';
import 'package:intl/intl.dart';
import '../globals.dart';

// For input formatters if needed

class RegistarIncidentes extends StatefulWidget {
  final Estacionamento? parque;

  const RegistarIncidentes({super.key, this.parque});

  @override
  _formIncidente createState() => _formIncidente(parque: parque);
}

class _formIncidente extends State<RegistarIncidentes> {
  final Estacionamento? parque;
  _formIncidente({this.parque}) {
    estacionamentoSelecionado = this.parque;
  }
  Estacionamento? estacionamentoSelecionado;
  final _formData = TextEditingController();
  final _formHora = TextEditingController();
  final _formDescricao = TextEditingController();
  String descricao = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  double severity = 1;

  void verificarCamposEPreencherIncidente() {
    // Verifica se algum dos campos está vazio ou não selecionado
    if (estacionamentoSelecionado == null || descricao.isEmpty) {
      // Mostra um popup informando que todos os campos são obrigatórios
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Campos obrigatórios"),
            content: const Text(
                "Por favor, preencha todos os campos para registrar o incidente."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      estacionamentoSelecionado!.addIncidente(Incidente(
        data: selectedDate,
        hora: selectedTime,
        descricao: descricao,
        gravidade: severity,
      ));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Incidente Registado"),
            content: const Text("O incidente foi registado com sucesso."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog first
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesDoParque(parque: estacionamentoSelecionado!)));

                },
              ),
            ],
          );
        },
      );


    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      barrierLabel: "Selecione as horas",
      context: context,
      initialTime:
          TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                const Color(0xFF00486A), // Cor de fundo da barra de cabeçalho
            hintColor: const Color(0xFF00486A), // Cor do botão 'OK'
            colorScheme: const ColorScheme.light(
                primary:
                    Color(0xFF00486A)), // Cor de fundo do header e botão 'OK'
            buttonTheme: const ButtonThemeData(
                textTheme:
                    ButtonTextTheme.primary), // Cor do texto do botão 'OK'
            dialogBackgroundColor: Colors.white, // Cor de fundo do DatePicker
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _formHora.text = DateFormat('HH:mm').format(selectedDate);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                const Color(0xFF00486A), // Cor de fundo da barra de cabeçalho
            hintColor: const Color(0xFF00486A), // Cor do botão 'OK'
            colorScheme: const ColorScheme.light(
                primary:
                    Color(0xFF00486A)), // Cor de fundo do header e botão 'OK'
            buttonTheme: const ButtonThemeData(
                textTheme:
                    ButtonTextTheme.primary), // Cor do texto do botão 'OK'
            dialogBackgroundColor: Colors.white, // Cor de fundo do DatePicker
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _formData.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final values = [1, 2, 3, 4, 5];

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<Estacionamento>(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                decoration: InputDecoration(
                  label: const Text("Parque"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide:
                        const BorderSide(color: Colors.lightGreen, width: 3),
                  ),
                ),
                value: estacionamentoSelecionado,
                hint: const Text("Escolha um estacionamento"),
                onChanged: (Estacionamento? newValue) {
                  setState(() {
                    estacionamentoSelecionado = newValue;
                  });
                },
                items: listaDeParques.map<DropdownMenuItem<Estacionamento>>(
                    (Estacionamento estacionamento) {
                  return DropdownMenuItem<Estacionamento>(
                    value: estacionamento,
                    child: Text(estacionamento.nome),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _formData,
                decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: 'Selecione a data do incidente',
                  icon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    // Bordas do campo de texto
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  filled: true, // Preenche o campo de texto com uma cor
                  fillColor: Colors.transparent, // Cor de preenchimento
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _formHora,
                decoration: InputDecoration(
                  labelText: 'Hora',
                  hintText: 'Selecione a hora do incidente',
                  icon: const Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    // Bordas do campo de texto
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  filled: true, // Preenche o campo de texto com uma cor
                  fillColor: Colors.transparent, // Cor de preenchimento
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _formDescricao,
                decoration: InputDecoration(
                    hintText: "Descrição",
                    border: OutlineInputBorder(
                      // Bordas do campo de texto
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    icon: const Icon(Icons.description)),
                onChanged: (value) {
                  setState(() {
                    descricao = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              Text('Gravidade', style: Theme.of(context).textTheme.subtitle1),
              Slider(
                value: severity,
                min: 1,
                max: 5,
                divisions: 4,
                label: gravidadeText(severity),
                onChanged: (double value) {
                  setState(() {
                    severity = value;
                  });
                },
                thumbColor: Colors.lightGreen,
                activeColor: const Color(0xFF00486A),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: values
                      .map(
                        (e) => Text(
                          e.toString(), // Aqui você pode usar sua função gravidadeText para converter o valor, se necessário
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF00486A), // Cor de fundo do botão
                  // Outras personalizações podem ser aplicadas aqui
                ),
                onPressed: verificarCamposEPreencherIncidente,
                child: const Text(
                  'Registrar Incidente',
                  style: TextStyle(
                      color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
