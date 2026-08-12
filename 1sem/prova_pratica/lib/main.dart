import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppCadastroInteligente(),
    ),
  );
}

class AppCadastroInteligente extends StatefulWidget {
  @override
  _AppCadastroInteligente createState() => _AppCadastroInteligente();
}

class _AppCadastroInteligente extends State<AppCadastroInteligente> {
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDesc = TextEditingController();

  List<Map<String, dynamic>> dados = [];

  Future<Database> criarBanco() async {
    final caminho = await getDatabasesPath();
    final path = join(caminho, "banco.db");

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dados (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT, criado_em DATETIME)",
        );
      },
      version: 1,
    );
  }

  Future<void> inserirTarefa(String titulo, String descricao) async {
    final db = await criarBanco();
    await db.insert("dados", {
      "titulo": titulo,
      "descricao": descricao,
      "criado_em": DateTime.now().toIso8601String(),
    });
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    final db = await criarBanco();

    final lista = await db.query("dados", orderBy: "titulo ASC");

    setState(() {
      dados = lista;
    });
  }

  Future<void> deletarTarefa(int id) async {
    final db = await criarBanco();

    await db.delete("dados", where: "id=?", whereArgs: [id]);
    carregarTarefas();
  }

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App de Cadastro Inteligente")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _controllerTitulo,
              decoration: InputDecoration(
                labelText: "Nome da Tarefa",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _controllerDesc,
              decoration: InputDecoration(
                labelText: "Descrição da Tarefa",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controllerTitulo.text.isNotEmpty &&
                  _controllerDesc.text.isNotEmpty) {
                inserirTarefa(_controllerTitulo.text, _controllerDesc.text);
                _controllerTitulo.clear();
                _controllerDesc.clear();
              }
            },
            child: Text("Adicionar"),
          ),
          Expanded(
            child: dados.isEmpty
                ? Center(child: Text("Não há tarefas"))
                : ListView.builder(
                    itemCount: dados.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(dados[index]["titulo"]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dados[index]["descricao"]),
                            Text(dados[index]["criado_em"].toString()),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deletarTarefa(dados[index]["id"]);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
