import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConversorMoedasScreen extends StatefulWidget {
  @override
  ConversorMoedasScreenState createState() => ConversorMoedasScreenState();
}

class ConversorMoedasScreenState extends State<ConversorMoedasScreen> {
  final url = "https://api.hgbrasil.com/finance?format=json&key=e76f6e9e";
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar = 0;
  double euro = 0;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _carregar() {}

  void _realChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Conversor de Moedas"),
            backgroundColor: Colors.amber,
            centerTitle: true),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text("Carregando dados...",
                        style: TextStyle(color: Colors.amber, fontSize: 20.0),
                        textAlign: TextAlign.center));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Erro ao carregar dados.",
                          style: TextStyle(color: Colors.amber, fontSize: 20.0),
                          textAlign: TextAlign.center));
                } else {
                  dolar = snapshot.data?["USD"]["buy"];
                  euro = snapshot.data?["EUR"]["buy"];

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.monetization_on,
                            size: 150.0, color: Colors.amber),
                        buildTextField(
                            "Reais", "R\$", realController, _realChange),
                        Divider(),
                        buildTextField(
                            "Dolar", "US\$", dolarController, _dolarChange),
                        Divider(),
                        buildTextField("Euro", "€", euroController, _euroChange)
                      ],
                    ),
                  );
                }
            }
          },
        ));
  }

  Widget buildTextField(String label, String prefix, TextEditingController c,
      Function(String) change) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber),
          border: OutlineInputBorder(),
          prefixText: prefix),
      style: TextStyle(color: Colors.amber, fontSize: 20.0),
      onChanged: change,
      keyboardType: TextInputType.number,
    );
  }

  Future<Map> getData() async {
    var apiConversor = Uri.parse(url);
    http.Response response = await http.get(apiConversor);
    return json.decode(response.body)["results"]["currencies"];
  }
}
