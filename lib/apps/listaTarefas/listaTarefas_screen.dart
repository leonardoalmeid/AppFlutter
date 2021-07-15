import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListaTarefasScreen extends StatefulWidget {
  @override
  ListaTarefasScreenState createState() => ListaTarefasScreenState();
}

class ListaTarefasScreenState extends State<ListaTarefasScreen> {
  final _toDoController = TextEditingController();
  List<dynamic> _toDoList = [];
  Map<String, dynamic> _lastRemove = Map();
  int _lastRemovePos = 0;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addToDo() {
    // O setState atualiza o conteudo da tela após adicionar
    setState(() {
      final Map<String, dynamic> newToDo = new Map<String, dynamic>();
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);

      _saveData();

      // add snackbar
      final snackSucesso = SnackBar(
        content: Text("Tarefa adicionada com sucesso!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackSucesso);
    });
  }

  void _carregar() {
    _readData().then((value) => {
          setState(() {
            _toDoList = json.decode(value);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de tarefas"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(
                children: <Widget>[
                  // O expanded faz com que o textFied ocupe um tamanho max
                  Expanded(
                      child: TextField(
                          controller: _toDoController,
                          decoration: InputDecoration(
                              labelText: "Nova Tarefa",
                              labelStyle:
                                  TextStyle(color: Colors.blueAccent)))),
                  // Nova botão onPress
                  ElevatedButton(
                      child: Text("Add"),
                      onPressed: _addToDo,
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          textStyle: TextStyle(color: Colors.white)))
                ],
              ),
            ),
            // Criando lista
            Expanded(
                child: RefreshIndicator(
              onRefresh: _atualizar,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem),
            )),
          ],
        ));
  }

  // Metodo responsavel por criar a lista e remover o item da lista com swipe
  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      child: CheckboxListTile(
          title: Text(_toDoList[index]["title"]),
          value: _toDoList[index]["ok"],
          secondary: Icon(
            _toDoList[index]["ok"]
                ? Icons.assignment_turned_in_outlined
                : Icons.pending_actions_outlined,
            color: Colors.black87,
          ),
          onChanged: (value) {
            setState(() {
              _toDoList[index]["ok"] = value;
              _saveData();
            });
          }),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete_sweep, color: Colors.white),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _lastRemove = Map.from(_toDoList[index]);
          _lastRemovePos = index;
          _toDoList.removeAt(index);

          _saveData();

          // add snackbar
          final snackRemove = SnackBar(
            content: Text("Tarefa \"${_lastRemove["title"]}\" removida!"),
            backgroundColor: Colors.red,
            action: SnackBarAction(
                label: 'Desfazer',
                textColor: Colors.black,
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovePos, _lastRemove);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackRemove);
        });
      },
    );
  }

  Future<File> _getFile() async {
    // Recuperando a pasta de destino do arquivo (Android e iOS)
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/data1.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final arquivo = await _getFile();
    return arquivo.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final arquivo = await _getFile();

      return arquivo.readAsString();
    } catch (e) {
      return '';
    }
  }

  Future<Null> _atualizar() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // ordernando a lista para exibir as tarefas não concluidas no top assim que atualizar
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });
      _saveData();
    });
    return null;
  }
}
