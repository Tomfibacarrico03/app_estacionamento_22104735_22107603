import 'package:flutter/material.dart';

class Incidentes extends StatelessWidget {
  const Incidentes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the incidentes screen!'),
      ),
    );
  }
}
