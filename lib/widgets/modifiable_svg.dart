import 'package:flutter/services.dart';
import 'package:jovial_svg/dom.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:status_display/data/status.dart';

class ModifiableSVG {
  final SvgDOMManager svg;
  ScalableImage? _si;

  ModifiableSVG.fromDomManager(this.svg);

  static ModifiableSVG fromContents(String contents) {
    return ModifiableSVG.fromDomManager(SvgDOMManager.fromString(contents));
  }

  static Future<ModifiableSVG> fromAsset(String imagePath) async {
    //don't handle exception, let it propogate
    final str = await rootBundle.loadString(imagePath);

    return ModifiableSVG.fromDomManager(SvgDOMManager.fromString(str));
  }

  ScalableImage build() {
    _si = svg.build();
    return _si!;
  }

  SvgDOM get dom => svg.dom;
  bool get hasScalableImage => _si != null;
  ScalableImage? get scalableImage => _si;
}

abstract class ControllerSVG extends ModifiableSVG {
  ControllerSVG.fromDomManager(super.svg) : super.fromDomManager();

  void setStatus(Status status);
}
