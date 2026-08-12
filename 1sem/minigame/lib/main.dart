import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MiniGameApp()));
}

class MiniGameApp extends StatefulWidget {
  @override
  _MiniGameAppState createState() => _MiniGameAppState();
}

class _MiniGameAppState extends State<MiniGameApp> {
  IconData iconeComputador = Icons.computer;

  String resultado = "Escolha uma opção";

  int pontosJogador = 0;
  int pontosComputador = 0;

  List opcoes = ["pedra", "papel", "tesoura"];

  void jogar(String escolhaUsuario) {
    var numero = Random().nextInt(3);
    var escolhaComputador = opcoes[numero];

    setState(() {
      if (escolhaComputador == "pedra") {
        iconeComputador = Icons.landscape;
      }
      if (escolhaComputador == "papel") {
        iconeComputador = Icons.pan_tool;
      }
      if (escolhaComputador == "tesoura") {
        iconeComputador = Icons.content_cut;
      }

      if (escolhaUsuario == escolhaComputador) {
        resultado = "Empate";
      } else if ((escolhaUsuario == "pedra" &&
              escolhaComputador == "tesoura") ||
          (escolhaUsuario == "papel" && escolhaComputador == "pedra") ||
          (escolhaUsuario == "tesoura" && escolhaComputador == "papel")) {
        pontosJogador++;
        resultado = "Você venceu!";

        if (pontosJogador == 5) {
          resultado = "🏆 Você ganhou o campeonato!";
          pontosJogador = 0;
          pontosComputador = 0;
        }
      } else {
        pontosComputador++;
        resultado = "Computador venceu!";

        if (pontosComputador == 5) {
          resultado = " Você perdeu o campeonato!";
          pontosJogador = 0;
          pontosComputador = 0;
        }
      }
    });
  }

  void resetarPlacar() {
    setState(() {
      pontosJogador = 0;
      pontosComputador = 0;
      iconeComputador = Icons.computer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedra Papel Tesoura")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Computador"),

            Icon(iconeComputador, size: 100),

            Text(resultado, style: TextStyle(fontSize: 26)),

            Text("Você: $pontosJogador | PC: $pontosComputador"),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => jogar("pedra"),
                  icon: Icon(Icons.landscape),
                ),
                IconButton(
                  onPressed: () => jogar("papel"),
                  icon: Icon(Icons.pan_tool),
                ),
                IconButton(
                  onPressed: () => jogar("tesoura"),
                  icon: Icon(Icons.content_cut),
                ),
              ],
            ),

            ElevatedButton.icon(
              onPressed: resetarPlacar,
              icon: Icon(Icons.refresh),
              label: Text("Resetar Placar"),
            ),
          ],
        ),
      ),
    );
  }
}
