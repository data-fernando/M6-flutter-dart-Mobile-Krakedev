import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() {
    return CalculatorPageState();
  }
}

class CalculatorPageState extends State<CalculatorPage> {
  int valor1 = 0;
  int valor2 = 0;
  int resultado = 0;

  final TextEditingController controller1 = TextEditingController(text: "0");
  final TextEditingController controller2 = TextEditingController(text: "0");

  void handleSumar() {
    setState(() {
      valor1 = int.parse(controller1.text);
      valor2 = int.parse(controller2.text);
      resultado = valor1 + valor2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ingrese el primer valor:"),
            TextField(
              controller: controller1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text("Ingrese el segundo valor:"),
            TextField(
              controller: controller2,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: handleSumar,
              child: const Text("SUMAR"),
            ),
            const SizedBox(height: 30),
            Text(
              "Resultado: $resultado",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
