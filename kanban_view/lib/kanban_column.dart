import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// class KabanColumnHeader extends StatelessWidget {
//   const KabanColumnHeader({super.key, this.title, this.trailing, this.bottom});
//   final Widget? title;
//   final Widget? trailing;
//   final PreferredSizeWidget? bottom;
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       expandedHeight: 70,
//       title: title,
//       floating: true,
//       pinned: true,
//       actions: trailing != null ? List.from([trailing]) : [],
//       bottom: bottom,
//     );
//   }
// }

class KabanColumn extends StatelessWidget {
  const KabanColumn(
      {super.key,
      this.header,
      required this.children,
      this.maxWidth,
      this.minWidth,
      this.flex,
      this.color})
      : assert(flex != null || maxWidth != null,
            "Provide flex or maxwidth parameter");
  final SliverAppBar? header;
  final List<Widget> children;
  final Color? color;
  final double? maxWidth;
  final double? minWidth;
  final double? flex;
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
            if(header!=null)
              header!,
            SliverList(delegate: SliverChildListDelegate(children))
          ],
        ),
      ),
    );
  }
}
