import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: TelaInicial()));
}

// ----------------- TELA 1 -----------------

class TelaInicial extends StatelessWidget {
  final String nome = "Henrique Motta";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Inicial"), backgroundColor: Colors.blue),
      body: Center(
        child: ElevatedButton(
          child: Text("Ir para Segunda Tela"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SegundaTela(nome:nome)),
            );
          },
        ),
      ),
    );
  }
}
// ----------------- TELA 2 -----------------

class SegundaTela extends StatelessWidget {
  final String nome; 

  SegundaTela({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Segunda Tela"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "olá, $nome",
              style: TextStyle(fontSize: 20,color: Colors.cyan),
              ),

            ElevatedButton(
              child: Text("Voltar"),
              onPressed: () {
                Navigator.pop(context);
              },
            
            ),


          ],
        ),
      ),
    );
  }
}
