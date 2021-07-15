import 'package:flutter/material.dart';

import 'apps/buscarGifs/buscarGifs_screen.dart';
import 'apps/calculadora/calculadora_screen.dart';
import 'apps/contadorPessoas/contadorPessoas_screen.dart';
import 'apps/conversorMoedas/conversorMoedas_screen.dart';
import 'apps/listaTarefas/listaTarefas_screen.dart';
import 'home/home_page.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    // initialRoute: '/',
    routes: {
      // '/': (context) => HomePage(),
      '/buscarGifs': (context) => BuscarGifsScreen(),
      '/calculadora': (context) => CalculadoraScreen(),
      '/contadorPessoas': (context) => ContadorPessoasScreen(),
      '/conversorMoedas': (context) => ConversorMoedasScreen(),
      '/listaTarefas': (context) => ListaTarefasScreen(),
    },
  ));
}
