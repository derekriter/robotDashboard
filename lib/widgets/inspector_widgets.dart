import 'package:flutter/material.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/widgets/status_indicator.dart';

class InspectorText extends Text {
  InspectorText(super.data, {super.key, bool bold = false})
    : super(
        style: bold ? bodySmallBold : bodySmall,
        softWrap: false,
        overflow: TextOverflow.fade,
      );
}

class InspectorProperty {
  final String name;
  final Widget value;
  final Status? status;

  InspectorProperty(this.name, this.value, this.status);
}

class InspectorPropertyList extends StatelessWidget {
  final List<InspectorProperty> properties;
  final String? title;

  const InspectorPropertyList(this.properties, {super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(
      color: themeData.colorScheme.onSecondaryContainer,
      width: 0.25,
    );

    final table = Table(
      border: TableBorder(verticalInside: border, horizontalInside: border),
      children:
          properties.map((prop) {
            return TableRow(
              decoration: BoxDecoration(
                color:
                    prop.status?.color.withAlpha(128) ??
                    Colors.black.withAlpha(64),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    left: 2,
                    bottom: 4,
                    right: 8,
                  ),
                  child: InspectorText(prop.name),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    left: 8,
                    bottom: 4,
                    right: 2,
                  ),
                  child: prop.value,
                ),
              ],
            );
          }).toList(),
    );

    if (title == null) return table;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center,
          child: InspectorText(title!, bold: true),
        ),
        table,
      ],
    );
  }
}

class InspectorStatusIndicator extends StatusIndicator {
  InspectorStatusIndicator.status({
    super.key,
    required super.status,
    required super.label,
  }) : super.status(
         indicatorSize: 15,
         indicatorRadius: 4,
         labelStyle: bodySmall,
       );
  InspectorStatusIndicator.alliance({
    super.key,
    required super.alliance,
    required super.label,
  }) : super.alliance(
         indicatorSize: 15,
         indicatorRadius: 4,
         labelStyle: bodySmall,
       );
  InspectorStatusIndicator.robotMode({
    super.key,
    required super.robotMode,
    required super.label,
  }) : super.robotMode(
         indicatorSize: 15,
         indicatorRadius: 4,
         labelStyle: bodySmall,
       );
  InspectorStatusIndicator.bool({
    super.key,
    required super.boolean,
    required super.label,
  }) : super.bool(indicatorSize: 15, indicatorRadius: 4, labelStyle: bodySmall);

  InspectorStatusIndicator.canCoderMagnetHealth({
    super.key,
    required super.health,
    required super.label,
  }) : super.canCoderMagnetHealth(
         indicatorSize: 15,
         indicatorRadius: 4,
         labelStyle: bodySmall,
       );
}
