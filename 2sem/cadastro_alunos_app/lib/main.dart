import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AppCadAlunos(),
  ));
}
class AppCadAlunos extends StatefulWidget {
  @override 
  _AppCadAlunosState createState() => _AppCadAlunosState(); 
}

class _AppCadAlunosState extends State<AppCadAlunos> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerIdade = TextEditingController(); 
  TextEditingController controllerCurso = TextEditingController();
  List<Map<String, dynamic>> alunos = []; 

  Future<Database> criarBanco() async {
    final caminho = await getDatabasesPath(); 
    final path = join(caminho, "banco.db");

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE alunos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, idade INT, curso TEXT)"
        );
      },
      version: 1,
      );
  }

  @override
  void initState() {
    super.initState();
    carregarAlunos();
  }

  Future<void> carregarAlunos() async {
    final db = await criarBanco(); 
    final lista = await db.query("alunos"); 

    setState(() {
      alunos = lista; 
    });
  }

  Future<void> cadastrarAluno(String nome, String idade , String curso) async {
    final db = await criarBanco(); 
    
    await db.insert("alunos", {"nome" : nome, "curso" : curso, "idade" : int.parse(idade)}); 

    carregarAlunos(); 

  } 

  Future <void> deletarAluno (int id) async {
    final db = await criarBanco(); 

    await db.delete("alunos", where: "id = ?", whereArgs: [id]); 
    carregarAlunos(); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Alunos")
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(10),
          child: TextField(
            controller: controllerNome,
            decoration: InputDecoration(
              labelText: "Nome do Aluno",
              border: OutlineInputBorder(),
            ),
          ),
          ),
          Padding(padding: const EdgeInsets.all(10),
          child: TextField(
            controller: controllerIdade,
            decoration: InputDecoration(
              labelText: "Idade do Aluno",
              border: OutlineInputBorder(),
            ),
          ),
          ),
          Padding(padding: const EdgeInsets.all(10),
          child: TextField(
            controller: controllerCurso,
            decoration: InputDecoration(
              labelText: "Curso",
              border: OutlineInputBorder(),
            ),
          ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controllerNome.text.isNotEmpty && controllerCurso.text.isNotEmpty && controllerIdade.text.isNotEmpty) {
                cadastrarAluno(controllerNome.text, controllerIdade.text, controllerCurso.text); 
              }
            }, 
            child: Text("Cadastrar"),
            ),

            Expanded(child: ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(alunos[index]["nome"]),
                  subtitle: Text(alunos[index]["curso"] + "-" + alunos[index]["idade"].toString() +  "anos"),
                  trailing: IconButton(onPressed: () {
                    deletarAluno(alunos[index]["id"]); 
                  }, 
                  icon: Icon(Icons.delete),
                  ),
                );
              },
            ))
        ],
      ),
    );
  }
}
