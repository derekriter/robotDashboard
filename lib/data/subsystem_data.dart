import 'package:flutter/material.dart';
import 'package:status_display/data/cancoder_data.dart';
import 'package:status_display/data/command_data.dart';
import 'package:status_display/data/controller_data.dart';
import 'package:status_display/data/fusion_tof_data.dart';
import 'package:status_display/data/limelight_data.dart';
import 'package:status_display/data/navx_data.dart';
import 'package:status_display/data/sparkmax_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/talonfx_data.dart';
import 'package:status_display/inspector.dart';
import 'package:status_display/subsystems_display.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/inspectable.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

abstract class SubsystemData extends InspectableData {
  bool initialized;
  String name;
  String? runningCommand;

  SubsystemData({
    required this.initialized,
    required this.name,
    required this.runningCommand,
  });

  Status get status;

  Status get initilizedStatus => initialized ? Status.ok : Status.error;
  Status get runningCommandStatus =>
      runningCommand == null ? Status.warning : Status.ok;

  Status get basicStatus =>
      Status.maxPriority(initilizedStatus, runningCommandStatus);

  @override
  InspectionData getInspectionData() {
    return InspectionData(
      targetName: "$name (Subsystem)",
      properties: getBasicDetails(),
    );
  }

  List<SubsystemDetail> getDetails();

  List<Widget> getBasicDetails() {
    return [
      StatusTable([
        InspectorProperty(
          "Subsystem Status",
          SmallStatusIndicator.status(status: status, label: status.toString()),
          null,
        ),
        InspectorProperty(
          "Initialized",
          SmallStatusIndicator.bool(
            boolean: initialized,
            label: formatBoolAsString(initialized),
          ),
          initilizedStatus,
        ),
        InspectorProperty(
          "Running Command",
          InspectorText(formatStringAsString(runningCommand)),
          runningCommandStatus,
        ),
      ]),
    ];
  }
}

class SwerveData extends SubsystemData {
  SparkMaxData frontLeftDrive, frontLeftAngle;
  SparkMaxData frontRightDrive, frontRightAngle;
  SparkMaxData backRightDrive, backRightAngle;
  SparkMaxData backLeftDrive, backLeftAngle;
  CANCoderData frontLeftEncoder,
      frontRightEncoder,
      backRightEncoder,
      backLeftEncoder;
  NavXData navX;

  SwerveData({
    required super.initialized,
    super.runningCommand,
    required this.frontLeftDrive,
    required this.frontLeftAngle,
    required this.frontLeftEncoder,
    required this.frontRightDrive,
    required this.frontRightAngle,
    required this.frontRightEncoder,
    required this.backRightDrive,
    required this.backRightAngle,
    required this.backRightEncoder,
    required this.backLeftDrive,
    required this.backLeftAngle,
    required this.backLeftEncoder,
    required this.navX,
  }) : super(name: "Swerve");

  Status get _frontLeftOverall {
    return [
      frontLeftDrive.status,
      frontLeftAngle.status,
      frontLeftEncoder.status,
    ].reduce(Status.maxPriority);
  }

  Status get _frontRightOverall {
    return [
      frontRightDrive.status,
      frontRightAngle.status,
      frontRightEncoder.status,
    ].reduce(Status.maxPriority);
  }

  Status get _backRightOverall {
    return [
      backRightDrive.status,
      backRightAngle.status,
      backRightEncoder.status,
    ].reduce(Status.maxPriority);
  }

  Status get _backLeftOverall {
    return [
      backLeftDrive.status,
      backLeftAngle.status,
      backLeftEncoder.status,
    ].reduce(Status.maxPriority);
  }

  @override
  Status get status {
    return [
      basicStatus,
      _frontLeftOverall,
      _frontRightOverall,
      _backRightOverall,
      _backLeftOverall,
      navX.status,
    ].reduce(Status.maxPriority);
  }

  @override
  List<SubsystemDetail> getDetails() {
    return [
      SubsystemDetail.fromHardware(frontLeftDrive),
      SubsystemDetail.fromHardware(frontRightDrive),
      SubsystemDetail.fromHardware(backRightDrive),
      SubsystemDetail.fromHardware(backLeftDrive),
      SubsystemDetail.fromHardware(frontLeftAngle),
      SubsystemDetail.fromHardware(frontRightAngle),
      SubsystemDetail.fromHardware(backRightAngle),
      SubsystemDetail.fromHardware(backLeftAngle),
      SubsystemDetail.fromHardware(frontLeftEncoder),
      SubsystemDetail.fromHardware(frontRightEncoder),
      SubsystemDetail.fromHardware(backRightEncoder),
      SubsystemDetail.fromHardware(backLeftEncoder),
      SubsystemDetail.fromHardware(navX),
    ];
  }
}

class ElevData extends SubsystemData {
  TalonFXData elevMotor;

  ElevData({
    required super.initialized,
    super.runningCommand,
    required this.elevMotor,
  }) : super(name: "Elevator");

  @override
  Status get status => Status.maxPriority(basicStatus, elevMotor.status);

  @override
  List<SubsystemDetail> getDetails() {
    return [SubsystemDetail.fromHardware(elevMotor)];
  }
}

class ShooterData extends SubsystemData {
  SparkMaxData leftMotor, rightMotor;
  FusionToFData branchSensor, coralSensor, frontSensor, backSensor;

  ShooterData({
    required super.initialized,
    super.runningCommand,
    required this.leftMotor,
    required this.rightMotor,
    required this.branchSensor,
    required this.coralSensor,
    required this.frontSensor,
    required this.backSensor,
  }) : super(name: "Shooter");

  @override
  Status get status {
    return [
      basicStatus,
      leftMotor.status,
      rightMotor.status,
      branchSensor.status,
      coralSensor.status,
      frontSensor.status,
      backSensor.status,
    ].reduce(Status.maxPriority);
  }

  @override
  List<SubsystemDetail> getDetails() {
    return [
      SubsystemDetail.fromHardware(leftMotor),
      SubsystemDetail.fromHardware(rightMotor),
      SubsystemDetail.fromHardware(branchSensor),
      SubsystemDetail.fromHardware(coralSensor),
      SubsystemDetail.fromHardware(frontSensor),
      SubsystemDetail.fromHardware(backSensor),
    ];
  }
}

class IntakeData extends SubsystemData {
  SparkMaxData intakeMotor;
  IntakeManagerData manager;

  IntakeData({
    required super.initialized,
    super.runningCommand,
    required this.intakeMotor,
    required this.manager,
  }) : super(name: "Intake");

  @override
  Status get status {
    return [
      basicStatus,
      intakeMotor.status,
      manager.status,
    ].reduce(Status.maxPriority);
  }

  @override
  List<SubsystemDetail> getDetails() {
    return [
      SubsystemDetail.fromHardware(intakeMotor),
      SubsystemDetail.fromCommand(manager),
    ];
  }
}

class ClimberData extends SubsystemData {
  TalonFXData leverMotor, clampMotor;

  ClimberData({
    required super.initialized,
    super.runningCommand,
    required this.leverMotor,
    required this.clampMotor,
  }) : super(name: "Climber");

  @override
  Status get status {
    return [
      basicStatus,
      leverMotor.status,
      clampMotor.status,
    ].reduce(Status.maxPriority);
  }

  @override
  List<SubsystemDetail> getDetails() {
    return [
      SubsystemDetail.fromHardware(leverMotor),
      SubsystemDetail.fromHardware(clampMotor),
    ];
  }
}

class AlgaeRemData extends SubsystemData {
  SparkMaxData algaeRemMotor;

  AlgaeRemData({
    required super.initialized,
    super.runningCommand,
    required this.algaeRemMotor,
  }) : super(name: "Algae Remover");

  @override
  Status get status => Status.maxPriority(basicStatus, algaeRemMotor.status);

  @override
  List<SubsystemDetail> getDetails() {
    return [SubsystemDetail.fromHardware(algaeRemMotor)];
  }
}

class VisionData extends SubsystemData {
  LimelightData reefLL, funnelLL;
  LimelightManagerData manager;

  VisionData({
    required super.initialized,
    super.runningCommand,
    required this.reefLL,
    required this.funnelLL,
    required this.manager,
  }) : super(name: "Vision");

  @override
  Status get status {
    return [
      basicStatus,
      reefLL.status,
      funnelLL.status,
      manager.status,
    ].reduce(Status.maxPriority);
  }

  @override
  List<SubsystemDetail> getDetails() {
    return [
      SubsystemDetail.fromHardware(reefLL),
      SubsystemDetail.fromHardware(funnelLL),
      SubsystemDetail.fromCommand(manager),
    ];
  }
}

class LEDData extends SubsystemData {
  LEDManagerData manager;

  LEDData({
    required super.initialized,
    super.runningCommand,
    required this.manager,
  }) : super(name: "LEDs");

  @override
  Status get status => Status.maxPriority(basicStatus, manager.status);

  @override
  List<SubsystemDetail> getDetails() {
    return [SubsystemDetail.fromCommand(manager)];
  }
}

class ControllersData extends SubsystemData {
  ControllerData driver1, driver2;

  ControllersData({
    required super.initialized,
    super.runningCommand,
    required this.driver1,
    required this.driver2,
  }) : super(name: "Controllers");

  @override
  Status get status {
    return [
      basicStatus,
      driver1.status,
      driver2.status,
    ].reduce(Status.maxPriority);
  }

  @override
  List<SubsystemDetail> getDetails() {
    return [
      SubsystemDetail.fromController(driver1),
      SubsystemDetail.fromController(driver2),
    ];
  }
}
