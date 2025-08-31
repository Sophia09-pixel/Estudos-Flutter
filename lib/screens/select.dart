import 'package:flutter/material.dart';
import '../model/time.dart';

class SelectPage extends StatelessWidget {
  final Time time;

  const SelectPage({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(time.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(time.logo, width: 120, height: 120),
            const SizedBox(height: 20),
            Text(
              time.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "ID do time: ${time.id}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
