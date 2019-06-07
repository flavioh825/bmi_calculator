import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController wheightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _information = "Informe seus dados.";

  void _refreshFields() {
    setState(() {
      wheightController.text = "";
      heightController.text = "";
      _information = "Informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(wheightController.text);
      double height = double.parse(heightController.text);
      double bmi = weight / (height * height) / 100;
      if (bmi < 18.6) {
        _information = "Abaixo do peso (${bmi.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
            onPressed: _refreshFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.accessibility_new, size: 80.0, color: Colors.orange[300]),
            TextField(keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite seu peso (kg)",
                labelStyle: TextStyle(color: Colors.orange[400])
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange[400], fontSize: 25.0),
              controller: wheightController,
            ),
            TextField(keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite sua altura (m)",
                labelStyle: TextStyle(color: Colors.orange[400])
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange[400], fontSize: 25.0),
              controller: heightController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: _calculate,
                  child: Text("Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  color: Colors.orange[300],
                ),
              ),
            ),
            Text(_information,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange[400], fontSize: 35.0, ),
            )
          ],
        ),
      ),
    );
  }
}