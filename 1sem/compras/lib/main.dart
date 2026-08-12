import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ComprasApp()));
}

class ComprasApp extends StatefulWidget {
  @override
  _ComprasAppState createState() => _ComprasAppState();
}

class _ComprasAppState extends State<ComprasApp> {
  List<String> itens = [];
  List<bool> comprado = [];
  TextEditingController controller = TextEditingController();

  void adicionarItem() {
    setState(() {
      itens.add(controller.text);
      comprado.add(false);
    });
  }

  void alternarComprado(int index) {
    setState(() {
      comprado[index] = !comprado[index];
    });
  }

  void salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("comprado", comprado.map((e) => e.toString()).toList());
  }

  void carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    itens = prefs.getStringList("itens") ?? [];
    List<String> listaBool = prefs.getStringList("comprado") ?? [];
    comprado = listaBool.map((e) => e == "true").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
