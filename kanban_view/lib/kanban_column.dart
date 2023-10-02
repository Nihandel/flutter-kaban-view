import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kanban_view/i_kanban_abstractions.dart';

class KanbanColumn extends StatelessWidget implements IKanbanColumn {
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
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Card(
        color: color,
        child: CustomScrollView(
          slivers: [
            if (header != null) header!,
            SliverList(delegate: SliverChildListDelegate(children))
          ],
        ),
      ),
    );
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
