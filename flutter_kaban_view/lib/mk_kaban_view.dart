import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layouts/constants.dart';
import 'package:layouts/responsive_layout.dart';
import 'package:mkassistent/provider/drag_status_provider.dart';
import 'package:mkassistent/shared/widgets/text/mk_text_widgets.dart';
import 'package:provider/provider.dart' as prv;

import 'mk_kaban_item.dart';
import 'mk_kaban_list.dart';

class MKKabanView<T extends Object> extends StatelessWidget {
  const MKKabanView({required this.stages, super.key});
  final List<MKKabanStage> stages;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder([
      ResponsiveBuilder(
          builder: (ctx) => MKKabanMobileView<T>(
                stages: stages,
              ),
          maxWidth: ScreenSizes.sm.size.toDouble()),
      ResponsiveBuilder(
        builder: (ctx) => MKKabanDesktopView<T>(
          stages: stages,
        ),
      ),
    ]);
  }
}

class MKKabanStage<T extends Object> {
  String title;
  List<MKKabanItem<T>> items;
  /// will recive the same tipe of MKKabanStage<T>
  /// but flutter give error specify T 
  Future<void> Function(dynamic value) onDragAccepted;
  void Function(MKKabanStage stage) onAddClicked;

  MKKabanStage({required this.title, required this.items, required this.onAddClicked, required this.onDragAccepted});
}

class MKKabanDesktopView<T extends Object> extends StatelessWidget {
  MKKabanDesktopView({required this.stages, super.key});
  final List<MKKabanStage> stages;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scrollbar(
        controller: _scrollController,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        thumbVisibility: true,
        thickness: 15,
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          shrinkWrap: false,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: stages.map((stage) => MKKabanList<T>(stage: stage)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MKKabanMobileView<T extends Object> extends ConsumerStatefulWidget {
  const MKKabanMobileView({required this.stages, super.key});
  final List<MKKabanStage> stages;

  @override
  ConsumerState<MKKabanMobileView<T>> createState() => _MKKabanMobileViewState<T>();
}

class _MKKabanMobileViewState<T extends Object> extends ConsumerState<MKKabanMobileView<T>> with TickerProviderStateMixin {
  bool isDraggedInside = false;
  late TabController tabController = TabController(length: widget.stages.length, vsync: this);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: widget.stages.length, vsync: this, initialIndex: ref.read(lastTabOpenProvider) ?? 0);
    tabController.addListener(() {
      setState(() {
        ref.watch(lastTabOpenProvider.notifier).setPage(tabController.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return prv.Consumer<DragStatusProvider<T>>(
      builder: (context, value, child) => Column(
        children: [
          TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: widget.stages
                  .map((e) => DragTarget<T>(
                        onMove: (details) => isDraggedInside = true,
                        onLeave: (data) => isDraggedInside = false,
                        onAccept: e.onDragAccepted,
                        builder: (context, candidateData, rejectedData) => Tab(
                          child: MKTextHeaderSmall(e.title),
                        ),
                      ))
                  .toList()),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: widget.stages
                .map((e) => MKKabanList<T>(
                      stage: e,
                      showHeader: false,
                    ))
                .toList(),
          ))
        ],
      ),
    );
  }
}

class LastTabOpenNotifier extends StateNotifier<int> {
  LastTabOpenNotifier() : super(0);
  setPage(int index) => state = index;
}

final lastTabOpenProvider = StateNotifierProvider<LastTabOpenNotifier, int>((ref) {
  return LastTabOpenNotifier();
});
