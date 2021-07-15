import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listaApps = [
    {'nome': 'Buscar Gifs', 'rota': '/buscarGifs'},
    {'nome': 'Calculadora IMC', 'rota': '/calculadora'},
    {'nome': 'Contador de Pessoas', 'rota': '/contadorPessoas'},
    {'nome': 'Conversor de Moedas', 'rota': '/conversorMoedas'},
    {'nome': 'Lista de Tarefas', 'rota': '/listaTarefas'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Apps Flutter'),
          centerTitle: true,
        ),
        body: GridView.count(
          // criando grid com 3 colunas
          crossAxisCount: 3,
          children: List.generate(_listaApps.length, (index) {
            return Card(
                color: Colors.white,
                shadowColor: Colors.black,
                child: Center(
                  child: Text(
                    _listaApps[index]['nome'],
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ));
          }),
        ),
        persistentFooterButtons: [
          Container(
              width: 900,
              child: Center(
                child: Text(
                  'Criado por Leonardo Almeida',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      color: Color(0xFF162A49)),
                ),
              ))
        ]);
  }
}
