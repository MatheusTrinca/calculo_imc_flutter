import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Calculadora de IMC", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey();

  String _text = "Informe seus Dados";

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  void _resetFields() {
    _weightController.text = "";
    _heightController.text = "";
    setState(() {
      _text = "Informe seus Dados";
      _formKey = GlobalKey();
    });
  }

  double _calculaIMC() {
    final weight = double.parse(_weightController.text);
    final height = double.parse(_heightController.text) / 100;
    double imc = weight / (height * height);
    return imc;
  }

  void _setText() {
    _text = "Informe seus Dados";
    final imc = _calculaIMC();
    setState(() {
      if (imc < 18.6) {
        _text = "Abaixo do Peso (${imc.toStringAsPrecision(2)})";
      } else if (imc < 24.9) {
        _text = "Peso Ideal (${imc.toStringAsPrecision(2)})";
      } else if (imc < 29.9) {
        _text = "Levemente Acima do Peso (${imc.toStringAsPrecision(2)})";
      } else if (imc < 34.9) {
        _text = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
      } else if (imc < 39.9) {
        _text = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
      } else {
        _text = "Obesidade Grau III (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle:
                            TextStyle(color: Colors.green, fontSize: 24)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 24),
                    controller: _weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe seu peso!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle:
                            TextStyle(color: Colors.green, fontSize: 24)),
                    style: TextStyle(color: Colors.green, fontSize: 24),
                    textAlign: TextAlign.center,
                    controller: _heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe a sua altura!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Calcular",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _setText();
                          }
                        }),
                  ),
                  Text(_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 24))
                ],
              ),
            )));
  }
}
