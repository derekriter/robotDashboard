import 'package:flutter/material.dart';
import 'package:status_display/data/hardware_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

class NavXData extends HardwareData {
  String? firmwareVersion;
  double? pitch;
  double? roll;
  double? yaw;
  double? accelX;
  double? accelY;
  double? accelZ;

  NavXData({
    required super.name,
    super.connected,
    this.firmwareVersion,
    this.pitch,
    this.roll,
    this.yaw,
  }) : super(modelName: "navX2-MXP");

  Status get _firmwareVersionStatus =>
      firmwareVersion == null ? Status.warning : Status.ok;
  Status get _pitchStatus => pitch == null ? Status.warning : Status.ok;
  Status get _rollStatus => roll == null ? Status.warning : Status.ok;
  Status get _yawStatus => yaw == null ? Status.warning : Status.ok;
  Status get _accelXStatus => accelX == null ? Status.warning : Status.ok;
  Status get _accelYStatus => accelY == null ? Status.warning : Status.ok;
  Status get _accelZStatus => accelZ == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      basicStatus,
      _firmwareVersionStatus,
      _pitchStatus,
      _rollStatus,
      _yawStatus,
      _accelXStatus,
      _accelYStatus,
      _accelZStatus,
    ].reduce(Status.maxPriority);
  }

  @override
  List<Widget> getAdvancedDetails() {
    return [
      StatusTable([
        InspectorProperty(
          "Firmware",
          InspectorText(formatStringAsString(firmwareVersion)),
          _firmwareVersionStatus,
        ),
      ]),
      StatusTable([
        InspectorProperty(
          "Pitch",
          InspectorText(formatDegreesAsString(pitch)),
          _pitchStatus,
        ),
        InspectorProperty(
          "Yaw",
          InspectorText(formatDegreesAsString(yaw)),
          _yawStatus,
        ),
        InspectorProperty(
          "Roll",
          InspectorText(formatDegreesAsString(roll)),
          _rollStatus,
        ),
        InspectorProperty(
          "World X Acceleration",
          InspectorText(formatGsAsString(accelX)),
          _accelXStatus,
        ),
        InspectorProperty(
          "World Y Acceleration",
          InspectorText(formatGsAsString(accelY)),
          _accelYStatus,
        ),
        InspectorProperty(
          "World Z Acceleration",
          InspectorText(formatGsAsString(accelZ)),
          _accelZStatus,
        ),
      ]),
    ];
  }
}
