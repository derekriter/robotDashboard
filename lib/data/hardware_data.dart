import 'package:flutter/material.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/inspector.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/inspectable.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

abstract class HardwareData extends InspectableData {
  final String name; //eg. FL Drive
  final String modelName; //eg. SparkMax
  bool connected;

  HardwareData({
    required this.name,
    required this.modelName,
    required this.connected,
  });

  Status get status;

  Status get connectedStatus => connected ? Status.ok : Status.error;

  Status get basicStatus => connectedStatus;

  @override
  InspectionData getInspectionData() {
    return InspectionData(
      targetName: "$name ($modelName)",
      properties: [...getBasicDetails(), ...getAdvancedDetails()],
    );
  }

  List<Widget> getBasicDetails() {
    return [
      StatusTable([
        InspectorProperty(
          "Hardware Status",
          SmallStatusIndicator.status(status: status, label: status.toString()),
          null,
        ),
        InspectorProperty(
          "Connected",
          SmallStatusIndicator.bool(
            boolean: connected,
            label: formatBoolAsString(connected),
          ),
          connectedStatus,
        ),
      ]),
    ];
  }

  List<Widget> getAdvancedDetails();
}
