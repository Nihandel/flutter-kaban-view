library kaban_view;

export 'kanban_column.dart';
export 'kanban_item.dart';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/widgets.dart';
import 'package:kanban_view/kanban_column.dart';

class KabanView extends StatefulWidget {
  const KabanView({super.key, this.columnsPerPage, required this.children});

  /// columns to show [KabanColumn]
  final List<KabanColumn> children;

  /// how many columns are visible without scrolling
  final int? columnsPerPage;

  @override
  State<KabanView> createState() => _KabanViewState();
}

class _KabanViewState extends State<KabanView> {
  late List<KabanColumn> children;
  late List<double> sizes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    children = widget.children;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  /// custom layout 
  List<double> _getSlots(BoxConstraints constraints) {
    double maxFlex = children.map((e) => e.flex ?? 1).reduce(
          (value, element) => value += element,
        );
    var maxWidth = constraints.maxWidth;
    return children.map((e) {
      double flexWidth = maxWidth / maxFlex * (e.flex ?? 1);
      if (e.minWidth != null && flexWidth < e.minWidth!) {
        return e.minWidth!;
      } else if (e.maxWidth != null && flexWidth > e.maxWidth!) {
        return e.maxWidth!;
      } else if (e.flex == null && e.maxWidth != null) {
        return e.maxWidth!;
      }

      return flexWidth;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: LayoutBuilder(builder: (context, constraints) {
        var slots = _getSlots(constraints);
        final row = SliverToBoxAdapter(
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.children
                  .mapIndexed((index, e) => ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: slots[index]),
                      child: e))
                  .toList()),
        );
        final CustomScrollView scrollView = CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [row],
        );

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: scrollView,
        );
      }),
    );
  }
}
