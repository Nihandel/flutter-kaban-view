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
    return LayoutBuilder(
      builder: (context,constraints) {
        return Stack(
          children: [
            Positioned(
              top: 50,
              left: 50,
              width: constraints.maxWidth *.8,
              height: constraints.maxHeight *.8,
              child: KanbanView(
                children: List.generate(
                  10,
                  (index) => KabanColumn(
                    flex: index.toDouble(),
                    minWidth: 300,
                    maxWidth: 500,
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
              ),
            ),
          ],
        );
      }
    );
  }
}
