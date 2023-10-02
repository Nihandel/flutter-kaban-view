import 'package:flutter/material.dart';

class KanbanItem<T> extends StatelessWidget {
  const KanbanItem({super.key, required this.data, required this.child});
  final T data;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Draggable<KanbanItem<T>>(
          feedback: ConstrainedBox(constraints: constraints, child: Card(child: child)),
          child: Card(
            child: child,
          ),
        );
      }
    );
  }
}
