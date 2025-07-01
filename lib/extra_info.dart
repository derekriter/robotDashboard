import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/fading_scroll.dart';
import 'package:status_display/widgets/status_table.dart';

class ExtraInfoWidget extends StatelessWidget {
  const ExtraInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final robotData = appState.robotData;

    return FadingSingleChildScrollView(
      fadePercentage: 0.25,
      padding: EdgeInsets.all(25),
      child: ContainerCard(
        child: Column(
          spacing: 8,
          children: [
            StatusTable([
              StatusTableEntry(
                FadingText("Net Tables", style: bodySmall),
                SmallStatusIndicator.status(
                  status: robotData.netTables,
                  label: robotData.netTables.toString(),
                ),
                robotData.netTables,
              ),
              StatusTableEntry(
                FadingText("Comms", style: bodySmall),
                SmallStatusIndicator.bool(
                  boolean: robotData.comms,
                  label:
                      robotData.comms == null
                          ? "Unknown"
                          : (robotData.comms! ? "Connected" : "Disconnected"),
                ),
                robotData.commsStatus,
              ),
              StatusTableEntry(
                FadingText("Robot Code", style: bodySmall),
                SmallStatusIndicator.bool(
                  boolean: robotData.robotCode,
                  label:
                      robotData.robotCode == null
                          ? "Unknown"
                          : (robotData.robotCode! ? "Ok" : "Error"),
                ),
                robotData.robotCodeStatus,
              ),
            ]),
            StatusTable([
              StatusTableEntry(
                FadingText("Mode", style: bodySmall),
                SmallStatusIndicator.robotMode(
                  robotMode: robotData.mode,
                  label: robotData.mode?.toString() ?? "Unknown",
                ),
                robotData.modeStatus,
              ),
              StatusTableEntry(
                FadingText("Alliance", style: bodySmall),
                SmallStatusIndicator.alliance(
                  alliance: robotData.alliance,
                  label: robotData.alliance?.toString() ?? "Unknown",
                ),
                robotData.allianceStatus,
              ),
            ]),
            StatusTable([
              StatusTableEntry(
                FadingText("Battery Voltage", style: bodySmall),
                FadingText(
                  formatVoltageAsString(robotData.batteryVoltage),
                  style: bodySmall,
                ),
                robotData.batteryVoltageStatus,
              ),
              StatusTableEntry(
                FadingText("CAN Usage", style: bodySmall),
                FadingText(
                  formatPercentageAsString(robotData.canUsage),
                  style: bodySmall,
                ),
                robotData.canUsageStatus,
              ),
              StatusTableEntry(
                FadingText("Robot CPU Usage", style: bodySmall),
                FadingText(
                  formatPercentageAsString(robotData.robotCpuUsage),
                  style: bodySmall,
                ),
                robotData.robotCpuUsageStatus,
              ),
              StatusTableEntry(
                FadingText("Robot RAM Usage", style: bodySmall),
                FadingText(
                  formatPercentageAsString(robotData.robotRamUsage),
                  style: bodySmall,
                ),
                robotData.robotRamUsageStatus,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
