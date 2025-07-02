import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jovial_svg/dom.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/widgets/modifiable_svg.dart';

class PlaystationSVG extends ControllerSVG {
  static const _imagePath = "assets/controllers/psOptimized.svg";
  static const _primary = [
    "LeftJoystick",
    "RightJoystick",
    "LeftBody",
    "RightBody",
    "Top",
    "LeftTrigger",
    "RightTrigger",
  ];
  static const _secondary = [
    "X",
    "Circle",
    "Triangle",
    "Square",
    "DpadUp",
    "DpadDown",
    "DpadLeft",
    "DpadRight",
    "TopLeftSpecial",
    "TopRightSpecial",
    "MainBody",
  ];

  PlaystationSVG._(super.svg) : super.fromDomManager();

  static Future<PlaystationSVG> load(Status status) async {
    final str = await rootBundle.loadString(_imagePath);

    final ps = PlaystationSVG._(SvgDOMManager.fromString(str));

    ps._verifyIDs();
    ps.setStatus(status);
    ps.build();

    return ps;
  }

  void _verifyIDs() {
    final existingIDs = svg.dom.idLookup;

    for (var id in [..._primary, ..._secondary]) {
      if (!existingIDs.containsKey(id)) {
        throw FormatException("Malformed PlaystationSVG, missing id $id");
      }
    }
  }

  void _setSegColor(String id, Color col) {
    //SvgInheritableAttributesNode is the lowest common class
    final seg = svg.dom.idLookup[id] as SvgInheritableAttributesNode;
    seg.paint.fillColor = SvgColor.value(col.toARGB32());
  }

  @override
  void setStatus(Status status) {
    for (var id in _primary) {
      _setSegColor(id, status.color);
    }

    // final secondaryCol = Color.alphaBlend(
    //   status.color.withAlpha(83),
    //   themeData.colorScheme.surface,
    // );
    final secondaryCol =
        HSVColor.fromColor(status.color).withValue(0.33).toColor();
    for (var id in _secondary) {
      _setSegColor(id, secondaryCol);
    }
  }
}
