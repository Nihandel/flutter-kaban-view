import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class KabanColumn extends StatelessWidget {
  const KabanColumn(
      {super.key,
      this.title,
      this.trailing,
      this.children = const [],
      this.color,
      this.showHeader=true});

  final Widget? title;
  final Widget? trailing;
  final bool showHeader;
  final List<Widget> children;
  final Color? color;

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
            if(showHeader)
            SliverAppBar(
              expandedHeight: 70,
              title: title,
              floating: true,
              pinned: true,
              actions: trailing != null ? List.from([trailing]) : [],
            ),
            SliverList(delegate: SliverChildListDelegate(children))
          ],
        ),
      ),
    );
  }
}
