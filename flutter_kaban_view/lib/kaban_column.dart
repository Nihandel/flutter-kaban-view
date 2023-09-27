import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class KabanColumn extends StatelessWidget {
  const KabanColumn({super.key,this.title, this.trailing,this.children = const [],this.color});
  final Widget? title;
  final Widget? trailing;
  final List<Widget> children;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Column(children: children),
    );
  }
}
