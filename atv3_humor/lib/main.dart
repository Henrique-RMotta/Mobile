import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HumorApp()));
}

class HumorApp extends StatefulWidget {
  @override
  _HumorAppState createState() => _HumorAppState();
}

class _HumorAppState extends State<HumorApp> {
  final List<Color> HumorList = [Colors.green, Colors.grey, Colors.red];
  final List<IconData> IconList = [
    Icons.sentiment_satisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_dissatisfied,
  ];
  int idxlist = 0;
  void alternarHumor() {
    setState(() {
      idxlist++;
      idxlist = idxlist % 3;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HumorList[idxlist],
      appBar: AppBar(
        backgroundColor: HumorList[idxlist],
        title: Text("Humor", style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(IconList[idxlist],size: 100,),
            ElevatedButton(
              onPressed: alternarHumor,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text(
                "Mudar Humor",
                style: TextStyle(color: HumorList[idxlist]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
