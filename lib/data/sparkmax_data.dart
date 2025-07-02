import 'package:flutter/material.dart';
import 'package:status_display/data/hardware_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

import '../widgets/common_widgets.dart';

class SparkMaxFaults {
  bool can,
      escEeprom,
      firmware,
      gateDriver,
      motorType,
      other,
      rawBits,
      sensor,
      temperature;

  SparkMaxFaults({
    required this.can,
    required this.escEeprom,
    required this.firmware,
    required this.gateDriver,
    required this.motorType,
    required this.other,
    required this.rawBits,
    required this.sensor,
    required this.temperature,
  });

  bool get hasAny {
    return can ||
        escEeprom ||
        firmware ||
        gateDriver ||
        motorType ||
        other ||
        rawBits ||
        sensor ||
        temperature;
  }
}

class SparkMaxWarnings {
  bool brownout,
      escEeprom,
      extEeprom,
      hasReset,
      other,
      overcurrent,
      rawBits,
      sensor,
      stall;

  SparkMaxWarnings({
    required this.brownout,
    required this.escEeprom,
    required this.extEeprom,
    required this.hasReset,
    required this.other,
    required this.overcurrent,
    required this.rawBits,
    required this.sensor,
    required this.stall,
  });

  bool get hasAny {
    return brownout | escEeprom ||
        extEeprom ||
        hasReset ||
        other ||
        overcurrent ||
        rawBits ||
        sensor ||
        stall;
  }
}

class SparkMaxData extends HardwareData {
  static const tempWarningThreshold = 70; //Celsius

  int canID;
  double? outputVoltage;
  double? outputCurrent;
  double? relativePosition;
  double? relativeVelocity;
  SparkMaxFaults? faults;
  SparkMaxWarnings? warnings;
  double? motorTemp; //in Celsius
  String? firmwareVersion;

  SparkMaxData({
    required super.name,
    required this.canID,
    super.connected,
    this.outputVoltage,
    this.outputCurrent,
    this.relativePosition,
    this.relativeVelocity,
    this.faults,
    this.warnings,
    this.motorTemp,
    this.firmwareVersion,
  }) : super(modelName: "SparkMax");

  Status get _outputVoltageStatus =>
      outputVoltage == null ? Status.warning : Status.ok;
  Status get _outputCurrentStatus =>
      outputCurrent == null ? Status.warning : Status.ok;
  Status get _relativePositionStatus =>
      relativePosition == null ? Status.warning : Status.ok;
  Status get _relativeVelocityStatus =>
      relativeVelocity == null ? Status.warning : Status.ok;
  Status get _faultsStatus =>
      faults == null
          ? Status.warning
          : (faults!.hasAny ? Status.error : Status.ok);
  Status get _warningsStatus =>
      warnings == null
          ? Status.warning
          : (warnings!.hasAny ? Status.warning : Status.ok);
  Status get _motorTempStatus =>
      motorTemp == null
          ? Status.warning
          : (motorTemp! >= tempWarningThreshold ? Status.warning : Status.ok);
  Status get _firmwareVersionStatus =>
      firmwareVersion == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      basicStatus,
      _outputVoltageStatus,
      _outputCurrentStatus,
      _relativePositionStatus,
      _relativeVelocityStatus,
      _faultsStatus,
      _warningsStatus,
      _motorTempStatus,
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
          "Output Voltage",
          InspectorText(formatVoltageAsString(outputVoltage)),
          _outputVoltageStatus,
        ),
        InspectorProperty(
          "Output Current",
          InspectorText(formatAmpsAsString(outputCurrent)),
          _outputCurrentStatus,
        ),
        InspectorProperty(
          "Relative Position",
          InspectorText(formatRotationsAsString(relativePosition)),
          _relativePositionStatus,
        ),
        InspectorProperty(
          "Relative Velocity",
          InspectorText(formatRotsPerMinAsString(relativeVelocity)),
          _relativeVelocityStatus,
        ),
        InspectorProperty(
          "Motor Temperature",
          InspectorText(formatCelsiusAsString(motorTemp)),
          _motorTempStatus,
        ),
      ]),
      StatusTable([
        InspectorProperty(
          "CAN",
          SmallStatusIndicator.bool(
            boolean: faults?.can,
            label: formatBoolAsString(faults?.can),
          ),
          faults == null
              ? Status.warning
              : (faults!.can ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "escEEPROM",
          SmallStatusIndicator.bool(
            boolean: faults?.escEeprom,
            label: formatBoolAsString(faults?.escEeprom),
          ),
          faults == null
              ? Status.warning
              : (faults!.escEeprom ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Firmware",
          SmallStatusIndicator.bool(
            boolean: faults?.firmware,
            label: formatBoolAsString(faults?.firmware),
          ),
          faults == null
              ? Status.warning
              : (faults!.firmware ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Gate Driver",
          SmallStatusIndicator.bool(
            boolean: faults?.gateDriver,
            label: formatBoolAsString(faults?.gateDriver),
          ),
          faults == null
              ? Status.warning
              : (faults!.gateDriver ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Motor Type",
          SmallStatusIndicator.bool(
            boolean: faults?.motorType,
            label: formatBoolAsString(faults?.motorType),
          ),
          faults == null
              ? Status.warning
              : (faults!.motorType ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Raw Bits",
          SmallStatusIndicator.bool(
            boolean: faults?.rawBits,
            label: formatBoolAsString(faults?.rawBits),
          ),
          faults == null
              ? Status.warning
              : (faults!.rawBits ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Sensor",
          SmallStatusIndicator.bool(
            boolean: faults?.sensor,
            label: formatBoolAsString(faults?.sensor),
          ),
          faults == null
              ? Status.warning
              : (faults!.sensor ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Temperature",
          SmallStatusIndicator.bool(
            boolean: faults?.temperature,
            label: formatBoolAsString(faults?.temperature),
          ),
          faults == null
              ? Status.warning
              : (faults!.temperature ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Other",
          SmallStatusIndicator.bool(
            boolean: faults?.other,
            label: formatBoolAsString(faults?.other),
          ),
          faults == null
              ? Status.warning
              : (faults!.other ? Status.error : Status.ok),
        ),
      ], title: "Faults"),
      StatusTable([
        InspectorProperty(
          "Brownout",
          SmallStatusIndicator.bool(
            boolean: warnings?.brownout,
            label: formatBoolAsString(warnings?.brownout),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.brownout ? Status.warning : Status.ok),
        ),
        InspectorProperty(
          "escEEPROM",
          SmallStatusIndicator.bool(
            boolean: warnings?.escEeprom,
            label: formatBoolAsString(warnings?.escEeprom),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.escEeprom ? Status.warning : Status.ok),
        ),
        InspectorProperty(
          "extEEPROM",
          SmallStatusIndicator.bool(
            boolean: warnings?.extEeprom,
            label: formatBoolAsString(warnings?.extEeprom),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.extEeprom ? Status.warning : Status.ok),
        ),
        InspectorProperty(
          "Has Reset",
          SmallStatusIndicator.bool(
            boolean: warnings?.hasReset,
            label: formatBoolAsString(warnings?.hasReset),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.hasReset ? Status.warning : Status.ok),
        ),
        InspectorProperty(
          "Overcurrent",
          SmallStatusIndicator.bool(
            boolean: warnings?.overcurrent,
            label: formatBoolAsString(warnings?.overcurrent),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.overcurrent ? Status.warning : Status.ok),
        ),
        InspectorProperty(
          "Raw Bits",
          SmallStatusIndicator.bool(
            boolean: warnings?.rawBits,
            label: formatBoolAsString(warnings?.rawBits),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.rawBits ? Status.warning : Status.ok),
        ),
        InspectorProperty(
          "Sensor",
          SmallStatusIndicator.bool(
            boolean: warnings?.sensor,
            label: formatBoolAsString(warnings?.sensor),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.sensor ? Status.warning : Status.ok),
        ),
        InspectorProperty(
          "Stall",
          SmallStatusIndicator.bool(
            boolean: warnings?.stall,
            label: formatBoolAsString(warnings?.stall),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.stall ? Status.warning : Status.ok),
        ),
        InspectorProperty(
          "Other",
          SmallStatusIndicator.bool(
            boolean: warnings?.other,
            label: formatBoolAsString(warnings?.other),
          ),
          warnings == null
              ? Status.warning
              : (warnings!.other ? Status.warning : Status.ok),
        ),
      ], title: "Warnings"),
    ];
  }
}
