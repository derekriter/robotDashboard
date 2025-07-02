import 'package:flutter/material.dart';
import 'package:status_display/data/hardware_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

class CANCoderFaults {
  bool badMagnet,
      bootDuringEnable,
      hardware,
      undervoltage,
      unlicensedFeatureInUse;

  CANCoderFaults({
    required this.badMagnet,
    required this.bootDuringEnable,
    required this.hardware,
    required this.undervoltage,
    required this.unlicensedFeatureInUse,
  });

  bool get hasAny {
    return badMagnet ||
        bootDuringEnable ||
        hardware ||
        undervoltage ||
        unlicensedFeatureInUse;
  }
}

enum CANCoderMagnetHealth {
  green("Green", Colors.green),
  orange("Orange", Colors.amber),
  red("Red", Colors.red),
  invalid("Invalid", Colors.purple);

  final String name;
  final Color color;

  const CANCoderMagnetHealth(this.name, this.color);

  @override
  String toString() {
    return name;
  }
}

class CANCoderData extends HardwareData {
  int canID;
  double? absolutePosition;
  CANCoderFaults? faults;
  CANCoderMagnetHealth? magnetHealth;
  double? relativePosition;
  double? velocity;
  String? firmwareVersion;

  CANCoderData({
    required super.name,
    required this.canID,
    super.connected,
    this.absolutePosition,
    this.faults,
    this.magnetHealth,
    this.relativePosition,
    this.velocity,
    this.firmwareVersion,
  }) : super(modelName: "CANcoder");

  Status get _absolutePositionStatus =>
      absolutePosition == null ? Status.warning : Status.ok;
  Status get _faultsStatus =>
      faults == null
          ? Status.warning
          : (faults!.hasAny ? Status.error : Status.ok);
  Status get _magnetHealthStatus =>
      magnetHealth == null
          ? Status.warning
          : (magnetHealth == CANCoderMagnetHealth.red ||
                  magnetHealth == CANCoderMagnetHealth.invalid
              ? Status.error
              : Status.ok);
  Status get _relativePositionStatus =>
      relativePosition == null ? Status.warning : Status.ok;
  Status get _velocityStatus => velocity == null ? Status.warning : Status.ok;
  Status get _firmwareVersionStatus =>
      firmwareVersion == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      basicStatus,
      _absolutePositionStatus,
      _faultsStatus,
      _magnetHealthStatus,
      _relativePositionStatus,
      _velocityStatus,
      _firmwareVersionStatus,
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
          "Absolute Position",
          InspectorText(formatRotationsAsString(absolutePosition)),
          _absolutePositionStatus,
        ),
        InspectorProperty(
          "Relative Position",
          InspectorText(formatRotationsAsString(relativePosition)),
          _relativePositionStatus,
        ),
        InspectorProperty(
          "Velocity",
          InspectorText(formatRotsPerSecAsString(velocity)),
          _velocityStatus,
        ),
        InspectorProperty(
          "Magnet Health",
          SmallStatusIndicator.canCoderMagnetHealth(
            health: magnetHealth,
            label: formatStringAsString(magnetHealth?.name),
          ),
          _magnetHealthStatus,
        ),
      ]),
      StatusTable([
        InspectorProperty(
          "Bad Magnet",
          SmallStatusIndicator.bool(
            boolean: faults?.badMagnet,
            label: formatBoolAsString(faults?.badMagnet),
          ),
          faults == null
              ? Status.warning
              : (faults!.badMagnet ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Boot During Enable",
          SmallStatusIndicator.bool(
            boolean: faults?.bootDuringEnable,
            label: formatBoolAsString(faults?.bootDuringEnable),
          ),
          faults == null
              ? Status.warning
              : (faults!.bootDuringEnable ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Hardware",
          SmallStatusIndicator.bool(
            boolean: faults?.hardware,
            label: formatBoolAsString(faults?.hardware),
          ),
          faults == null
              ? Status.warning
              : (faults!.hardware ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Undervoltage",
          SmallStatusIndicator.bool(
            boolean: faults?.undervoltage,
            label: formatBoolAsString(faults?.undervoltage),
          ),
          faults == null
              ? Status.warning
              : (faults!.undervoltage ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Unlicensed Feature In Use",
          SmallStatusIndicator.bool(
            boolean: faults?.unlicensedFeatureInUse,
            label: formatBoolAsString(faults?.unlicensedFeatureInUse),
          ),
          faults == null
              ? Status.warning
              : (faults!.unlicensedFeatureInUse ? Status.error : Status.ok),
        ),
      ], title: "Faults"),
    ];
  }
}
