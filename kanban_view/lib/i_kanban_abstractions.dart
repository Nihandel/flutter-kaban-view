import 'package:flutter/material.dart';

abstract class IKanbanColumn extends Widget {
  late final double? flex;
  late final double? minWidth;
  late final double? maxWidth;
  IKanbanColumn({this.flex, this.minWidth, this.maxWidth});
}

abstract class IKanbanDraggableColumn extends IKanbanColumn {
  final Widget feedback;
  final double opacity;
  final IKanbanColumn child;
  IKanbanDraggableColumn({required this.feedback, required this.opacity,required this.child})
      : assert(
            opacity <= 1.0 && opacity >= 0, "Opacity must be in range [0,1]");
}
