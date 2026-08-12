import 'package:flutter/material.dart';


void main() {
  runApp(meuapp());
}

class meuapp extends StatelessWidget{

  @override 
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
        title: Text('Lista de Tarefas'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0), // colors.black
        titleTextStyle: TextStyle(
                                  color: Colors.white, 
                                  fontStyle: FontStyle.italic
                                  ),
        ),

        body: ListView(
          children: [
            ListTile(
            leading: Icon(Icons.radio_button_unchecked),
            title: Text('Estudar Flutter'),
            trailing:Icon(Icons.delete),
            ),
            ListTile(
            leading: Icon(Icons.radio_button_unchecked),
            title: Text('Praticar Dart'),
            trailing:Icon(Icons.delete),
            ),
            ListTile(
            leading: Icon(Icons.radio_button_unchecked),
            title: Text('Criar um App'),
            trailing:Icon(Icons.delete),
            ),
          ],
        ),
        
        floatingActionButton:
            FloatingActionButton(
            onPressed: () {},  
            backgroundColor: Colors.black, 
            child: Icon(
                        Icons.add,
                        color: Colors.white,
                        ),
                                )
            
      ),
    );
  }
}