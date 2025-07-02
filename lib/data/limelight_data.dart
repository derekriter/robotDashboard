import 'package:flutter/material.dart';
import 'package:status_display/data/hardware_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

import '../widgets/common_widgets.dart';

class LimelightData extends HardwareData {
  bool? serverRunning;
  bool? aprilTagRecognitionRunning;
  bool? poseEstimationRunning;
  int? pipeline;
  String? firmwareVersion;

  LimelightData({
    required super.name,
    required super.modelName, //allow different versions of limelights
    super.connected,
    this.serverRunning,
    this.aprilTagRecognitionRunning,
    this.poseEstimationRunning,
    this.pipeline,
    this.firmwareVersion,
  });

  Status get _serverRunningStatus =>
      serverRunning == null
          ? Status.warning
          : (serverRunning! ? Status.ok : Status.error);
  Status get _aprilTagRecognitionRunningStatus =>
      aprilTagRecognitionRunning == null
          ? Status.warning
          : (aprilTagRecognitionRunning! ? Status.ok : Status.error);
  Status get _poseEstimationRunningStatus =>
      poseEstimationRunning == null
          ? Status.warning
          : (poseEstimationRunning! ? Status.ok : Status.error);
  Status get _pipelineStatus => pipeline == null ? Status.warning : Status.ok;
  Status get _firmwareVersionStatus =>
      firmwareVersion == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      basicStatus,
      _serverRunningStatus,
      _aprilTagRecognitionRunningStatus,
      _poseEstimationRunningStatus,
      _pipelineStatus,
      _firmwareVersionStatus,
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
          "Pipeline",
          InspectorText(formatIntAsString(pipeline)),
          _pipelineStatus,
        ),
        InspectorProperty(
          "Server Running",
          SmallStatusIndicator.bool(
            boolean: serverRunning,
            label: formatBoolAsString(serverRunning),
          ),
          _serverRunningStatus,
        ),
        InspectorProperty(
          "AprilTag Recognition Running",
          SmallStatusIndicator.bool(
            boolean: aprilTagRecognitionRunning,
            label: formatBoolAsString(aprilTagRecognitionRunning),
          ),
          _aprilTagRecognitionRunningStatus,
        ),
        InspectorProperty(
          "Pose Estimation Running",
          SmallStatusIndicator.bool(
            boolean: poseEstimationRunning,
            label: formatBoolAsString(poseEstimationRunning),
          ),
          _poseEstimationRunningStatus,
        ),
      ]),
    ];
  }
}
