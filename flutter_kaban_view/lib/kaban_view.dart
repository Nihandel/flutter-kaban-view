library kaban_view;

export './kaban_column.dart';
export './kaban_item.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class KabanView extends StatelessWidget {
  const KabanView({super.key, required this.columns});
  final List<Widget> columns;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Container(
          color: Colors.amber,
          child: CustomScrollView(
            slivers: columns
                .map((e) => SliverFillRemaining(
                      child: e,
                    ))
                .toList(),
          ),
        ));
  }
}
