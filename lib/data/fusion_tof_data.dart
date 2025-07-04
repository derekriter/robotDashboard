import 'package:flutter/material.dart';
import 'package:status_display/data/hardware_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

enum FusionToFMode {
  long("Long"),
  medium("Medium"),
  short("Short");

  final String name;

  const FusionToFMode(this.name);

  @override
  String toString() {
    return name;
  }
}

class FusionToFData extends HardwareData {
  static const sigmaWarningThreshold = 30;

  int canID;
  FusionToFMode? mode;
  String? firmwareVersion;
  double? measuredDist;
  double? distSigma;
  double? sampleTime; //millis

  FusionToFData({
    required super.name,
    required this.canID,
    super.connected,
    this.mode,
    this.firmwareVersion,
    this.measuredDist,
    this.distSigma,
    this.sampleTime,
  }) : super(modelName: "PwF ToF Sensor");

  Status get _modeStatus => mode == null ? Status.warning : Status.ok;
  Status get _firmwareVersionStatus =>
      firmwareVersion == null ? Status.warning : Status.ok;
  Status get _measuredDistStatus =>
      measuredDist == null ? Status.warning : Status.ok;
  Status get _distSigmaStatus =>
      distSigma == null
          ? Status.warning
          : (distSigma! >= sigmaWarningThreshold ? Status.warning : Status.ok);
  Status get _sampleTimeStatus =>
      sampleTime == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      basicStatus,
      _modeStatus,
      _firmwareVersionStatus,
      _measuredDistStatus,
      _distSigmaStatus,
      _sampleTimeStatus,
    ].reduce(Status.maxPriority);
  }

  @override
  List<Widget> getAdvancedDetails() {
    return [
      StatusTable([
        InspectorProperty("CAN ID", InspectorText(canID.toString()), null),
        InspectorProperty(
          "Firmware",
          InspectorText(formatStringAsString(firmwareVersion)),
          _firmwareVersionStatus,
        ),
      ]),
      StatusTable([
        InspectorProperty(
          "Mode",
          InspectorText(formatStringAsString(mode?.toString())),
          _modeStatus,
        ),
        InspectorProperty(
          "Measured Distance",
          InspectorText(formatMillimetersAsString(measuredDist)),
          _measuredDistStatus,
        ),
        InspectorProperty(
          "Sigma",
          InspectorText(formatMillimetersAsString(distSigma)),
          _distSigmaStatus,
        ),
        InspectorProperty(
          "Sample Time",
          InspectorText(formatMillisecondsAsString(sampleTime)),
          _sampleTimeStatus,
        ),
      ]),
    ];
  }
}
