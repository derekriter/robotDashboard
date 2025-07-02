import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/inspectable.dart';

class RobotDisplayWidget extends StatelessWidget {
  const RobotDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    late final Widget nineSeg;
    if (!appState.isNineSegReady) {
      nineSeg = Throbber(size: 40);
    } else {
      nineSeg = ScalableImageWidget(
        si: appState.nineSeg!.scalableImage!,
        fit: BoxFit.contain,
      );
    }

    late final Widget driver1;
    if (!appState.isDriver1Ready) {
      driver1 = Throbber();
    } else {
      driver1 = ScalableImageWidget(
        si: appState.driver1!.scalableImage!,
        fit: BoxFit.contain,
      );
    }

    late final Widget driver2;
    if (!appState.isDriver2Ready) {
      driver2 = Throbber();
    } else {
      driver2 = ScalableImageWidget(
        si: appState.driver2!.scalableImage!,
        fit: BoxFit.contain,
      );
    }

    final driver1Data =
        appState.robotData.controllers.driver1.getInspectionData();
    driver1Data.targetName = formatSubsystemFieldAsString(
      appState.robotData.controllers.name,
      driver1Data.targetName,
    );

    final driver2Data =
        appState.robotData.controllers.driver2.getInspectionData();
    driver2Data.targetName = formatSubsystemFieldAsString(
      appState.robotData.controllers.name,
      driver2Data.targetName,
    );

    return Column(
      spacing: 25,
      children: [
        Expanded(flex: 2, child: SizedBox.expand(child: nineSeg)),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              // color: Color.alphaBlend(
              //   appState.robotData.controllers.status.color.withAlpha(83),
              //   themeData.colorScheme.surface,
              // ),
              border: Border.all(
                color: appState.robotData.controllers.status.color,
                width: 8,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InspectableField(
                    data: driver1Data,
                    borderRadius: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: driver1,
                    ),
                  ),
                ),
                Expanded(
                  child: InspectableField(
                    data: driver2Data,
                    borderRadius: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: driver2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
