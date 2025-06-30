import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';
import 'package:status_display/data/command_data.dart';
import 'package:status_display/data/controller_data.dart';
import 'package:status_display/data/hardware_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/subsystem_data.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/widgets/autogrid.dart';
import 'package:status_display/widgets/fading_scroll.dart';
import 'package:status_display/widgets/inspectable.dart';
import 'package:status_display/widgets/status_indicator.dart';

class SubsystemsDisplayWidget extends StatelessWidget {
  const SubsystemsDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    final robotData = appState.robotData;

    return FadingSingleChildScrollView(
      fadePercentage: 0.2,
      padding: EdgeInsets.all(25),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          SubsystemCard(subsystem: robotData.swerve, columns: 4),
          SubsystemCard(subsystem: robotData.elev, columns: 1),
          SubsystemCard(subsystem: robotData.shooter, columns: 3),
          SubsystemCard(subsystem: robotData.intake, columns: 2),
          SubsystemCard(subsystem: robotData.climber, columns: 2),
          SubsystemCard(subsystem: robotData.algaeRem, columns: 1),
          SubsystemCard(subsystem: robotData.vision, columns: 3),
          SubsystemCard(subsystem: robotData.leds, columns: 1),
          SubsystemCard(subsystem: robotData.controllers, columns: 2),
        ],
      ),
    );
  }
}

class SubsystemDetail {
  final String name;
  final Status status;
  final InspectableData data;

  const SubsystemDetail({
    required this.name,
    required this.status,
    required this.data,
  });

  static SubsystemDetail fromHardware(HardwareData hardware) {
    return SubsystemDetail(
      name: hardware.name,
      status: hardware.status,
      data: hardware,
    );
  }

  static SubsystemDetail fromCommand(CommandData command) {
    return SubsystemDetail(
      name: command.name,
      status: command.status,
      data: command,
    );
  }

  static SubsystemDetail fromController(ControllerData controller) {
    return SubsystemDetail(
      name: controller.name,
      status: controller.status,
      data: controller,
    );
  }
}

class SubsystemCard extends StatelessWidget {
  final SubsystemData subsystem;
  final int columns;

  const SubsystemCard({
    super.key,
    required this.subsystem,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    final details = subsystem.getDetails();

    late final List<Widget> detailsDisplay;
    if (details.isEmpty) {
      detailsDisplay = [];
    } else {
      detailsDisplay = [
        Divider(
          color: themeData.colorScheme.onSecondaryContainer,
          thickness: 0.25,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: double.maxFinite),
          child: AutoGrid(
            crossAxisCount: columns,
            rowSpacing: 7,
            columnSpacing: 7,
            children:
                details.map((detail) {
                  final data = detail.data.getInspectionData();
                  data.targetName = "${subsystem.name} > ${data.targetName}";

                  return InspectableField(
                    data: data,
                    borderRadius: 4,
                    child: StatusIndicator.status(
                      status: detail.status,
                      indicatorSize: 15,
                      indicatorRadius: 4,
                      label: detail.name,
                      labelStyle: bodySmall,
                      showBackground: true,
                    ),
                  );
                }).toList(),
          ),
        ),
      ];
    }

    return Container(
      decoration: BoxDecoration(
        color: themeData.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          InspectableField(
            data: subsystem.getInspectionData(),
            borderRadius: 8,
            child: StatusIndicator.status(
              status: subsystem.status,
              indicatorSize: 25,
              indicatorRadius: 8,
              label: subsystem.name,
              labelStyle: titleMedium,
            ),
          ),
          ...detailsDisplay,
        ],
      ),
    );
  }
}
