import 'package:flutter/services.dart';
import 'package:jovial_svg/dom.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/widgets/modifiable_svg.dart';

class IsoSVG extends ModifiableSVG {
  static const _imagePath = "assets/isos/isoOptimized.svg";
  static const _side = "side";
  static const _bottomFront = "bottomFront";
  static const _bottomTop = "bottomTop";
  static const _topFront = "topFront";
  static const _topTop = "topTop";

  late Status _sideStatus, _bottomStatus, _topStatus;

  IsoSVG._(super.svg) : super.fromDomManager();

  static Future<IsoSVG> load(Status side, Status bottom, Status top) async {
    final str = await rootBundle.loadString(_imagePath);

    final iso = IsoSVG._(SvgDOMManager.fromString(str));

    iso._verifyIDs();
    iso.setSideStatus(side);
    iso.setBottomStatus(bottom);
    iso.setTopStatus(top);
    iso.build();

    return iso;
  }

  void _verifyIDs() {
    var ids = svg.dom.idLookup;
    for (var id in [_side, _bottomFront, _bottomTop, _topFront, _topTop]) {
      if (!ids.containsKey(id)) {
        throw FormatException("Malformed IsoSVG, missing id '$id'");
      }
    }
  }

  void setSideStatus(Status status) {
    final s = svg.dom.idLookup[_side] as SvgPath;
    s.paint.fillColor = SvgColor.value(status.color.toARGB32());
    s.paint.strokeAlpha = 0;

    _sideStatus = status;
  }

  void setBottomStatus(Status status) {
    final bf = svg.dom.idLookup[_bottomFront] as SvgPath;
    bf.paint.fillColor = SvgColor.value(status.color.toARGB32());
    bf.paint.strokeAlpha = 0;

    final bt = svg.dom.idLookup[_bottomTop] as SvgPath;
    bt.paint.fillColor = SvgColor.value(status.color.toARGB32());
    bt.paint.strokeAlpha = 0;

    _bottomStatus = status;
  }

  void setTopStatus(Status status) {
    final tf = svg.dom.idLookup[_topFront] as SvgPath;
    tf.paint.fillColor = SvgColor.value(status.color.toARGB32());
    tf.paint.strokeAlpha = 0;

    final bf = svg.dom.idLookup[_topTop] as SvgPath;
    bf.paint.fillColor = SvgColor.value(status.color.toARGB32());
    bf.paint.strokeAlpha = 0;

    _topStatus = status;
  }

  Status get sideStatus => _sideStatus;
  Status get bottomStatus => _bottomStatus;
  Status get topStatus => _topStatus;
}
