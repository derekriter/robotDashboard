import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';
import 'package:status_display/inspector.dart';

class InspectableField extends StatelessWidget {
  final Widget child;
  final InspectionData Function() data;
  final double borderRadius;

  const InspectableField({
    super.key,
    required this.child,
    required this.data,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    //InkWell requires an ancestor that is a material widget (or child of Material) in order for it's splash rendering to work correctly. Widgets such as Container will render over it, making the effect invisible. I just wrap the InkWell in an invisible Material widget to guarentee that it will work
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => appState.inspect(data),
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

abstract class InspectableData {
  InspectionData getInspectionData();
}
