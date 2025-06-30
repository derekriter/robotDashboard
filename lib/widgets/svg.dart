import 'package:flutter/services.dart';
import 'package:jovial_svg/dom.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:status_display/data/status.dart';

class ModifiableSVG {
  final SvgDOMManager _svg;
  ScalableImage? _si;

  //private constructor
  //https://stackoverflow.com/questions/55143244/is-it-possible-to-have-a-private-constructor-in-dart
  ModifiableSVG._(SvgDOMManager svg) : _svg = svg;

  static ModifiableSVG fromContents(String contents) {
    return ModifiableSVG._(SvgDOMManager.fromString(contents));
  }

  static Future<ModifiableSVG> fromAsset(String imagePath) async {
    //don't handle exception, let it propogate
    final str = await rootBundle.loadString(imagePath);

    return ModifiableSVG._(SvgDOMManager.fromString(str));
  }

  ScalableImage build() {
    _si = _svg.build();
    return _si!;
  }

  SvgDOM get dom => _svg.dom;
  bool get hasScalableImage => _si != null;
  ScalableImage? get scalableImage => _si;
}

// class HexagonDisplay extends ModifiableSVG {
//   static const _imagePath = "assets/hexagonOptimized.svg";
//   static const _topInside = "topInside";
//   static const _topOutside = "topOutside";
//   static const _leftInside = "leftInside";
//   static const _leftOutside = "leftOutside";
//   static const _rightInside = "rightInside";
//   static const _rightOutside = "rightOutside";

//   late Status _topState, _leftState, _rightState;

//   HexagonDisplay._(super.svg) : super._();

//   static Future<HexagonDisplay> load(
//     Status top,
//     Status left,
//     Status right,
//   ) async {
//     final str = await rootBundle.loadString(_imagePath);

//     final hex = HexagonDisplay._(SvgDOMManager.fromString(str));

//     hex._verifyIDs();
//     hex.setTopState(top);
//     hex.setLeftState(left);
//     hex.setRightState(right);
//     hex.build();

//     return hex;
//   }

//   void _verifyIDs() {
//     var ids = _svg.dom.idLookup;
//     for (var id in [
//       _topInside,
//       _topOutside,
//       _leftInside,
//       _leftOutside,
//       _rightInside,
//       _rightOutside,
//     ]) {
//       if (!ids.containsKey(id)) {
//         throw FormatException(
//           "Malformed SVG, HexagonDisplay is missing id '$id'",
//         );
//       }
//     }
//   }

//   void setTopState(Status state) {
//     final ti = _svg.dom.idLookup[_topInside] as SvgPath;
//     ti.paint.fillColor = SvgColor.value(state.inside.toARGB32());
//     ti.paint.strokeAlpha = 0;

//     final to = _svg.dom.idLookup[_topOutside] as SvgPath;
//     to.paint.fillColor = SvgColor.value(state.outside.toARGB32());
//     to.paint.strokeAlpha = 0;

//     _topState = state;
//   }

//   void setLeftState(Status state) {
//     final li = _svg.dom.idLookup[_leftInside] as SvgPath;
//     li.paint.fillColor = SvgColor.value(state.inside.toARGB32());
//     li.paint.strokeAlpha = 0;

//     final lo = _svg.dom.idLookup[_leftOutside] as SvgPath;
//     lo.paint.fillColor = SvgColor.value(state.outside.toARGB32());
//     lo.paint.strokeAlpha = 0;

//     _leftState = state;
//   }

//   void setRightState(Status state) {
//     final ri = _svg.dom.idLookup[_rightInside] as SvgPath;
//     ri.paint.fillColor = SvgColor.value(state.inside.toARGB32());
//     ri.paint.strokeAlpha = 0;

//     final ro = _svg.dom.idLookup[_rightOutside] as SvgPath;
//     ro.paint.fillColor = SvgColor.value(state.outside.toARGB32());
//     ro.paint.strokeAlpha = 0;

//     _rightState = state;
//   }

//   Status get topState => _topState;
//   Status get leftState => _leftState;
//   Status get rightState => _rightState;
// }

class IsoDisplay extends ModifiableSVG {
  static const _imagePath = "assets/isoOptimized.svg";
  static const _side = "side";
  static const _bottomFront = "bottomFront";
  static const _bottomTop = "bottomTop";
  static const _topFront = "topFront";
  static const _topTop = "topTop";

  late Status _sideStatus, _bottomStatus, _topStatus;

  IsoDisplay._(super.svg) : super._();

  static Future<IsoDisplay> load(Status side, Status bottom, Status top) async {
    final str = await rootBundle.loadString(_imagePath);

    final iso = IsoDisplay._(SvgDOMManager.fromString(str));

    iso._verifyIDs();
    iso.setSideStatus(side);
    iso.setBottomStatus(bottom);
    iso.setTopStatus(top);
    iso.build();

    return iso;
  }

  void _verifyIDs() {
    var ids = _svg.dom.idLookup;
    for (var id in [_side, _bottomFront, _bottomTop, _topFront, _topTop]) {
      if (!ids.containsKey(id)) {
        throw FormatException(
          "Malformed SVG, HexagonDisplay is missing id '$id'",
        );
      }
    }
  }

  void setSideStatus(Status status) {
    final s = _svg.dom.idLookup[_side] as SvgPath;
    s.paint.fillColor = SvgColor.value(status.color.toARGB32());
    s.paint.strokeAlpha = 0;

    _sideStatus = status;
  }

  void setBottomStatus(Status status) {
    final bf = _svg.dom.idLookup[_bottomFront] as SvgPath;
    bf.paint.fillColor = SvgColor.value(status.color.toARGB32());
    bf.paint.strokeAlpha = 0;

    final bt = _svg.dom.idLookup[_bottomTop] as SvgPath;
    bt.paint.fillColor = SvgColor.value(status.color.toARGB32());
    bt.paint.strokeAlpha = 0;

    _bottomStatus = status;
  }

  void setTopStatus(Status status) {
    final tf = _svg.dom.idLookup[_topFront] as SvgPath;
    tf.paint.fillColor = SvgColor.value(status.color.toARGB32());
    tf.paint.strokeAlpha = 0;

    final bf = _svg.dom.idLookup[_topTop] as SvgPath;
    bf.paint.fillColor = SvgColor.value(status.color.toARGB32());
    bf.paint.strokeAlpha = 0;

    _topStatus = status;
  }

  Status get sideStatus => _sideStatus;
  Status get bottomStatus => _bottomStatus;
  Status get topStatus => _topStatus;
}

class NineSegmentDisplay extends ModifiableSVG {
  static const _imagePath = "assets/nineSegmentOptimized.svg";
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

  NineSegmentDisplay._(super.svg) : super._();

  static Future<NineSegmentDisplay> load(
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

    final disp = NineSegmentDisplay._(SvgDOMManager.fromString(str));

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
    var ids = _svg.dom.idLookup;
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
        throw FormatException(
          "Malformed SVG, HexagonDisplay is missing id '$id'",
        );
      }
    }
  }

  void setSwerveStatus(Status status) {
    final seg = _svg.dom.idLookup[_swerve] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _swerveStatus = status;
  }

  void setElevStatus(Status status) {
    final seg = _svg.dom.idLookup[_elev] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _elevStatus = status;
  }

  void setShooterStatus(Status status) {
    final seg = _svg.dom.idLookup[_shooter] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _shooterStatus = status;
  }

  void setIntakeStatus(Status status) {
    final seg = _svg.dom.idLookup[_intake] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _intakeStatus = status;
  }

  void setClimberStatus(Status status) {
    final seg = _svg.dom.idLookup[_climber] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _climberStatus = status;
  }

  void setAlgaeRemStatus(Status status) {
    final seg = _svg.dom.idLookup[_algaeRem] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _algaeRemStatus = status;
  }

  void setVisionStatus(Status status) {
    final seg = _svg.dom.idLookup[_limelights] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _visionStatus = status;
  }

  void setLEDsStatus(Status status) {
    final seg = _svg.dom.idLookup[_leds] as SvgPath;
    seg.paint.fillColor = SvgColor.value(status.color.toARGB32());
    seg.paint.strokeAlpha = 0;

    _ledsStatus = status;
  }

  void setControllersStatus(Status status) {
    final seg = _svg.dom.idLookup[_controllers] as SvgPath;
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
