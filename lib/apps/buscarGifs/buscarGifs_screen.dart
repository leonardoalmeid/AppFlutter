import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuscarGifsScreen extends StatefulWidget {
  @override
  BuscarGifsScreenState createState() => BuscarGifsScreenState();
}

class BuscarGifsScreenState extends State<BuscarGifsScreen> {
  String? pesquisa;
  int pagina = 0;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }

  void _carregar() {
    setState(() {
      obterGifs().then((value) => {print(value)});
    });
  }

  Future<Map> obterGifs() async {
    http.Response retorno;
    if (pesquisa == null) {
      var urlMelhoresGifs = Uri.parse(
          'https://api.giphy.com/v1/gifs/trending?api_key=1kQ2r3gGYcoA9EQTY3cyjP8x4Zfvy2H0&limit=20&rating=g');
      retorno = await http.get(urlMelhoresGifs);
    } else {
      var urlPesquisaGifs = Uri.parse(
          'https://api.giphy.com/v1/gifs/search?api_key=1kQ2r3gGYcoA9EQTY3cyjP8x4Zfvy2H0&q=$pesquisa&limit=20&offset=$pagina&rating=g&lang=pt');
      retorno = await http.get(urlPesquisaGifs);
    }
    return json.decode(retorno.body);
  }
}
