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
import 'package:status_display/widgets/modifiable_svg.dart';
import 'package:status_display/widgets/nine_segment_svg.dart';
import 'package:status_display/widgets/playstation_svg.dart';
import 'package:status_display/widgets/xbox_svg.dart';

class AppState extends ChangeNotifier {
  AppState() {
    NineSegSVG.load(
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

    XboxSVG.load(_robotData.controllers.driver1.status).then((val) {
      _driver1 = val;
      notifyListeners();
    });

    PlaystationSVG.load(_robotData.controllers.driver2.status).then((val) {
      _driver2 = val;
      notifyListeners();
    });
  }

  NineSegSVG? _nineSeg;
  bool get hasNineSeg => _nineSeg != null;
  NineSegSVG? get nineSeg => _nineSeg;
  bool get isNineSegReady => hasNineSeg && _nineSeg!.hasScalableImage;

  ControllerSVG? _driver1;
  bool get hasDriver1 => _driver1 != null;
  ControllerSVG? get driver1 => _driver1;
  bool get isDriver1Ready => hasDriver1 && _driver1!.hasScalableImage;

  ControllerSVG? _driver2;
  bool get hasDriver2 => _driver2 != null;
  ControllerSVG? get driver2 => _driver2;
  bool get isDriver2Ready => hasDriver2 && _driver2!.hasScalableImage;

  final RobotData _robotData = RobotData(
    swerve: SwerveData(
      frontLeftDrive: SparkMaxData(name: "FL Drive", canID: 3),
      frontLeftAngle: SparkMaxData(name: "FL Angle", canID: 4),
      frontLeftEncoder: CANCoderData(name: "FL Encoder", canID: 21),
      frontRightDrive: SparkMaxData(name: "FR Drive", canID: 17),
      frontRightAngle: SparkMaxData(name: "FR Angle", canID: 18),
      frontRightEncoder: CANCoderData(name: "FR Encoder", canID: 22),
      backRightDrive: SparkMaxData(name: "BR Drive", canID: 15),
      backRightAngle: SparkMaxData(name: "BR Angle", canID: 16),
      backRightEncoder: CANCoderData(name: "BR Encoder", canID: 23),
      backLeftDrive: SparkMaxData(name: "BL Drive", canID: 30),
      backLeftAngle: SparkMaxData(name: "BL Angle", canID: 1),
      backLeftEncoder: CANCoderData(name: "BL Encoder", canID: 24),
      navX: NavXData(name: "NavX"),
    ),
    elev: ElevData(elevMotor: TalonFXData(name: "Motor", canID: 19)),
    shooter: ShooterData(
      leftMotor: SparkMaxData(name: "Left Motor", canID: 12),
      rightMotor: SparkMaxData(name: "Right Motor", canID: 11),
      branchSensor: FusionToFData(name: "Branch Sensor", canID: 1),
      coralSensor: FusionToFData(name: "Coral Sensor", canID: 0),
      frontSensor: FusionToFData(name: "Front Sensor", canID: 3),
      backSensor: FusionToFData(name: "Back Sensor", canID: 2),
    ),
    intake: IntakeData(
      intakeMotor: SparkMaxData(name: "Motor", canID: 10),
      manager: IntakeManagerData(),
    ),
    climber: ClimberData(
      leverMotor: TalonFXData(name: "Lever Motor", canID: 2),
      clampMotor: TalonFXData(name: "Clamp Motor", canID: 5),
    ),
    algaeRem: AlgaeRemData(
      algaeRemMotor: SparkMaxData(name: "Motor", canID: 13),
    ),
    vision: VisionData(
      reefLL: LimelightData(name: "Reef LL", modelName: "Limelight 3"),
      funnelLL: LimelightData(name: "Funnel LL", modelName: "Limelight 3"),
      manager: LimelightManagerData(),
    ),
    leds: LEDData(manager: LEDManagerData()),
    controllers: ControllersData(
      driver1: ControllerData(name: "Driver 1", port: 0),
      driver2: ControllerData(name: "Driver 2", port: 1),
    ),
    driverStation: Status.error,
  );
  RobotData get robotData => _robotData;

  InspectionData Function()? _inspectionData;
  bool get hasInspectionData => _inspectionData != null;
  InspectionData Function()? get inspectionData => _inspectionData;
  void inspect(InspectionData Function() data) {
    _inspectionData = data;
    notifyListeners();
  }

  void setDriversConnected(bool connected) {
    _robotData.controllers.driver1.connected = connected;
    _robotData.controllers.driver2.connected = connected;

    _nineSeg?.setControllersStatus(robotData.controllers.status);
    _nineSeg?.build();
    _driver1?.setStatus(robotData.controllers.driver1.status);
    _driver1?.build();
    _driver2?.setStatus(robotData.controllers.driver2.status);
    _driver2?.build();

    notifyListeners();
  }
}
