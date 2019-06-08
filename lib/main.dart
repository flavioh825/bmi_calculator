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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _information = "Informe seus dados.";

  void _refreshFields() {
    wheightController.text = "";
    heightController.text = "";
    setState(() {
      _information = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(wheightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);
      if (bmi < 18.5) {
        _information = "Abaixo do peso (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        _information = "Peso normal (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 25 && bmi <= 29.9) {
        _information = "Sobrepeso (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 30 && bmi <= 34.9) {
        _information = "Obesidade grau 1 (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 35 && bmi <= 39.9) {
        _information = "Obesidade grau 2 (${bmi.toStringAsPrecision(4)})";
      } else if (bmi > 40) {
        _information = "Obesidade grau 3 (${bmi.toStringAsPrecision(4)})";
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.accessibility_new, size: 80.0, color: Colors.orange[300]),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Digite seu peso (kg)",
                  labelStyle: TextStyle(color: Colors.orange[400])
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange[400], fontSize: 25.0),
                controller: wheightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira seu peso.";
                  }
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Digite sua altura (cm)",
                  labelStyle: TextStyle(color: Colors.orange[400])
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange[400], fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira sua altura.";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
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
      ),
    );
  }
}