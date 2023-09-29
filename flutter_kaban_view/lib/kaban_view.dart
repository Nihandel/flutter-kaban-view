library kaban_view;

export './kaban_column.dart';
export './kaban_item.dart';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/widgets.dart';
import 'package:kaban_view/kaban_column.dart';

class KabanView extends StatelessWidget {
  const KabanView({super.key, this.columnsPerPage, required this.children});

  /// columns to show [KabanColumn]
  final List<KabanColumn> children;

  /// how many columns are visible without scrolling
  final int? columnsPerPage;

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
      child: LayoutBuilder(builder: (context, constraints) {
        List<double> getSlots() {
          return [];
        }
        double getPreferredSize(KabanColumn col){
          return col.minWidth ?? 200;
        }

        final row = SliverToBoxAdapter(
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: children
                  .mapIndexed((index,e) => ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: getPreferredSize(e)),
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
