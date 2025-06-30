import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/autogrid.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/fading_scroll.dart';
import 'package:status_display/widgets/status_table.dart';

class ExtraInfoWidget extends StatelessWidget {
  const ExtraInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final robotData = appState.robotData;

    return FadingListView(
      fadePercentage: 0.25,
      padding: EdgeInsets.all(25),
      children: [
        ContainerCard(
          child: Column(
            children: [
              AutoGrid(
                crossAxisCount: 3,
                rowSpacing: 0,
                columnSpacing: 7,
                children: [
                  SmallStatusIndicator.status(
                    status: robotData.netTables,
                    label: "Net Tables",
                    showBackground: true,
                  ),
                  SmallStatusIndicator.bool(
                    boolean: robotData.comms,
                    label: "Comms",
                    showBackground: true,
                  ),
                  SmallStatusIndicator.bool(
                    boolean: robotData.robotCode,
                    label: "Robot Code",
                    showBackground: true,
                  ),
                ],
              ),
              CustomDivider(),
              AutoGrid(
                crossAxisCount: 2,
                rowSpacing: 0,
                columnSpacing: 7,
                children: [
                  SmallStatusIndicator.alliance(
                    alliance: robotData.alliance,
                    label:
                        "Alliance - ${formatStringAsString(robotData.alliance?.name)}",
                    showBackground: true,
                  ),
                  SmallStatusIndicator.robotMode(
                    robotMode: robotData.mode,
                    label:
                        "Mode - ${formatStringAsString(robotData.mode?.name)}",
                    showBackground: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        ContainerCard(
          child: StatusTable([
            StatusTableEntry(
              FadingText("Battery Voltage", style: bodySmall),
              SmallStatusIndicator.status(
                status: robotData.batteryVoltageStatus,
                label: formatVoltageAsString(robotData.batteryVoltage),
              ),
              robotData.batteryVoltageStatus,
            ),
            StatusTableEntry(
              FadingText("CAN Usage", style: bodySmall),
              SmallStatusIndicator.status(
                status: robotData.canUsageStatus,
                label: formatPercentageAsString(robotData.canUsage),
              ),
              robotData.canUsageStatus,
            ),
            StatusTableEntry(
              FadingText("Robot CPU Usage", style: bodySmall),
              SmallStatusIndicator.status(
                status: robotData.robotCpuUsageStatus,
                label: formatPercentageAsString(robotData.robotCpuUsage),
              ),
              robotData.robotCpuUsageStatus,
            ),
            StatusTableEntry(
              FadingText("Robot RAM Usage", style: bodySmall),
              SmallStatusIndicator.status(
                status: robotData.robotRamUsageStatus,
                label: formatPercentageAsString(robotData.robotRamUsage),
              ),
              robotData.robotRamUsageStatus,
            ),
          ]),
        ),
      ],
    );
  }
}
