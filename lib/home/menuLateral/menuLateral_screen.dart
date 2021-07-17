import 'package:flutter/material.dart';

class MenuLateralScreen extends StatefulWidget {
  @override
  MenuLateralScreenState createState() => MenuLateralScreenState();
}

class MenuLateralScreenState extends State<MenuLateralScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu Apps',
              style: TextStyle(color: Colors.black87, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('imgs/camisaVasco.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.apps_outlined),
            title: Text('Buscar Gifs'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.apps_outlined),
            title: Text('Calculardora'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.apps_outlined),
            title: Text('Contador de Pessoas'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.apps_outlined),
            title: Text('Conversor de Moeadas'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.apps_outlined),
            title: Text('Lista de Tarefas'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
