import 'package:flutter/material.dart';

void main () {
  runApp(MaterialApp(home: PaginaContador()));
}

class PaginaContador extends StatefulWidget {
  @override 
  _PaginaContadorState createState() => _PaginaContadorState();
}

class _PaginaContadorState extends State<PaginaContador> {
  int contador = 0; 

  void increment() { 
    setState(() {
      contador++;
    });
  }

  void decrement() {
    setState(() {
      contador--;
    });
  }

  void reset() {
    setState(() {
      contador = 0 ;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Meu App Interativo"),
      titleTextStyle: TextStyle(color: Colors.white,
                                fontSize: 30), 
      backgroundColor: Colors.cyan),
        
      body: Center(
      child:Text("Cliques \n $contador",
                  style: TextStyle(fontSize: 30) ,
      )
      ),
      
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        FloatingActionButton(
        onPressed: increment,
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add,
                    color: Colors.white) 
                    ),
        SizedBox(height: 10),
        FloatingActionButton(
        onPressed: decrement,
        backgroundColor: Colors.red,
        child: Icon(Icons.remove,
                    color: Colors.white) 
                    ),
        SizedBox(height: 10),
        FloatingActionButton(
        onPressed: reset,
        backgroundColor: Colors.white,
        child: Icon(Icons.circle,
                    color: Colors.black,),
        )  ,
        ],
      )
    );
  }
}
