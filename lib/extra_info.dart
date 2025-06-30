import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/autogrid.dart';
import 'package:status_display/widgets/fading_scroll.dart';
import 'package:status_display/widgets/status_indicator.dart';

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
        Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              AutoGrid(
                crossAxisCount: 3,
                rowSpacing: 0,
                columnSpacing: 7,
                children: [
                  StatusIndicator.status(
                    status: robotData.netTables,
                    indicatorSize: 15,
                    indicatorRadius: 4,
                    label: "Net Tables",
                    labelStyle: bodySmall,
                    showBackground: true,
                  ),
                  StatusIndicator.bool(
                    boolean: robotData.comms,
                    indicatorSize: 15,
                    indicatorRadius: 4,
                    label: "Comms",
                    labelStyle: bodySmall,
                    showBackground: true,
                  ),
                  StatusIndicator.bool(
                    boolean: robotData.robotCode,
                    indicatorSize: 15,
                    indicatorRadius: 4,
                    label: "Robot Code",
                    labelStyle: bodySmall,
                    showBackground: true,
                  ),
                ],
              ),
              Divider(
                color: themeData.colorScheme.onSecondaryContainer,
                thickness: 0.25,
              ),
              AutoGrid(
                crossAxisCount: 2,
                rowSpacing: 0,
                columnSpacing: 7,
                children: [
                  StatusIndicator.alliance(
                    alliance: robotData.alliance,
                    indicatorSize: 15,
                    indicatorRadius: 4,
                    label: "Alliance - ${robotData.alliance?.name ?? "None"}",
                    labelStyle: bodySmall,
                    showBackground: true,
                  ),
                  StatusIndicator.robotMode(
                    robotMode: robotData.mode,
                    indicatorSize: 15,
                    indicatorRadius: 4,
                    label: "Mode - ${robotData.mode?.name ?? "None"}",
                    labelStyle: bodySmall,
                    showBackground: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children:
                        {
                          "Battery Voltage": robotData.batteryVoltageStatus,
                          "CAN Usage %": robotData.canUsageStatus,
                          "Robot CPU %": robotData.robotCpuUsageStatus,
                          "Robot RAM %": robotData.robotRamUsageStatus,
                        }.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: StatusIndicator.status(
                              status: entry.value,
                              indicatorSize: 15,
                              indicatorRadius: 4,
                              label: entry.key,
                              labelStyle: bodySmall,
                            ),
                          );
                        }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: VerticalDivider(
                    color: themeData.colorScheme.onSecondaryContainer,
                    thickness: 0.25,
                  ),
                ),
                Expanded(
                  child: Column(
                    children:
                        [
                          formatVoltageAsString(robotData.batteryVoltage),
                          formatPercentageAsString(robotData.canUsage),
                          formatPercentageAsString(robotData.robotCpuUsage),
                          formatPercentageAsString(robotData.robotRamUsage),
                        ].map((label) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                label,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: bodySmall,
                              ),
                            ),
                          );
                        }).toList(),
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
