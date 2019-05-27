import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert'; //para transformar os dados em json

const request = "https://api.hgbrasil.com/finance?key=434a4107";

void main() async {
  runApp(MaterialApp(
    home: home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
    ), //ThemeData
  )); //MaterialApp
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  double dolar, euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "\$ Conversor \$",
        ),
        centerTitle: true,
      ), //AppBar
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0,
                  ), //TextStyle
                  textAlign: TextAlign.center,
                ), //Text
              ); //Center
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ), //TextStyle
                    textAlign: TextAlign.center,
                  ), //Text
                ); //Center
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      //Icon
                      buildTextField("Reais", "R\$", 25.0),
                      Divider(),
                      buildTextField("Dolares", "US\$", 25.0),
                      Divider(),
                      buildTextField("Euros", "€\$", 25.0),
                    ], //Widget
                  ), //Column
                ); //SingleChildScrowView
              }
          }
        }, //Builder
      ), //FutureBuilder
    ); //Scaffold
  }
}
Widget buildTextField(String label, String prefix, double font){
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.amber,
      ), //TextStyle
      border: OutlineInputBorder(),
      prefixText: prefix,
    ), //InputDecoration
    style: TextStyle(
      color: Colors.amber,
      fontSize: font,
    ), //TextStyle
  ); //Euro //TextField
}