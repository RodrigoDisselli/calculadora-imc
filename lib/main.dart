import 'package:flutter/material.dart';
import 'package:calculadora_imc/models/pessoa.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        
        
      ),
    );


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _result;


  var _pessoa = Pessoa(weight: 0, height: 0, sex: 1);

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = 'Informe seus dados';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      backgroundColor: Colors.blueAccent,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          buildRadioButton(),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }
  


// ...

Widget buildRadioButton() {
  return Center(
    child: Column(
      children: <Widget>[
        
        ListTile(
          title: const Text('Feminino'),
          leading: Radio(
            value: 2,
            groupValue: _pessoa.sex,
            onChanged: (int value) {
              setState(() { _pessoa.sex = value; });
            },
          ),
        ),
        ListTile(
          title: const Text('Masculino'),
          leading: Radio(
            value: 1,
            groupValue: _pessoa.sex,
            onChanged: (int value) {
              setState(() { _pessoa.sex = value; });
            },
          ),
        ),
      ],
    ),
  );
}


  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        color: Colors.blueAccent,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _pessoa.calculateImc(double.parse(_weightController.text), double.parse(_heightController.text), _pessoa.sex);
            setState(() {
              _result = _pessoa.imc.toStringAsPrecision(2) + "\n" + _pessoa.result;
            });
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _statusText(status){
    int r;
    int g;
    int b;

    if(status == 0){
      r = 0; g = 184; b = 49;
    }else if(status == 1){
      r = 65; g = 159; b = 217;
    }else if(status == 2){
      r = 242; g = 208; b = 34;
    }else if(status == 3){
      r = 242; g = 190; b = 34;
    }else if(status == 4){
      r = 242; g = 146; b = 29;
    }else if(status == 5){
      r = 217; g = 65; b = 30;
    }else{
      r = 0; g = 0; b = 0;
    }

    return Text(
      _result,
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(r, g, b, 1), fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: _statusText(_pessoa.status)
    );
    
  }

  Widget buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}
