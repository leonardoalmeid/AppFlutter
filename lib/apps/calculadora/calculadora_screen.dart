import 'package:flutter/material.dart';

class CalculadoraScreen extends StatefulWidget {
  @override
  CalculadoraScreenState createState() => CalculadoraScreenState();
}

class CalculadoraScreenState extends State<CalculadoraScreen> {
  String _info = "Informe seus dados";

  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  GlobalKey<FormState> _chaveFormulario = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _resetText() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _info = "Informe seus dados";
      _chaveFormulario = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double resultIMC = peso / (altura * altura);

      if (resultIMC < 18.6) {
        //adicionando a quantidade de casa decimal dps da virgular
        _info = "Abaixo do Peso (Seu IMC: ${resultIMC.toStringAsPrecision(2)})";
      } else if (resultIMC >= 18.6 && resultIMC < 24.9) {
        _info = "Peso ideal (Seu IMC: ${resultIMC.toStringAsPrecision(2)})";
      } else if (resultIMC >= 24.9 && resultIMC < 29.9) {
        _info =
            "Levemente acima do Peso (Seu IMC: ${resultIMC.toStringAsPrecision(2)})";
      } else if (resultIMC >= 29.9 && resultIMC < 34.9) {
        _info =
            "Obesidade Grau I (Seu IMC: ${resultIMC.toStringAsPrecision(2)})";
      } else if (resultIMC >= 34.9 && resultIMC < 39.9) {
        _info =
            "Obesidade Grau II (Seu IMC: ${resultIMC.toStringAsPrecision(2)})";
      } else if (resultIMC >= 40.0) {
        _info =
            "Obesidade Grau III (Seu IMC: ${resultIMC.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetText,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _chaveFormulario,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Peso (kg)"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                  controller: pesoController,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Altura (cm)"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                  controller: alturaController,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Insira sua altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        var teste = _chaveFormulario.currentState?.validate();
                        if (teste != null) {
                          _calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                  ),
                ),
                Text("$_info",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0))
              ],
            ),
          ),
        ));
  }
}
