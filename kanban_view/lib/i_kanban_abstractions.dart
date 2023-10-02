import 'package:flutter/material.dart';

abstract class IKanbanColumn extends Widget{
  late final double? flex;
  late final double? minWidth;
  late final double? maxWidth;
  IKanbanColumn({this.flex, this.minWidth, this.maxWidth});
}
