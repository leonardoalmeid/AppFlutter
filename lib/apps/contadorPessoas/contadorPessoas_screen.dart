import 'package:flutter/material.dart';

class ContadorPessoasScreen extends StatefulWidget {
  @override
  ContadorPessoasScreenState createState() => ContadorPessoasScreenState();
}

class ContadorPessoasScreenState extends State<ContadorPessoasScreen> {
  int _people = 0;
  String _infoText = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changePeople(int delta) {
    setState(() {
      _people += delta;
      if (_people < 0) {
        _infoText = "Ops, tem algo de errado...";
      } else if (_people <= 10) {
        _infoText = "Pode entrar!";
      } else {
        _infoText = "Loja Lotada!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "imgs/fundo.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_people",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      changePeople(1);
                    }, //função anonima
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      changePeople(-1);
                    }, //função anonima
                  ),
                ),
              ],
            ),
            Text(
              "$_infoText",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            )
          ],
        ),
      ],
    );
  }
}
