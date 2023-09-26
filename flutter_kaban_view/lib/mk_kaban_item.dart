import 'package:flutter/material.dart';

class MKKabanItem<T extends Object> extends StatefulWidget {
  const MKKabanItem({required this.child, required this.dragView, required this.value, required this.onItemDrop, super.key});
  final Widget child;
  final Widget dragView;
  final T value;
  final Future<void> Function(T value) onItemDrop;
  @override
  State<MKKabanItem<T>> createState() => _MKKabanItemState<T>();
}

class _MKKabanItemState<T extends Object> extends State<MKKabanItem<T>> {
  bool isBeingDragged = false;
  bool isDraggedInside = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<DragStatusProvider<T>>(
      builder: (context, dragStatusProvider, cld) => DragTarget<T>(
        onMove: (details) => isDraggedInside = true,
        onLeave: (data) => isDraggedInside = false,
        onAccept: (data) async => await widget.onItemDrop(data),
        builder: (context, candidateData, rejectedData) {
          var mobileDraggable = Container(
            decoration: BoxDecoration(border: isDraggedInside ? Border.all(color: Theme.of(context).primaryColorLight) : null),
            child: LongPressDraggable<T>(
              onDragStarted: () {
                isBeingDragged = true;
                dragStatusProvider.setDraggingStatus(true);
              },
              onDragCompleted: () {
                isBeingDragged = false;
                dragStatusProvider.setDraggingStatus(false);
              },
              onDraggableCanceled: (velocity, offset) {
                isBeingDragged = false;
                dragStatusProvider.setDraggingStatus(false);
              },
              data: widget.value,
              feedback: Material(
                child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      height: 200,
                      width: 200,
                      child: widget.dragView,
                    )),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 500),
                child: isBeingDragged
                    ? Opacity(
                        opacity: 0.5,
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          height: 200,
                        ))
                    : widget.child,
              ),
            ),
          );
          var draggable = Container(
            decoration: BoxDecoration(border: isDraggedInside ? Border.all(color: Theme.of(context).primaryColorLight) : null),
            child: Draggable<T>(
              onDragStarted: () {
                isBeingDragged = true;
                dragStatusProvider.setDraggingStatus(true);
              },
              onDragCompleted: () {
                isBeingDragged = false;
                dragStatusProvider.setDraggingStatus(false);
              },
              onDraggableCanceled: (velocity, offset) {
                isBeingDragged = false;
                dragStatusProvider.setDraggingStatus(false);
              },
              data: widget.value,
              feedback: Opacity(
                opacity: 0.5,
                child: Material(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: 200,
                    width: 200,
                    child: widget.dragView,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: (isBeingDragged
                    ? Opacity(
                        opacity: 0.5,
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          height: 200,
                        ))
                    : widget.child),
              ),
            ),
          );
          return isMobile() ? mobileDraggable : draggable;
        },
      ),
    );
  }
}
