import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kanban_view/kanban.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: TestKaban())));
}

class TestKaban extends StatelessWidget {
  const TestKaban({super.key});

  @override
  Widget build(BuildContext context) {
    var random = Random();
    return KanbanView(
      children: List.generate(
        7,
        (index) => KabanColumn(
          flex: index.toDouble()*index.toDouble(),
          minWidth: 100,
          color: Colors.red,
          title: const Text("Column 1"),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          children: List.generate(
            9,
            (index) => const SizedBox(
              height: 200,
              child: Text("Test"),
            ),
          ),
        ),
      ).toList(),
    );
  }
}
