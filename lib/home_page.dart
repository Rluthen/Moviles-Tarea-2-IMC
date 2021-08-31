import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  num _totalAmount = 0.0;
  bool _male = false;
  bool _female = true;

  _pressMale() {
    setState(() {
      _male = true;
      _female = false;
    });
  }

  _pressFemale() {
    setState(() {
      _male = false;
      _female = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcular IMC'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  heightController.text = "";
                  weightController.text = "";
                });
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          Text(
            "Ingresa sus datos para clacular IMC",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _pressFemale,
                icon: Icon(
                  Icons.female,
                  color: _female ? Colors.indigo : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: _pressMale,
                icon: Icon(
                  Icons.male,
                  color: _male ? Colors.indigo : Colors.grey,
                ),
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.design_services),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Ingresar altura (m)",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.gpp_maybe),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Ingresar peso (KG)",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                    onPressed: () {
                      if (weightController.text != "" &&
                          heightController.text != "") {
                        _showIMC();
                      }
                      ;
                    },
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showIMC() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Tu IMC: ${num.parse(weightController.text) / pow(num.parse(heightController.text), 2)}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _male
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tabla del IMC para hombres"),
                          Text(""),
                          Text("Edad  | IMC Ideal"),
                          Text("16    | 19-24"),
                          Text("17    | 20-25"),
                          Text("18    | 20-25"),
                          Text("19-24 | 21-26"),
                          Text("25-34 | 22-27"),
                          Text("35-54 | 23-38"),
                          Text("55-64 | 24-29"),
                          Text("65-90 | 25-30"),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tabla del IMC para mujeres"),
                          Text(""),
                          Text("Edad  | IMC Ideal"),
                          Text("16-17 | 19-24"),
                          Text("18    | 19-24"),
                          Text("19-24 | 19-24"),
                          Text("25-34 | 20-25"),
                          Text("35-54 | 21-26"),
                          Text("55-64 | 22-27"),
                          Text("65-90 | 23-28"),
                          Text("65-90 | 25-30"),
                        ],
                      ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
