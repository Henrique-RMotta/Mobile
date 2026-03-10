import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InterruptorApp(),
  ));
}

class InterruptorApp extends StatefulWidget {
  @override 
  _InterruptorAppState createState() => _InterruptorAppState(); // classe que controla a mudança do estado do widget
}

class _InterruptorAppState extends State<InterruptorApp> { // State<aplicação> classe que pertence a aplicação 
  bool estaAceso = false; 

  void alternarLuz () {
    setState(() {
      estaAceso = !estaAceso;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: estaAceso ? Colors.black : Colors.white,

      appBar: AppBar(
        backgroundColor: estaAceso ? Colors.black : Colors.white,
        title: Text("Interruptor", 
                      style: TextStyle(color: estaAceso ? Colors.white : Colors.black
          ),
        ),
      ),
      body: Center(child: 
      Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                estaAceso ? Icons.lightbulb : Icons.lightbulb_outline,
                size: 100,
                color: estaAceso ? Colors.white : Colors.black,
              ),

              ElevatedButton(
                onPressed: alternarLuz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: estaAceso ? Colors.white : Colors.black
              ),
                child: Text(
                  "Interruptor", 
                  style: TextStyle(color: estaAceso ? Colors.black : Colors.white ) ,
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}