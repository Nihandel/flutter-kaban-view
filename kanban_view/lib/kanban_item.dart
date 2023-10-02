import 'package:flutter/material.dart';

class KanbanItem<T> extends StatelessWidget {
  const KanbanItem({super.key, required this.data, required this.child});
  final T data;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: child,
    );
  }
}
