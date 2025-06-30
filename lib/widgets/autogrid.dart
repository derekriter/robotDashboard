import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class AutoGrid extends StatelessWidget {
  final int crossAxisCount;
  final List<Widget> children;
  final double rowSpacing;
  final double columnSpacing;

  const AutoGrid({
    super.key,
    required this.crossAxisCount,
    required this.children,
    required this.rowSpacing,
    required this.columnSpacing,
  }) : assert(crossAxisCount >= 1, "crossAxisCount must be >= 1");

  @override
  Widget build(BuildContext context) {
    //dart doesn't use integer division
    final rowCount = max((children.length / crossAxisCount).ceil(), 1);

    return LayoutGrid(
      columnSizes: List.filled(
        crossAxisCount,
        1.fr,
      ), //equal column distribution
      rowSizes: List.filled(rowCount, auto), //auto sizing rows
      rowGap: rowSpacing,
      columnGap: columnSpacing,
      gridFit: GridFit.loose,
      children: children,
    );
  }
}
