import 'package:flutter/material.dart';
import 'package:mkassistent/shared/widgets/text/mk_text_widgets.dart';
import 'package:provider/provider.dart' as prv;

import '../../../logger/mk_logger.dart';
import '../../../provider/drag_status_provider.dart';
import 'mk_kaban_view.dart';

class MKKabanList<T extends Object> extends StatelessWidget {
  const MKKabanList({required this.stage, this.showHeader = true, super.key});
  final MKKabanStage stage;
  final bool showHeader;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 300),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showHeader) Padding(
            padding: const EdgeInsets.all(8.0),
            child: MKKabanListTitle<T>(stage: stage),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) => stage.items[index],
                shrinkWrap: true,
                itemCount: stage.items.length),
          ),
        ],
      ),
    );
  }
}

class MKKabanListTitle<T extends Object> extends StatefulWidget {
  const MKKabanListTitle({required this.stage, super.key});
  final MKKabanStage stage;

  @override
  State<MKKabanListTitle<T>> createState() => _MKKabanListTitleState<T>();
}

class _MKKabanListTitleState<T extends Object>
    extends State<MKKabanListTitle<T>> {
  var key = GlobalKey();
  bool isDraggedInside = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(builder: (context) {
      return prv.Consumer<DragStatusProvider<T>>(
        builder: (context, ref, child) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: ref.isDragging ? 100 : 50,
          curve: Curves.easeIn,
          child: DragTarget<T>(
            key: key,
            onMove: (details) => isDraggedInside = true,
            onLeave: (data) => isDraggedInside = false,
            onAccept: (T data) async {
              logger.debug("Drag onAccept", "mk kaban list");
              await widget.stage.onDragAccepted(data);
            },
            builder: (context, candidateData, rejectedData) => Container(
              decoration: BoxDecoration(
                color: isDraggedInside
                    ? theme.primaryColorLight
                    : theme.primaryColor,
                border: Border(bottom: BorderSide(color: theme.primaryColor)),
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MKTextHeaderMedium(widget.stage.title),
                    ),
                  ),
                  IconButton(
                      onPressed: () => widget.stage.onAddClicked(widget.stage),
                      icon: const Icon(Icons.add))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
