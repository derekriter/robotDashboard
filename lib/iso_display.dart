import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';

class IsoDisplayWidget extends StatelessWidget {
  const IsoDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    late final Widget nineSeg;
    if (!appState.isNineSegReady) {
      nineSeg = Placeholder();
    } else {
      nineSeg = ScalableImageWidget(
        si: appState.nineSeg!.scalableImage!,
        fit: BoxFit.contain,
      );
    }

    return nineSeg;
  }
}
