import 'package:flutter/material.dart';
import 'package:kaban_view/kanban.dart';
void main() {
  runApp(const MaterialApp(home: Scaffold(body: TestKaban())));
}

class TestKaban extends StatelessWidget {
  const TestKaban({super.key});

  @override
  Widget build(BuildContext context) {
    return KanbanView(
      children: [
        KabanColumn(
          flex: 1,
          minWidth: 500,
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
        KabanColumn(
          minWidth: 300,
          maxWidth: 400,
          flex: 2,
          color: Colors.red,
          title: const Text("Column 2"),
          children: List.generate(
            10,
            (index) => const SizedBox(
              height: 200,
              child: Text("Test"),
            ),
          ),
        ),
        KabanColumn(
          maxWidth: 300,
          color: Colors.red,
          title: const Text("Column 3"),
          children: List.generate(
            10,
            (index) => const SizedBox(
              height: 200,
              child: Text("Test"),
            ),
          ),
        ),
        KabanColumn(
          minWidth: 100,
          maxWidth: 300,
          flex: 1,
          showHeader: false,
          children: [
            Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(8.0),
                child:
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.add))),
          ],
        )
      ],
    );
  }
}
