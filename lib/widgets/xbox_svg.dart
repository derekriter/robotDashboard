import 'package:flutter/services.dart';
import 'package:jovial_svg/dom.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/widgets/modifiable_svg.dart';

class XboxSVG extends ControllerSVG {
  static const _imagePath = "assets/controllers/xboxOptimized.svg";
  static const _primary = [
    "Body",
    "UpperBody",
    "RightJoystick",
    "LeftJoystick",
  ];
  static const _secondary = [
    "A",
    "B",
    "X",
    "Y",
    "RightJoystickWell",
    "LeftJoystickWell",
    "Dpad",
    "Logo",
  ];

  XboxSVG._(super.svg) : super.fromDomManager();

  static Future<XboxSVG> load(Status status) async {
    final str = await rootBundle.loadString(_imagePath);

    final xbox = XboxSVG._(SvgDOMManager.fromString(str));

    xbox._verifyIDs();
    xbox.setStatus(status);
    xbox.build();

    return xbox;
  }

  void _verifyIDs() {
    final existingIDs = svg.dom.idLookup;

    for (var id in [..._primary, ..._secondary]) {
      if (!existingIDs.containsKey(id)) {
        throw FormatException("Malformed XboxSVG, missing id $id");
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

    final secondayCol = Color.alphaBlend(
      status.color.withAlpha(83),
      themeData.colorScheme.surface,
    );
    for (var id in _secondary) {
      _setSegColor(id, secondayCol);
    }
  }
}
