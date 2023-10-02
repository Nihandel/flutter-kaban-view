import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kanban_view/kanban.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: Scaffold(body: TestKaban())));
}

class TestKaban extends StatelessWidget {
  const TestKaban({super.key});

  @override
  Widget build(BuildContext context) {
    var random = Random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: KanbanView(
        children: List<IKanbanColumn>.generate(
          10,
          (index) => KanbanDraggableColumn(
            feedback: Card(child: Text("Column ${index + 1}")),
            opacity: 0.8,
            child: KanbanColumn(
              flex: 1 + (index.toDouble() * index.toDouble()),
              minWidth: 200,
              maxWidth: 500,
              color: Colors.red,
              header: SliverAppBar(
                title: Text("Column ${index + 1}"),
                pinned: true,
                floating: true,
                collapsedHeight: 60,
                expandedHeight: 100,
                actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
                bottom: const PreferredSize(
                    preferredSize: Size(double.infinity, 50),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Chip(label: Text("Chip")),
                        ],
                      ),
                    )),
              ),
              children: List.generate(
                9,
                (index) => KanbanItem(
                    data: index,
                    child: SizedBox(height: 200, child: Text("Card $index"))),
              ),
            ),
          ),
        ).toList()
          ..add(
              KanbanColumn(maxWidth: 100, color: Colors.transparent, children: [
            Container(
              child: SizedBox(
                height: 100,
                width: 100,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ),
            )
          ])),
      ),
    );
  }
}
