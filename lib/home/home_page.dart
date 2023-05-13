import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menuLateral/menuLateral_screen.dart';

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
    final gridCards = GridView.count(
        // criando grid list com 3 colunas
        crossAxisCount: 3,
        padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        children: List.generate(
          _listaApps.length,
          (index) {
            return GestureDetector(
                child: Card(
                  elevation: 10.0,
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5.0),
                      child: Text(
                        _listaApps[index]["nome"],
                        textAlign: TextAlign.center,
                      )),
                ),
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    barrierColor: Colors.white24,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Column(
                          children: [
                            Icon(Icons.layers_outlined,
                                color: Colors.redAccent, size: 24.0),
                          ],
                        ),
                        content: Text(
                            'Você deseja abrir o app ${_listaApps[index]["nome"]}?'),
                        actions: [
                          TextButton(
                            child: Text("Sim"),
                            onPressed: () {
                              _tratarRota(_listaApps[index]["rota"]);
                            },
                          ),
                          TextButton(
                            child: Text("Não"),
                            onPressed: () {
                              _tratarRota('');
                            },
                          )
                        ],
                      );
                    },
                  );
                });
          },
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text('Apps Flutter'),
          centerTitle: true,
        ),
        drawer: MenuLateralScreen(),
        body: Container(
          child: gridCards,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(0.0),
          height: 50.0,
          color: Colors.white24,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.local_fire_department_outlined),
              Text(
                ' Developed by Leonardo Almeida',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ));
  }

  Future<Null> _tratarRota(String rota) async {
    if (rota != '' && rota != '/buscarGifs') {
      Navigator.pushNamed(context, rota);
    } else {
      Navigator.pop(context);
    }
    return null;
  }
}
