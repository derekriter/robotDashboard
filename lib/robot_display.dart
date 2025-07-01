import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';
import 'package:status_display/data/theme_data.dart';

class RobotDisplayWidget extends StatelessWidget {
  const RobotDisplayWidget({super.key});

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

    late final Widget driver1;
    if (!appState.isDriver1Ready) {
      driver1 = Placeholder();
    } else {
      driver1 = ScalableImageWidget(
        si: appState.driver1!.scalableImage!,
        fit: BoxFit.contain,
      );
    }

    late final Widget driver2;
    if (!appState.isDriver2Ready) {
      driver2 = Placeholder();
    } else {
      driver2 = ScalableImageWidget(
        si: appState.driver2!.scalableImage!,
        fit: BoxFit.contain,
      );
    }

    return Column(
      spacing: 25,
      children: [
        Expanded(flex: 2, child: SizedBox.expand(child: nineSeg)),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color.alphaBlend(
                appState.robotData.controllers.status.color.withAlpha(83),
                themeData.colorScheme.surface,
              ),
              border: Border.all(
                color: appState.robotData.controllers.status.color,
                width: 8,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20 - 8),
            child: Row(
              spacing: 25,
              children: [Expanded(child: driver1), Expanded(child: driver2)],
            ),
          ),
        ),
      ],
    );
  }
}
