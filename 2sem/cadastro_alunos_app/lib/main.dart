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
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPesquisa = TextEditingController();
  String termoPesquisa = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> cadastrarAluno(
    String nome,
    String idade,
    String curso,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection("alunos").add({
      "nome": nome,
      "idade": int.parse(idade),
      "curso": curso,
      "email": email,
    });
  }

  Future<void> deletarAluno(String id) async {
    await FirebaseFirestore.instance.collection("alunos").doc(id).delete();
  }

  Future<void> editarAluno(
    String id,
    String nome,
    String idade,
    String curso,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection("alunos").doc(id).update({
      "nome": nome,
      "idade": int.parse(idade),
      "curso": curso,
      "email": email,
    });
  }

  void abrirDialogEdicao(
    String id,
    String nomeAtual,
    String idadeAtual,
    String cursoAtual,
    String emailAtual,
  ) {
    TextEditingController controllerNome = TextEditingController(
      text: nomeAtual,
    );
    TextEditingController controllerIdade = TextEditingController(
      text: idadeAtual,
    );
    TextEditingController controllerCurso = TextEditingController(
      text: cursoAtual,
    );
    TextEditingController controllerEmail = TextEditingController(
      text: emailAtual,
    );

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
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerIdade,
                decoration: InputDecoration(
                  labelText: "Idade do Aluno",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerCurso,
                decoration: InputDecoration(
                  labelText: "Nome do Curso",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                editarAluno(
                  id,
                  controllerNome.text,
                  controllerIdade.text,
                  controllerCurso.text,
                  controllerEmail.text,
                );
                Navigator.pop(context);
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void confirmarExclusao(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmar exclusão"),
          content: Text("Deseja realmente excluir este aluno?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                deletarAluno(id);
                Navigator.pop(context);
              },
              child: Text("Excluir"),
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("alunos").snapshots(),
            builder: (context, snapshot) {
              final totalAlunos = snapshot.data?.docs.length ?? 0;
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Total de alunos: $totalAlunos",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
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
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 10),
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
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (controllerNome.text.isEmpty ||
                  controllerIdade.text.isEmpty ||
                  controllerCurso.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Preencha todos os campos!")),
                );
                return;
              }
              cadastrarAluno(
                controllerNome.text,
                controllerIdade.text,
                controllerCurso.text,
                controllerEmail.text,
              );
              controllerNome.clear();
              controllerIdade.clear();
              controllerCurso.clear();
              controllerEmail.clear();
            },
            child: Text("Cadastrar"),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controllerPesquisa,
              onChanged: (valor) {
                setState(() {
                  termoPesquisa = valor;
                });
              },
              decoration: InputDecoration(
                labelText: "Pesquisar aluno",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
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
                final docs = snapshot.data!.docs.where((aluno) {
                  final dadosAluno = aluno.data() as Map<String, dynamic>;
                  final nome =
                      dadosAluno["nome"]?.toString().toLowerCase() ?? "";
                  return nome.contains(termoPesquisa.toLowerCase());
                }).toList();
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final aluno = docs[index];
                    final dadosAluno = aluno.data() as Map<String, dynamic>;
                    final email = dadosAluno["email"] as String? ?? "";
                    return Card(
                      child: ListTile(
                        title: Text(aluno["nome"]),
                        subtitle: Text(
                          "${aluno["idade"]} anos - ${aluno["curso"]}\n$email",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => abrirDialogEdicao(
                                aluno.id,
                                aluno["nome"],
                                aluno["idade"].toString(),
                                aluno["curso"],
                                email,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => confirmarExclusao(aluno.id),
                            ),
                          ],
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
