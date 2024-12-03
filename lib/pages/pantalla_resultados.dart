import 'package:flutter/material.dart';
import 'package:la_carretera/logica/calculos.dart';

class PantallaResultados extends StatefulWidget {
  @override
  _PantallaResultadosState createState() => _PantallaResultadosState();
}

class _PantallaResultadosState extends State<PantallaResultados> {
  final _kmController = TextEditingController();
  final _horasController = TextEditingController();
  final _minutosController = TextEditingController();
  final _precioController = TextEditingController();
  final _dineroController = TextEditingController();

  double velocidadMedia = 0.0;
  double totalLitros = 0.0;
  double consumoPorKm = 0.0;
  double consumoCada100Km = 0.0;
  String mensajeError = ""; 

  void _calcular() {
    final km = double.tryParse(_kmController.text);
    final horas = int.tryParse(_horasController.text);
    final minutos = int.tryParse(_minutosController.text);
    final precio = double.tryParse(_precioController.text);
    final dinero = double.tryParse(_dineroController.text);

    if (km == null || horas == null || minutos == null || precio == null || dinero == null ||
        km <= 0 || horas < 0 || minutos < 0 || precio <= 0 || dinero <= 0) {
      setState(() {
        mensajeError = "Por favor, ingresa solo números positivos y válidos.";
      });
      return;
    }

    final resultados = calcularConsumos(km, horas, minutos, precio, dinero);

    setState(() {
      velocidadMedia = resultados.velocidadMedia ?? 0.0;
      totalLitros = resultados.totalLitros ?? 0.0;
      consumoPorKm = resultados.consumoPorKm ?? 0.0;
      consumoCada100Km = resultados.consumoCada100Km ?? 0.0;
      mensajeError = ""; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50], 
      appBar: AppBar(
        title: Text("Resultados"),
        backgroundColor: const Color.fromARGB(255, 140, 165, 204), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: <Widget>[
              _buildInputField(
                controller: _kmController,
                label: "Kilómetros recorridos",
                icon: Icons.directions_car,
                keyboardType: TextInputType.number,
              ),
              _buildInputField(
                controller: _horasController,
                label: "Horas",
                icon: Icons.access_time,
                keyboardType: TextInputType.number,
              ),
              _buildInputField(
                controller: _minutosController,
                label: "Minutos",
                icon: Icons.access_time,
                keyboardType: TextInputType.number,
              ),
              _buildInputField(
                controller: _precioController,
                label: "Precio por litro de gasolina",
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              _buildInputField(
                controller: _dineroController,
                label: "Dinero gastado en gasolina",
                icon: Icons.money,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcular,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Text("Calcular", style: TextStyle(fontSize: 18, color: Colors.black)), 
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white), 
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  elevation: MaterialStateProperty.all(10),
                ),
              ),
              SizedBox(height: 20),
              if (mensajeError.isNotEmpty)
                Text(
                  mensajeError,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              SizedBox(height: 40),
              if (velocidadMedia > 0)
                Column(
                  children: [
                    _buildResultText("Velocidad media: ${velocidadMedia.toStringAsFixed(2)} km/h"),
                    _buildResultText("Total litros gastados: ${totalLitros.toStringAsFixed(2)} litros"),
                    _buildResultText("Consumo por km: ${consumoPorKm.toStringAsFixed(2)} litros"),
                    _buildResultText("Consumo cada 100 km: ${consumoCada100Km.toStringAsFixed(2)} litros"),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller, 
    required String label,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue[900]), 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildResultText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.blue[900]), 
      ),
    );
  }
}
