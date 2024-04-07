import 'dart:math';

import 'package:flutter/material.dart';
import 'classes/estacionamento.dart';
import 'detalhes.dart';

final List<Estacionamento> listaDeParques = [
  Estacionamento(nome: 'Parque da Liberdade', endereco: 'Rua da Liberdade, Lisboa', ocupado: 'Ocupado', distancia: 1.5, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque do Comércio', endereco: 'Praça do Comércio, Lisboa', ocupado: 'Livre', distancia: 2.0, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque do Comércio', endereco: 'Praça do Comércio, Lisboa', ocupado: 'Parcialmente', distancia: 2.0, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque da Liberdade', endereco: 'Rua da Liberdade, Lisboa', ocupado: 'Livre', distancia: 1.5, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque do Comércio', endereco: 'Praça do Comércio, Lisboa', ocupado: 'Ocupado', distancia: 2.0, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque do Comércio', endereco: 'Praça do Comércio, Lisboa', ocupado: 'Livre', distancia: 2.0, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque da Liberdade', endereco: 'Rua da Liberdade, Lisboa', ocupado: 'Parcialmente', distancia: 1.5, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque do Comércio', endereco: 'Praça do Comércio, Lisboa', ocupado: 'Livre', distancia: 2.0, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque do Comércio', endereco: 'Praça do Comércio, Lisboa', ocupado: 'Ocupado', distancia: 2.0, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque da Liberdade', endereco: 'Rua da Liberdade, Lisboa', ocupado: 'Parcialmente', distancia: 1.5, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque do Comércio', endereco: 'Praça do Comércio, Lisboa', ocupado: 'Ocupado', distancia: 2.0, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),
  Estacionamento(nome: 'Parque do Comércio', endereco: 'Praça do Comércio, Lisboa', ocupado: 'Parcialmente', distancia: 2.0, urlImagem: 'https://source.unsplash.com/random/1900x900/?parking', tipo: '', preco: 0.0),

];


class Parques extends StatelessWidget {
  const Parques({super.key});

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
                'Lista de Parques',
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
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 6.0,
        radius: const Radius.circular(10),
        child: ListView.builder(
          itemCount: listaDeParques.length,
          itemBuilder: (BuildContext context, int index) {
            final estacionamento = listaDeParques[index];
            return InkWell(
              onTap: () {
                // Navegar para a página de detalhes do estacionamento
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DetalhesDoParque(parque: estacionamento)),
                );
              },
              child: ListTile(
                title: Text(estacionamento.nome, style: const TextStyle(color: Color(0xFF00486A))),
                subtitle: Text(estacionamento.endereco, style: const TextStyle(color: Color(0xFF00486A))),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      estacionamento.ocupado,
                      style: TextStyle(
                        color: getColorForStatus(estacionamento.ocupado), // Função para definir a cor com base no estado de ocupação
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF747F98)),
                  ],
                ),
                leading: Text('${estacionamento.distancia.toStringAsFixed(1)} km', style: const TextStyle(color: Color(0xFF00486A))),
              ),
            );
          },
        ),
      ),

    );
  }
}


Color getColorForStatus(String status) {
  switch (status) {
    case 'Ocupado':
      return Colors.red;
    case 'Parcialmente':
      return Colors.orange;
    case 'Livre':
      return Colors.green;
    default:
      return Colors.grey; // Cor padrão para status desconhecido
  }
}