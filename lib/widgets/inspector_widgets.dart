import 'package:flutter/material.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/status_indicator.dart';
import 'package:status_display/widgets/status_table.dart';

class InspectorText extends FadingText {
  InspectorText(super.data, {super.key, bool bold = false})
    : super(style: bold ? bodySmallBold : bodySmall);
}

class InspectorProperty extends StatusTableEntry {
  InspectorProperty(String name, Widget value, Status? status)
    : super(InspectorText(name), value, status);
}
