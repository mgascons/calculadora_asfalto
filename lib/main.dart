import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Asfalto',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[200],
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: MyHomePage(title: 'Calculadora de Asfalto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _anchoController = TextEditingController();
  final _altoController = TextEditingController();
  final _profundoController = TextEditingController();
  final double _densidadAsfalto = 2133; // Densidad fija en kg/m³
  double _volumenAsfalto = 0;
  double _pesoAsfalto = 0;

  void _calcularAsfalto() {
    if (_formKey.currentState!.validate()) {
      double anchoCm = double.parse(_anchoController.text);
      double altoCm = double.parse(_altoController.text);
      double profundoCm = double.parse(_profundoController.text);

      double ancho = anchoCm / 100; // Convertir centímetros a metros
      double alto = altoCm / 100; // Convertir centímetros a metros
      double profundo = profundoCm / 100; // Convertir centímetros a metros

      _volumenAsfalto = ancho * alto * profundo;
      _pesoAsfalto = _volumenAsfalto * _densidadAsfalto;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Introduce los datos para calcular el peso de asfalto necesario:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/explicacion.png',
                  height: 100, // Ajusta el tamaño según sea necesario
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _anchoController,
                  decoration: InputDecoration(
                    labelText: 'Ancho (cm)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el ancho.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _altoController,
                  decoration: InputDecoration(
                    labelText: 'Alto (cm)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el alto.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _profundoController,
                  decoration: InputDecoration(
                    labelText: 'Profundidad (cm)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese la profundidad.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _calcularAsfalto,
                    child: Text('Calcular Asfalto'),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Resultados:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Volumen de asfalto necesario: $_volumenAsfalto m³',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Peso de asfalto necesario: $_pesoAsfalto kg',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
