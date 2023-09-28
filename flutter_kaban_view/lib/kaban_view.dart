library kaban_view;

export './kaban_column.dart';
export './kaban_item.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/widgets.dart';
import 'package:kaban_view/kaban_column.dart';

class KabanView extends StatelessWidget {
  const KabanView({super.key, required this.columns});
  final List<Widget> columns;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: columns.map((e) => SizedBox(width: 300,child: e,)).toList()),),
      // CustomScrollView(
      //   scrollDirection: Axis.horizontal,
      //   slivers: [
      //     SliverFillRemaining(
      //       child: CustomScrollView(
      //         shrinkWrap: true,
      //           physics: const AlwaysScrollableScrollPhysics(),
      //           scrollDirection: Axis.vertical,
      //           slivers: [
      //             SliverCrossAxisGroup(
      //               slivers: columns
      //                   .map((e) => SliverConstrainedCrossAxis(
      //                         maxExtent: 500,
      //                         // flex: e is KabanColumn ? e.flex : 1,
      //                         sliver: SliverToBoxAdapter(child: e),
      //                       ))
      //                   .toList(),
      //             ),
      //           ]),
      //     )
      //   ],
      // ),
    );
  }
}
