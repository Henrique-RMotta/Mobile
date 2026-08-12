import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Contatos()));
}

class Contatos extends StatelessWidget {
  final List<String> nomes = ["Kayque", "Isa", "Xao"];
  final List<String> numeros = [
    "(19) 92947-4444",
    "(19) 99283-2008",
    "(19) 99122-2034",
  ];
  final List<Color> cores = [Colors.purple, Colors.pink, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body:  ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(nomes[0]),
            subtitle: Text(numeros[0]),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Detalhes(nome:nomes[0], numero:numeros[0],cor:cores[0])),
                );
              },
              child: Icon(Icons.add_call,color: Colors.black,),
            ),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text(nomes[1]),
            subtitle: Text(numeros[1]),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Detalhes(nome:nomes[1], numero:numeros[1],cor:cores[1])),
                );
              },
              child: Icon(Icons.add_call,color: Colors.black,),
            ),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text(nomes[2]),
            subtitle: Text(numeros[2]),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Detalhes(nome:nomes[2], numero:numeros[2],cor:cores[2])),
                );
              },
              child: Icon(Icons.add_call, color: Colors.black,),
            ),
          ),
        ],
      ),
    );
  }
}

class Detalhes extends StatelessWidget {
  final String nome; 
  final String numero;
  final Color cor;
  Detalhes({required this.nome , required this.numero, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalhes do contato: $nome",
          style: TextStyle(color: Colors.white ),
          ),
        backgroundColor: cor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person,size: 100,),
            Text(
              "Nome: $nome", 
              style: TextStyle(fontSize: 20),
              ),
            Text(
              "Número: $numero",
              style: TextStyle(fontSize: 20),
              ),
            SizedBox(height: 10),
            Text("Ligando para: $nome"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                Icons.call, 
                color: Colors.green, 
                size: 30,
                ),
                SizedBox(width: 100),
                Icon(
                  Icons.call_end,
                  color: Colors.red, 
                  size: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

