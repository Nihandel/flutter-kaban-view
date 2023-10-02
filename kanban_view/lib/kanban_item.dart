import 'package:flutter/material.dart';

class KanbanItem<T> extends StatelessWidget {
  const KanbanItem({super.key, required this.data, required this.child});
  final T data;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Draggable<KanbanItem<T>>(
      feedback: Card(child: child),
      child: Card(
        child: child,
      ),
    );
  }
}
