import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AppCadAlunos()));
}

class AppCadAlunos extends StatefulWidget {
  @override
  _AppCadAlunosState createState() => _AppCadAlunosState();
}

class _AppCadAlunosState extends State<AppCadAlunos> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerIdade = TextEditingController();
  TextEditingController controllerCurso = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> cadastrarAluno(String nome, String idade, String curso) async {
    await FirebaseFirestore.instance.collection("alunos").add({
      "nome": nome,
      "idade": int.parse(idade),
      "curso": curso,
    });
  }

  Future<void> deletarAluno(String id) async {
    await FirebaseFirestore.instance.collection("alunos").doc(id).delete();
  }

  Future<void> editarAluno(String id, String nome, String idade, String curso) async {
  await FirebaseFirestore.instance.collection("alunos").doc(id).update({
    "nome": nome,
    "idade": int.parse(idade),
    "curso": curso,
  });
}

void abrirDialogEdicao(String id, String nomeAtual, String idadeAtual, String cursoAtual) {
 TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerIdade = TextEditingController();
  TextEditingController controllerCurso = TextEditingController();
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Editar Aluno"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
TextField(
              controller: controllerNome,
              decoration: InputDecoration(
                labelText: "Nome do Aluno",
                border: OutlineInputBorder(),
              ),
            ),          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              // chame editarAluno() com os valores dos novos controllers
              // depois feche o dialog com Navigator.pop(context)
            },
            child: Text("Salvar"),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Alunos")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controllerNome,
              decoration: InputDecoration(
                labelText: "Nome do Aluno",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controllerIdade,
              decoration: InputDecoration(
                labelText: "Idade do Aluno",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
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
              if (controllerNome.text.isNotEmpty &&
                  controllerCurso.text.isNotEmpty &&
                  controllerIdade.text.isNotEmpty) {
                cadastrarAluno(
                  controllerNome.text,
                  controllerIdade.text,
                  controllerCurso.text,
                );
              }
            },
            child: Text("Cadastrar"),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("alunos")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final docs = snapshot.data!.docs;
                return  ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final aluno = docs[index];
                      return Card(
                        child: ListTile(
                          title: Text(aluno["nome"]),
                          subtitle: Text(
                            "${aluno["idade"]} anos - ${aluno["curso"]}",
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deletarAluno(aluno.id),
                          ),
                        ),
                      );
                    },
                  );
          
              },
            ),
          ),
        ],
      ),
    );
  }
}
