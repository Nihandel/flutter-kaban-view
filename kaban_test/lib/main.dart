import 'package:flutter/material.dart';
import 'package:kaban_view/kaban_view.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: TestKaban())));
}

class TestKaban extends StatelessWidget {
  const TestKaban({super.key});

  @override
  Widget build(BuildContext context) {
    return const KabanView(
      columns: [
        KabanColumn(color: Colors.red,),
        KabanColumn(color: Colors.amber,),
        KabanColumn(color: Colors.pink,),
        KabanColumn(color: Colors.purple,),
      ],
    );
  }
}
