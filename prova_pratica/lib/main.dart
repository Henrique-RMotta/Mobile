import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: (AppCadastroInteligente),
  ));
}

class AppCadastroInteligente extends StatefulWidget{
  @override
  _AppCadastroInteligente createState() => _AppCadastroInteligente;
}

clas