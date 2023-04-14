import 'package:flutter/material.dart';

class MathSelection extends StatefulWidget {
  const MathSelection({super.key});

  @override
  State<MathSelection> createState() => _MathSelectionState();
}

class _MathSelectionState extends State<MathSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Magistro", style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Math',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
