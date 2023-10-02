import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kanban_view/i_kanban_abstractions.dart';
import 'package:kanban_view/kanban.dart';

class KanbanColumn<T> extends StatelessWidget implements IKanbanColumn {
  KanbanColumn(
      {super.key,
      this.header,
      required this.children,
      this.maxWidth,
      this.minWidth,
      this.flex,
      this.color})
      : assert(flex != null || maxWidth != null,
            "Provide flex or maxwidth parameter");

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      var size = Size(constraints.maxWidth, constraints.maxHeight);
      return SizedBox(
        width: size.width,
        height: size.height,
        child: DragTarget<KanbanItem<T>>(
          builder: (context, candidateData, rejectedData) => Card(
            color: color,
            child: CustomScrollView(
              slivers: [
                if (header != null) header!,
                SliverList(delegate: SliverChildListDelegate(children))
              ],
            ),
          ),
        ),
      );
    });
  }

  final SliverAppBar? header;
  final List<Widget> children;

  final Color? color;

  @override
  double? flex;

  @override
  double? maxWidth;

  @override
  double? minWidth;
}

class KanbanDraggableColumn extends StatelessWidget
    implements IKanbanDraggableColumn {
  KanbanDraggableColumn(
      {super.key,
      required this.child,
      required this.feedback,
      required this.opacity});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Draggable<IKanbanColumn>(
          data: this,
          feedback: Opacity(
              opacity: opacity,
              child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: feedback)),
          child: child);
    });
  }

  @override
  IKanbanColumn child;
  @override
  Widget feedback;

  @override
  double opacity;

  @override
  double? get flex => child.flex;

  @override
  double? get maxWidth => child.maxWidth;

  @override
  double? get minWidth => child.minWidth;

  @override
  set flex(double? _flex) {
    child.flex = _flex;
  }

  @override
  set maxWidth(double? _maxWidth) {
    child.maxWidth = maxWidth;
  }

  @override
  set minWidth(double? _minWidth) {
    child.minWidth = _minWidth;
  }
}
