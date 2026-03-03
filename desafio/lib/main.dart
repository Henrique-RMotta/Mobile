import 'package:flutter/material.dart';

void main() {
  runApp(Desafio());
}

class Desafio extends StatelessWidget {
  const Desafio({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoPage());
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<String> lista_tarefas = [];
  final TextEditingController _textEditingController = TextEditingController();
  int contadorTarefas = 0;
  void adicionarTarefa() {
    setState(() {
      if (_textEditingController.text != "") {
        // desafio 1
        lista_tarefas.add(_textEditingController.text);
        contadorTarefas++;
      }
    });
  }

  void removerTarefa(int index) {
    setState(() {
      lista_tarefas.removeAt(index);
      contadorTarefas--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de Tarefas - ${(contadorTarefas > 0) ? contadorTarefas : "não há nenhuma tarefa"}",
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            onSubmitted: (_) => adicionarTarefa(),
          ),
          ElevatedButton(
            onPressed: adicionarTarefa,
            child: const Text("Adicionar"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: lista_tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(lista_tarefas[index]),
                  trailing: IconButton(
                    onPressed: () => removerTarefa(index),
                    icon: const Icon(Icons.delete),
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
