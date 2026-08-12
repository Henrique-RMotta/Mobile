import 'package:flutter/material.dart';
import 'dart:math';

void main () {
  runApp(MaterialApp(home: randomApp()));
}

class randomApp extends StatefulWidget {
  @override
  _randomAppState createState() => _randomAppState();
}

class _randomAppState extends State<randomApp> {
  int randomnum = 0; 

  void sortear() {
    setState(() {
      randomnum = Random().nextInt(10) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Meu App com número aleatório'),
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 30),
      ),

        body:   Center(child: Text('Este é o número aleatório \n $randomnum',
        style:  TextStyle(fontSize: 30),
      )
      ),

        floatingActionButton: FloatingActionButton(onPressed: sortear,
        child: Icon(Icons.casino,color: Colors.white,),
        backgroundColor: Colors.black,
      ),
    );
  }

}