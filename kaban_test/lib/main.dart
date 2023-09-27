import 'package:flutter/material.dart';
import 'package:kaban_view/kaban_view.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: TestKaban())));
}

class TestKaban extends StatelessWidget {
  const TestKaban({super.key});

  @override
  Widget build(BuildContext context) {
    return KabanView(
      columns: [
        KabanColumn.Fixed(
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
        KabanColumn.Expanded(
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
        KabanColumn.Fixed(
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
        KabanColumn.Expanded(
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
