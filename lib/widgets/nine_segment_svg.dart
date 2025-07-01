import 'package:flutter/services.dart';
import 'package:jovial_svg/dom.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/widgets/modifiable_svg.dart';

class NineSegSVG extends ModifiableSVG {
  static const _imagePath = "assets/isos/nineSegmentOptimized.svg";
  static const _swerve = "Swerve";
  static const _elev = "Elevator";
  static const _shooter = "Shooter";
  static const _intake = "Intake";
  static const _climber = "Climber";
  static const _algaeRem = "AlgaeRemover";
  static const _limelights = "Limelights";
  static const _leds = "LEDs";
  static const _controllers = "Controllers";

  late Status _swerveStatus,
      _elevStatus,
      _shooterStatus,
      _intakeStatus,
      _climberStatus,
      _algaeRemStatus,
      _visionStatus,
      _ledsStatus,
      _controllersStatus;

  NineSegSVG._(super.svg) : super.fromDomManager();

  static Future<NineSegSVG> load(
    Status swerve,
    Status elev,
    Status shooter,
    Status intake,
    Status climber,
    Status algaeRem,
    Status vision,
    Status leds,
    Status controllers,
  ) async {
    final str = await rootBundle.loadString(_imagePath);

    final disp = NineSegSVG._(SvgDOMManager.fromString(str));

    disp._verifyIDs();
    disp.setSwerveStatus(swerve);
    disp.setElevStatus(elev);
    disp.setShooterStatus(shooter);
    disp.setIntakeStatus(intake);
    disp.setClimberStatus(climber);
    disp.setAlgaeRemStatus(algaeRem);
    disp.setVisionStatus(vision);
    disp.setLEDsStatus(leds);
    disp.setControllersStatus(controllers);
    disp.build();

    return disp;
  }

  void _verifyIDs() {
    var ids = svg.dom.idLookup;
    for (var id in [
      _swerve,
      _elev,
      _shooter,
      _intake,
      _climber,
      _algaeRem,
      _limelights,
      _leds,
      _controllers,
    ]) {
      if (!ids.containsKey(id)) {
        throw FormatException("Malformed NineSegSVG, missing id '$id'");
      }
    }
  }

  void setSwerveStatus(Status status) {
    final seg = svg.dom.idLookup[_swerve] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _swerveStatus = status;
  }

  void setElevStatus(Status status) {
    final seg = svg.dom.idLookup[_elev] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _elevStatus = status;
  }

  void setShooterStatus(Status status) {
    final seg = svg.dom.idLookup[_shooter] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _shooterStatus = status;
  }

  void setIntakeStatus(Status status) {
    final seg = svg.dom.idLookup[_intake] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _intakeStatus = status;
  }

  void setClimberStatus(Status status) {
    final seg = svg.dom.idLookup[_climber] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _climberStatus = status;
  }

  void setAlgaeRemStatus(Status status) {
    final seg = svg.dom.idLookup[_algaeRem] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _algaeRemStatus = status;
  }

  void setVisionStatus(Status status) {
    final seg = svg.dom.idLookup[_limelights] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _visionStatus = status;
  }

  void setLEDsStatus(Status status) {
    final seg = svg.dom.idLookup[_leds] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _ledsStatus = status;
  }

  void setControllersStatus(Status status) {
    final seg = svg.dom.idLookup[_controllers] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _controllersStatus = status;
  }

  Status get swerveStatus => _swerveStatus;
  Status get elevStatus => _elevStatus;
  Status get shooterStatus => _shooterStatus;
  Status get intakeStatus => _intakeStatus;
  Status get climberStatus => _climberStatus;
  Status get algaeRemStatus => _algaeRemStatus;
  Status get limelightsStatus => _visionStatus;
  Status get ledsStatus => _ledsStatus;
  Status get controllersStatus => _controllersStatus;
}
