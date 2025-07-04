import 'package:flutter/material.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/inspector.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/inspectable.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

enum RunningStatus {
  running("Running"),
  finished("Finished"),
  interrupted("Interrupted");

  final String name;

  const RunningStatus(this.name);

  @override
  String toString() {
    return name;
  }
}

abstract class CommandData extends InspectableData {
  final String name;
  final List<String> requires;
  RunningStatus? running;

  CommandData({required this.name, required this.requires, this.running});

  Status get status;

  Status get runningStatus {
    switch (running) {
      case null:
        return Status.warning;
      case RunningStatus.running:
        return Status.ok;
      case RunningStatus.finished:
        return Status.error;
      case RunningStatus.interrupted:
        return Status.warning;
    }
  }

  Status get basicStatus => runningStatus;

  @override
  InspectionData getInspectionData() {
    return InspectionData(
      targetName: "$name (Command)",
      properties: [...getBasicDetails(), ...getAdvancedDetails()],
    );
  }

  List<Widget> getBasicDetails() {
    return [
      StatusTable([
        InspectorProperty(
          "Command Status",
          SmallStatusIndicator.status(status: status, label: status.toString()),
          null,
        ),
        InspectorProperty(
          "Requires",
          InspectorText(
            requires.fold("", (prev, current) {
              if (prev.isEmpty) return current;

              return "$prev, $current";
            }),
          ),
          null,
        ),
        InspectorProperty(
          "Running Status",
          InspectorText(running.toString()),
          runningStatus,
        ),
      ]),
    ];
  }

  List<Widget> getAdvancedDetails();
}

class IntakeManagerData extends CommandData {
  bool? elevAtBottom;
  bool? hasCoral;
  bool? runningIntake;

  IntakeManagerData({
    super.running,
    this.elevAtBottom,
    this.hasCoral,
    this.runningIntake,
  }) : super(name: "IntakeManager", requires: ["Intake"]);

  Status get _elevAtBottomStatus =>
      elevAtBottom == null ? Status.warning : Status.ok;
  Status get _hasCoralStatus => hasCoral == null ? Status.warning : Status.ok;
  Status get _runningIntakeStatus =>
      runningIntake == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      super.basicStatus,
      _elevAtBottomStatus,
      _hasCoralStatus,
      _runningIntakeStatus,
    ].reduce(Status.maxPriority);
  }

  @override
  List<Widget> getAdvancedDetails() {
    return [
      StatusTable([
        InspectorProperty(
          "Elev At Bottom",
          SmallStatusIndicator.bool(
            boolean: elevAtBottom,
            label: formatBoolAsString(elevAtBottom),
          ),
          _elevAtBottomStatus,
        ),
        InspectorProperty(
          "Has Coral",
          SmallStatusIndicator.bool(
            boolean: hasCoral,
            label: formatBoolAsString(hasCoral),
          ),
          _hasCoralStatus,
        ),
        InspectorProperty(
          "Running Intake",
          SmallStatusIndicator.bool(
            boolean: runningIntake,
            label: formatBoolAsString(runningIntake),
          ),
          _runningIntakeStatus,
        ),
      ]),
    ];
  }
}

class LimelightManagerData extends CommandData {
  bool? reefEstimated;
  bool? funnelEstimated;

  LimelightManagerData({
    super.running,
    this.reefEstimated,
    this.funnelEstimated,
  }) : super(name: "LimelightManager", requires: ["Reef LL", "Funnel LL"]);

  Status get _reefEstimatedStatus =>
      reefEstimated == null ? Status.warning : Status.ok;
  Status get _funnelEstimatedStatus =>
      funnelEstimated == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      super.basicStatus,
      _reefEstimatedStatus,
      _funnelEstimatedStatus,
    ].reduce(Status.maxPriority);
  }

  @override
  List<Widget> getAdvancedDetails() {
    return [
      StatusTable([
        InspectorProperty(
          "Reef Estimated",
          SmallStatusIndicator.bool(
            boolean: reefEstimated,
            label: formatBoolAsString(reefEstimated),
          ),
          _reefEstimatedStatus,
        ),
        InspectorProperty(
          "Funnel Estimated",
          SmallStatusIndicator.bool(
            boolean: funnelEstimated,
            label: formatBoolAsString(funnelEstimated),
          ),
          _funnelEstimatedStatus,
        ),
      ]),
    ];
  }
}

class LEDManagerData extends CommandData {
  String? currentPattern;
  bool? disabled;
  bool? teleop;
  bool? endgame;
  bool? hasCoral;
  bool? alignedToBranch;

  LEDManagerData({
    super.running,
    this.currentPattern,
    this.disabled,
    this.teleop,
    this.endgame,
    this.hasCoral,
    this.alignedToBranch,
  }) : super(name: "LEDManager", requires: ["LEDs"]);

  Status get _currentPatternStatus =>
      currentPattern == null ? Status.warning : Status.ok;
  Status get _disabledStatus => disabled == null ? Status.warning : Status.ok;
  Status get _teleopStatus => teleop == null ? Status.warning : Status.ok;
  Status get _endgameStatus => endgame == null ? Status.warning : Status.ok;
  Status get _hasCoralStatus => hasCoral == null ? Status.warning : Status.ok;
  Status get _alignedToBranchStatus =>
      alignedToBranch == null ? Status.warning : Status.ok;

  @override
  Status get status {
    return [
      super.basicStatus,
      _currentPatternStatus,
      _disabledStatus,
      _teleopStatus,
      _endgameStatus,
      _hasCoralStatus,
      _alignedToBranchStatus,
    ].reduce(Status.maxPriority);
  }

  @override
  List<Widget> getAdvancedDetails() {
    return [
      StatusTable([
        InspectorProperty(
          "Current Pattern",
          InspectorText(formatStringAsString(currentPattern)),
          _currentPatternStatus,
        ),
        InspectorProperty(
          "Disabled",
          SmallStatusIndicator.bool(
            boolean: disabled,
            label: formatBoolAsString(disabled),
          ),
          _disabledStatus,
        ),
        InspectorProperty(
          "Teleop",
          SmallStatusIndicator.bool(
            boolean: teleop,
            label: formatBoolAsString(teleop),
          ),
          _teleopStatus,
        ),
        InspectorProperty(
          "Endgame",
          SmallStatusIndicator.bool(
            boolean: endgame,
            label: formatBoolAsString(endgame),
          ),
          _endgameStatus,
        ),
        InspectorProperty(
          "Has Coral",
          SmallStatusIndicator.bool(
            boolean: hasCoral,
            label: formatBoolAsString(hasCoral),
          ),
          _hasCoralStatus,
        ),
        InspectorProperty(
          "Aligned To Branch",
          SmallStatusIndicator.bool(
            boolean: alignedToBranch,
            label: formatBoolAsString(alignedToBranch),
          ),
          _alignedToBranchStatus,
        ),
      ]),
    ];
  }
}
