import 'package:flutter/material.dart';
import 'package:status_display/data/hardware_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/inspector_widgets.dart';

class TalonFXFaults {
  bool bootDuringEnable,
      bridgeBrownout,
      deviceTemp,
      forwardHardLimit,
      forwardSoftLimit,
      fusionSensorOutOfSync,
      hardware,
      missingDifferential,
      missingHardLimitRemote,
      oversupplyVoltage,
      processorTemp,
      remoteSensorInvalidData,
      remoteSensorPositionOverflow,
      remoteSensorReset,
      reverseHardLimit,
      reverseSoftLimit,
      staticBrakeDisabled,
      statorOvercurrent,
      supplyOvercurrent,
      undervoltage,
      unlicensedFeatureInUse,
      unstableSupplyVoltage,
      unlicensedFusedCANcoderFeature;

  TalonFXFaults({
    required this.bootDuringEnable,
    required this.bridgeBrownout,
    required this.deviceTemp,
    required this.forwardHardLimit,
    required this.forwardSoftLimit,
    required this.fusionSensorOutOfSync,
    required this.hardware,
    required this.missingDifferential,
    required this.missingHardLimitRemote,
    required this.oversupplyVoltage,
    required this.processorTemp,
    required this.remoteSensorInvalidData,
    required this.remoteSensorPositionOverflow,
    required this.remoteSensorReset,
    required this.reverseHardLimit,
    required this.reverseSoftLimit,
    required this.staticBrakeDisabled,
    required this.statorOvercurrent,
    required this.supplyOvercurrent,
    required this.undervoltage,
    required this.unlicensedFeatureInUse,
    required this.unstableSupplyVoltage,
    required this.unlicensedFusedCANcoderFeature,
  });

  bool get hasAny {
    return bootDuringEnable ||
        bridgeBrownout ||
        deviceTemp ||
        forwardHardLimit ||
        forwardSoftLimit ||
        fusionSensorOutOfSync ||
        hardware ||
        missingDifferential ||
        missingHardLimitRemote ||
        oversupplyVoltage ||
        processorTemp ||
        remoteSensorInvalidData ||
        remoteSensorPositionOverflow ||
        remoteSensorReset ||
        reverseHardLimit ||
        reverseSoftLimit ||
        staticBrakeDisabled ||
        statorOvercurrent ||
        undervoltage ||
        unlicensedFeatureInUse ||
        unstableSupplyVoltage ||
        unlicensedFusedCANcoderFeature;
  }
}

class TalonFXData extends HardwareData {
  static const tempWarningThreshold = 70; //Celsius

  int canID;
  TalonFXFaults? faults;
  double? deviceTemp; //Celsius
  double? outputVoltage;
  double? outputCurrent;
  double? relativePosition;
  double? relativeVelocity;
  String? firmwareVersion;

  TalonFXData({
    required super.name,
    required super.connected,
    required this.canID,
    this.faults,
    this.deviceTemp,
    this.outputVoltage,
    this.outputCurrent,
    this.relativePosition,
    this.relativeVelocity,
    this.firmwareVersion,
  }) : super(modelName: "TalonFX");

  Status get _faultsStatus =>
      faults == null
          ? Status.warning
          : (faults!.hasAny ? Status.error : Status.ok);
  Status get _deviceTempStatus =>
      deviceTemp == null
          ? Status.warning
          : (deviceTemp! >= tempWarningThreshold ? Status.warning : Status.ok);
  Status get _outputVoltageStatus =>
      outputVoltage == null ? Status.warning : Status.ok;
  Status get _outputCurrentStatus =>
      outputCurrent == null ? Status.warning : Status.ok;
  Status get _relativePositionStatus =>
      relativePosition == null ? Status.warning : Status.ok;
  Status get _relativeVelocityStatus =>
      relativeVelocity == null ? Status.warning : Status.ok;
  Status get _firmwareVersionStatus =>
      firmwareVersion == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      basicStatus,
      _faultsStatus,
      _deviceTempStatus,
      _outputVoltageStatus,
      _outputCurrentStatus,
      _relativePositionStatus,
      _relativeVelocityStatus,
      _firmwareVersionStatus,
    ].reduce(Status.maxPriority);
  }

  @override
  List<Widget> getAdvancedDetails() {
    return [
      InspectorPropertyList([
        InspectorProperty("CAN ID", InspectorText(canID.toString()), null),
        InspectorProperty(
          "Firmware",
          InspectorText(formatStringAsString(firmwareVersion)),
          _firmwareVersionStatus,
        ),
      ]),
      InspectorPropertyList([
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
          InspectorText(formatRotsPerSecAsString(relativeVelocity)),
          _relativeVelocityStatus,
        ),
        InspectorProperty(
          "Device Temperature",
          InspectorText(formatCelsiusAsString(deviceTemp)),
          _deviceTempStatus,
        ),
      ]),
      InspectorPropertyList([
        InspectorProperty(
          "Boot During Enable",
          InspectorStatusIndicator.bool(
            boolean: faults?.bootDuringEnable,
            label: formatBoolAsString(faults?.bootDuringEnable),
          ),
          faults == null
              ? Status.warning
              : (faults!.bootDuringEnable ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Bridge Brownout",
          InspectorStatusIndicator.bool(
            boolean: faults?.bridgeBrownout,
            label: formatBoolAsString(faults?.bridgeBrownout),
          ),
          faults == null
              ? Status.warning
              : (faults!.bridgeBrownout ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Device Temperature",
          InspectorStatusIndicator.bool(
            boolean: faults?.deviceTemp,
            label: formatBoolAsString(faults?.deviceTemp),
          ),
          faults == null
              ? Status.warning
              : (faults!.deviceTemp ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Forward Hard Limit",
          InspectorStatusIndicator.bool(
            boolean: faults?.forwardHardLimit,
            label: formatBoolAsString(faults?.forwardHardLimit),
          ),
          faults == null
              ? Status.warning
              : (faults!.forwardHardLimit ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Forward Soft Limit",
          InspectorStatusIndicator.bool(
            boolean: faults?.forwardSoftLimit,
            label: formatBoolAsString(faults?.forwardSoftLimit),
          ),
          faults == null
              ? Status.warning
              : (faults!.forwardSoftLimit ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Fusion Sensor Out Of Sync",
          InspectorStatusIndicator.bool(
            boolean: faults?.fusionSensorOutOfSync,
            label: formatBoolAsString(faults?.fusionSensorOutOfSync),
          ),
          faults == null
              ? Status.warning
              : (faults!.fusionSensorOutOfSync ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Hardware",
          InspectorStatusIndicator.bool(
            boolean: faults?.hardware,
            label: formatBoolAsString(faults?.hardware),
          ),
          faults == null
              ? Status.warning
              : (faults!.hardware ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Missing Differential",
          InspectorStatusIndicator.bool(
            boolean: faults?.missingDifferential,
            label: formatBoolAsString(faults?.missingDifferential),
          ),
          faults == null
              ? Status.warning
              : (faults!.missingDifferential ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Missing Hard Limit Remote",
          InspectorStatusIndicator.bool(
            boolean: faults?.missingHardLimitRemote,
            label: formatBoolAsString(faults?.missingHardLimitRemote),
          ),
          faults == null
              ? Status.warning
              : (faults!.missingHardLimitRemote ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Oversupply Voltage",
          InspectorStatusIndicator.bool(
            boolean: faults?.oversupplyVoltage,
            label: formatBoolAsString(faults?.oversupplyVoltage),
          ),
          faults == null
              ? Status.warning
              : (faults!.oversupplyVoltage ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Processor Temperature",
          InspectorStatusIndicator.bool(
            boolean: faults?.processorTemp,
            label: formatBoolAsString(faults?.processorTemp),
          ),
          faults == null
              ? Status.warning
              : (faults!.processorTemp ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Remote Sensor Invalid Data",
          InspectorStatusIndicator.bool(
            boolean: faults?.remoteSensorInvalidData,
            label: formatBoolAsString(faults?.remoteSensorInvalidData),
          ),
          faults == null
              ? Status.warning
              : (faults!.remoteSensorInvalidData ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Remote Sensor Position Overflow",
          InspectorStatusIndicator.bool(
            boolean: faults?.remoteSensorPositionOverflow,
            label: formatBoolAsString(faults?.remoteSensorPositionOverflow),
          ),
          faults == null
              ? Status.warning
              : (faults!.remoteSensorPositionOverflow
                  ? Status.error
                  : Status.ok),
        ),
        InspectorProperty(
          "Remote Sensor Reset",
          InspectorStatusIndicator.bool(
            boolean: faults?.remoteSensorReset,
            label: formatBoolAsString(faults?.remoteSensorReset),
          ),
          faults == null
              ? Status.warning
              : (faults!.remoteSensorReset ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Reverse Hard Limit",
          InspectorStatusIndicator.bool(
            boolean: faults?.reverseHardLimit,
            label: formatBoolAsString(faults?.reverseHardLimit),
          ),
          faults == null
              ? Status.warning
              : (faults!.reverseHardLimit ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Reverse Soft Limit",
          InspectorStatusIndicator.bool(
            boolean: faults?.reverseSoftLimit,
            label: formatBoolAsString(faults?.reverseSoftLimit),
          ),
          faults == null
              ? Status.warning
              : (faults!.reverseSoftLimit ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Static Brake Disabled",
          InspectorStatusIndicator.bool(
            boolean: faults?.staticBrakeDisabled,
            label: formatBoolAsString(faults?.staticBrakeDisabled),
          ),
          faults == null
              ? Status.warning
              : (faults!.staticBrakeDisabled ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Stator Overcurrent",
          InspectorStatusIndicator.bool(
            boolean: faults?.statorOvercurrent,
            label: formatBoolAsString(faults?.statorOvercurrent),
          ),
          faults == null
              ? Status.warning
              : (faults!.statorOvercurrent ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Supply Overcurrent",
          InspectorStatusIndicator.bool(
            boolean: faults?.supplyOvercurrent,
            label: formatBoolAsString(faults?.supplyOvercurrent),
          ),
          faults == null
              ? Status.warning
              : (faults!.supplyOvercurrent ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Undervoltage",
          InspectorStatusIndicator.bool(
            boolean: faults?.undervoltage,
            label: formatBoolAsString(faults?.undervoltage),
          ),
          faults == null
              ? Status.warning
              : (faults!.undervoltage ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Unlicensed Feature In Use",
          InspectorStatusIndicator.bool(
            boolean: faults?.unlicensedFeatureInUse,
            label: formatBoolAsString(faults?.unlicensedFeatureInUse),
          ),
          faults == null
              ? Status.warning
              : (faults!.unlicensedFeatureInUse ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Unstable Supply Voltage",
          InspectorStatusIndicator.bool(
            boolean: faults?.unstableSupplyVoltage,
            label: formatBoolAsString(faults?.unstableSupplyVoltage),
          ),
          faults == null
              ? Status.warning
              : (faults!.unstableSupplyVoltage ? Status.error : Status.ok),
        ),
        InspectorProperty(
          "Unlicensed Fused CANcoder Feature",
          InspectorStatusIndicator.bool(
            boolean: faults?.unlicensedFusedCANcoderFeature,
            label: formatBoolAsString(faults?.unlicensedFusedCANcoderFeature),
          ),
          faults == null
              ? Status.warning
              : (faults!.unlicensedFusedCANcoderFeature
                  ? Status.error
                  : Status.ok),
        ),
      ], title: "Faults"),
    ];
  }
}
