import 'package:flutter/material.dart';
import 'package:status_display/data/cancoder_data.dart';
import 'package:status_display/data/command_data.dart';
import 'package:status_display/data/controller_data.dart';
import 'package:status_display/data/fusion_tof_data.dart';
import 'package:status_display/data/limelight_data.dart';
import 'package:status_display/data/navx_data.dart';
import 'package:status_display/data/robot_data.dart';
import 'package:status_display/data/sparkmax_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/subsystem_data.dart';
import 'package:status_display/data/talonfx_data.dart';
import 'package:status_display/inspector.dart';
import 'package:status_display/widgets/svg.dart';

class AppState extends ChangeNotifier {
  AppState() {
    NineSegmentDisplay.load(
      _robotData.swerve.status,
      _robotData.elev.status,
      _robotData.shooter.status,
      _robotData.intake.status,
      _robotData.climber.status,
      _robotData.algaeRem.status,
      _robotData.vision.status,
      _robotData.leds.status,
      _robotData.controllers.status,
    ).then((val) {
      _nineSeg = val;
      notifyListeners();
    });
  }

  NineSegmentDisplay? _nineSeg;
  bool get hasNineSeg => _nineSeg != null;
  ModifiableSVG? get nineSeg => _nineSeg;
  bool get isNineSegReady => hasNineSeg && _nineSeg!.hasScalableImage;

  final RobotData _robotData = RobotData(
    swerve: SwerveData(
      initialized: false,
      frontLeftDrive: SparkMaxData(
        name: "FL Drive",
        connected: false,
        canID: 3,
      ),
      frontLeftAngle: SparkMaxData(
        name: "FL Angle",
        connected: false,
        canID: 4,
      ),
      frontLeftEncoder: CANCoderData(
        name: "FL Encoder",
        connected: false,
        canID: 21,
      ),
      frontRightDrive: SparkMaxData(
        name: "FR Drive",
        connected: false,
        canID: 17,
      ),
      frontRightAngle: SparkMaxData(
        name: "FR Angle",
        connected: false,
        canID: 18,
      ),
      frontRightEncoder: CANCoderData(
        name: "FR Encoder",
        connected: false,
        canID: 22,
      ),
      backRightDrive: SparkMaxData(
        name: "BR Drive",
        connected: false,
        canID: 15,
      ),
      backRightAngle: SparkMaxData(
        name: "BR Angle",
        connected: false,
        canID: 16,
      ),
      backRightEncoder: CANCoderData(
        name: "BR Encoder",
        connected: false,
        canID: 23,
      ),
      backLeftDrive: SparkMaxData(
        name: "BL Drive",
        connected: false,
        canID: 30,
      ),
      backLeftAngle: SparkMaxData(name: "BL Angle", connected: false, canID: 1),
      backLeftEncoder: CANCoderData(
        name: "BL Encoder",
        connected: false,
        canID: 24,
      ),
      navX: NavXData(name: "NavX", connected: false),
    ),
    elev: ElevData(
      initialized: false,
      elevMotor: TalonFXData(name: "Motor", connected: false, canID: 19),
    ),
    shooter: ShooterData(
      initialized: false,
      leftMotor: SparkMaxData(name: "Left Motor", connected: false, canID: 12),
      rightMotor: SparkMaxData(
        name: "Right Motor",
        connected: false,
        canID: 11,
      ),
      branchSensor: FusionToFData(
        name: "Branch Sensor",
        connected: false,
        canID: 1,
      ),
      coralSensor: FusionToFData(
        name: "Coral Sensor",
        connected: false,
        canID: 0,
      ),
      frontSensor: FusionToFData(
        name: "Front Sensor",
        connected: false,
        canID: 3,
      ),
      backSensor: FusionToFData(
        name: "Back Sensor",
        connected: false,
        canID: 2,
      ),
    ),
    intake: IntakeData(
      initialized: false,
      intakeMotor: SparkMaxData(name: "Motor", connected: false, canID: 10),
      manager: IntakeManagerData(running: RunningStatus.finished),
    ),
    climber: ClimberData(
      initialized: false,
      leverMotor: TalonFXData(name: "Lever Motor", connected: false, canID: 2),
      clampMotor: TalonFXData(name: "Clamp Motor", connected: false, canID: 5),
    ),
    algaeRem: AlgaeRemData(
      initialized: false,
      algaeRemMotor: SparkMaxData(name: "Motor", connected: false, canID: 13),
    ),
    vision: VisionData(
      initialized: false,
      reefLL: LimelightData(
        name: "Reef LL",
        modelName: "Limelight 3",
        connected: false,
      ),
      funnelLL: LimelightData(
        name: "Funnel LL",
        modelName: "Limelight 3",
        connected: false,
      ),
      manager: LimelightManagerData(running: RunningStatus.finished),
    ),
    leds: LEDData(
      initialized: false,
      manager: LEDManagerData(running: RunningStatus.finished),
    ),
    controllers: ControllersData(
      initialized: false,
      driver1: ControllerData(name: "Driver 1", port: 0, connected: false),
      driver2: ControllerData(name: "Driver 2", port: 1, connected: false),
    ),
    netTables: Status.error,
  );
  RobotData get robotData => _robotData;

  InspectionData? _inspectionData;
  bool get hasInspectionData => _inspectionData != null;
  InspectionData? get inspectionData => _inspectionData;
  void inspect(InspectionData data) {
    _inspectionData = data;
    notifyListeners();
  }
}
