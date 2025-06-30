import 'package:flutter/material.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/subsystem_data.dart';

enum Alliance {
  blue1("Blue 1", Colors.blue),
  blue2("Blue 2", Colors.blue),
  blue3("Blue 3", Colors.blue),
  red1("Red 1", Colors.red),
  red2("Red 2", Colors.red),
  red3("Red 3", Colors.red),
  unknown("Unknown", Colors.purple);

  final String name;
  final Color color;

  const Alliance(this.name, this.color);

  @override
  String toString() {
    return name;
  }
}

enum RobotMode {
  disabled("Disabled", Colors.grey),
  auton("Autonomous", Colors.green),
  teleop("Teleoperated", Colors.blue),
  test("Test", Colors.orange),
  eStopped("E-Stopped", Colors.yellow);

  final String name;
  final Color color;

  const RobotMode(this.name, this.color);

  @override
  String toString() {
    return name;
  }
}

class RobotData {
  SwerveData swerve;
  ElevData elev;
  ShooterData shooter;
  IntakeData intake;
  ClimberData climber;
  AlgaeRemData algaeRem;
  VisionData vision;
  LEDData leds;
  ControllersData controllers;

  Status netTables;
  bool? comms;
  bool? robotCode;
  Alliance? alliance;
  RobotMode? mode;
  double? batteryVoltage;
  double? canUsage;
  double? robotCpuUsage;
  double? robotRamUsage;

  RobotData({
    required this.swerve,
    required this.elev,
    required this.shooter,
    required this.intake,
    required this.climber,
    required this.algaeRem,
    required this.vision,
    required this.leds,
    required this.controllers,
    required this.netTables,
    this.comms,
    this.robotCode,
    this.alliance,
    this.mode,
    this.batteryVoltage,
    this.canUsage,
    this.robotCpuUsage,
    this.robotRamUsage,
  });

  Status get batteryVoltageStatus {
    if (batteryVoltage == null) {
      return Status.warning;
    }
    if (batteryVoltage! <= 11) {
      return Status.error;
    }
    if (batteryVoltage! <= 11.5) {
      return Status.warning;
    }
    return Status.ok;
  }

  Status get canUsageStatus {
    if (canUsage == null) {
      return Status.warning;
    }
    if (canUsage! >= 80) {
      return Status.error;
    }
    if (canUsage! >= 70) {
      return Status.warning;
    }
    return Status.ok;
  }

  Status get robotCpuUsageStatus {
    if (robotCpuUsage == null) {
      return Status.warning;
    }
    if (robotCpuUsage! >= 90) {
      return Status.error;
    }
    if (robotCpuUsage! >= 70) {
      return Status.warning;
    }
    return Status.ok;
  }

  Status get robotRamUsageStatus {
    if (robotRamUsage == null) {
      return Status.warning;
    }
    if (robotRamUsage! >= 80) {
      return Status.error;
    }
    if (robotRamUsage! >= 70) {
      return Status.warning;
    }
    return Status.ok;
  }
}
