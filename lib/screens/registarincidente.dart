import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../classes/incidente.dart';
import '../repository/estacionamento_repository.dart';
import '../classes/estacionamento.dart';
import 'detalhes.dart';
import 'package:intl/intl.dart';
import '../classes/gravidade.dart';
import '../data/parques_database.dart';

class RegistarIncidentes extends StatefulWidget {
  final Estacionamento? parque;

  const RegistarIncidentes({Key? key, this.parque}) : super(key: key);

  @override
  _FormIncidenteState createState() => _FormIncidenteState(parque: parque);
}

class _FormIncidenteState extends State<RegistarIncidentes> {
  final Estacionamento? parque;

  _FormIncidenteState({this.parque}) {
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
  Future<List<Estacionamento>>? listaDeParques;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    await _checkConnectivity();
    setState(() {
      listaDeParques = _getEstacionamentos();
    });
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<List<Estacionamento>> _getEstacionamentos() async {
    final parquesDB = context.read<PARQUESDatabase>();
    final parquesRepo = context.read<EstacionamentosRepository>();

    if (!_isConnected) {
      List<Estacionamento> localEstacionamentos =
          await parquesDB.getEstacionamentos();
      return localEstacionamentos;
    }

    List<Estacionamento> estacionamentos =
        await parquesRepo.getEstacionamentos();

    for (var estacionamento in estacionamentos) {
      var existingEstacionamento =
          await parquesDB.getEstacionamentoByNome(estacionamento.nome);
      if (existingEstacionamento != null) {
        await parquesDB.update(estacionamento);
      } else {
        await parquesDB.insert(estacionamento);
      }
    }

    return estacionamentos;
  }

  void verificarCamposEPreencherIncidente() {
    if (estacionamentoSelecionado == null || descricao.isEmpty) {
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
        gravidade:
            Gravidade.values[severity.toInt() - 1], // Ajusta gravidade aqui
      ));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Incidente Registrado"),
            content: const Text("O incidente foi registrado com sucesso."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetalhesDoParque(
                              parque: estacionamentoSelecionado!)));
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
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF00486A),
            hintColor: const Color(0xFF00486A),
            colorScheme: const ColorScheme.light(primary: Color(0xFF00486A)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null &&
            (pickedTime.hour < TimeOfDay.now().hour ||
                (pickedTime.hour == TimeOfDay.now().hour &&
                    pickedTime.minute <= TimeOfDay.now().minute)) ||
        selectedDate.day < DateTime.now().day) {
      setState(() {
        selectedTime = pickedTime!;
        _formHora.text = selectedTime.format(context);
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
            primaryColor: const Color(0xFF00486A),
            hintColor: const Color(0xFF00486A),
            colorScheme: const ColorScheme.light(primary: Color(0xFF00486A)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null &&
        (pickedDate.isBefore(DateTime.now()) ||
            pickedDate.isAtSameMomentAs(DateTime.now()))) {
      setState(() {
        selectedDate = pickedDate;
        _formData.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  String gravidadeText(double gravi) {
    switch (gravi.toInt()) {
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
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values = [1, 2, 3, 4, 5];

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
                'Registar Incidente',
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
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Estacionamento>>(
                future: listaDeParques,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Erro ao carregar os parques'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhum parque encontrado'));
                  } else {
                    return DropdownButtonFormField<Estacionamento>(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      decoration: InputDecoration(
                        label: const Text("Parque"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              color: Colors.lightGreen, width: 3),
                        ),
                      ),
                      value: estacionamentoSelecionado,
                      hint: const Text("Escolha um estacionamento"),
                      onChanged: (Estacionamento? newValue) {
                        setState(() {
                          estacionamentoSelecionado = newValue;
                        });
                      },
                      items: snapshot.data!
                          .map<DropdownMenuItem<Estacionamento>>(
                              (Estacionamento estacionamento) {
                        return DropdownMenuItem<Estacionamento>(
                          value: estacionamento,
                          child: Text(estacionamento.nome),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _formData,
                decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: 'Selecione a data do incidente',
                  icon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
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
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
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
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  icon: const Icon(Icons.description),
                ),
                onChanged: (value) {
                  setState(() {
                    descricao = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              Text('Gravidade', style: Theme.of(context).textTheme.subtitle1),
              const Text('Sem gravidade - Extremamente grave'),
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
                thumbColor: const Color(0xFF3ADF43),
                activeColor: const Color(0xFF00486A),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: values
                      .map(
                        (e) => Text(
                          e.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00486A),
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
