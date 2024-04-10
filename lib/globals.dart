import 'package:flutter/material.dart';
import 'classes/estacionamento.dart';

final List<Estacionamento> listaDeParques = [
  Estacionamento(nome: 'Parque da Liberdade', endereco: 'Rua da Liberdade, Lisboa', maximoOcupacao: 20,atualOcupacao: 10, distancia: 1.5, imagem: 'assets/liberdade.jpeg', tipo: 'Superficial', preco: 0.0),
  Estacionamento(nome: 'Parque do Campo Grande', endereco: 'Rua do Campo Grande, Lisboa', maximoOcupacao: 30,atualOcupacao: 30, distancia: 1.5, imagem: 'assets/campoGrande.jpg', tipo: 'Coberto', preco: 0.0),
  Estacionamento(nome: 'Parque da Universidade Lusófona', endereco: 'Faculdade da Luso, Lisboa', maximoOcupacao: 50,atualOcupacao: 19, distancia: 1.5, imagem: 'assets/luso.jpg', tipo: 'Coberto', preco: 0.0),
  Estacionamento(nome: 'Parque da Universidade de Ciências', endereco: 'Faculdade de Ciências, Lisboa', maximoOcupacao: 40,atualOcupacao: 30, distancia: 1.5, imagem: 'assets/ciencias.jpg', tipo: 'Superficial', preco: 0.0),
  Estacionamento(nome: 'Parque da Alameda', endereco: 'Alameda do Técnico, Lisboa', maximoOcupacao: 60,atualOcupacao: 55, distancia: 1.5, imagem: 'assets/alameda.jpeg', tipo: 'Coberto', preco: 0.0),
  Estacionamento(nome: 'Parque da Pizza', endereco: 'Rua da Mr.Pizza, Lisboa', maximoOcupacao: 70,atualOcupacao: 34, distancia: 1.5, imagem: 'assets/pizza.jpeg', tipo: 'Superficial', preco: 0.0),
  Estacionamento(nome: 'Parque da Ponte', endereco: 'Ponte 25 de Abril, Lisboa', maximoOcupacao: 90,atualOcupacao: 10, distancia: 1.5, imagem: 'assets/ponte.jpeg', tipo: 'Coberto', preco: 0.0),
  Estacionamento(nome: 'Parque do restaurante', endereco: 'Restaurante do Jardim, Lisboa', maximoOcupacao: 80,atualOcupacao: 10, distancia: 1.5, imagem: 'assets/restaurante.jpg', tipo: 'Superficial', preco: 0.0),
];
