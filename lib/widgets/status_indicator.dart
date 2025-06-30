import 'package:flutter/material.dart';
import 'package:status_display/data/cancoder_data.dart';
import 'package:status_display/data/robot_data.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/theme_data.dart';

class StatusIndicator extends StatelessWidget {
  final Color _indicatorColor;
  final bool _isNull;
  final double indicatorSize;
  final double indicatorRadius;
  final String label;
  final TextStyle labelStyle;
  final bool showBackground;

  StatusIndicator.status({
    super.key,
    required Status? status,
    required this.indicatorSize,
    required this.indicatorRadius,
    required this.label,
    required this.labelStyle,
    this.showBackground = false,
  }) : _isNull = status == null,
       _indicatorColor = status?.color ?? Colors.grey;

  StatusIndicator.alliance({
    super.key,
    required Alliance? alliance,
    required this.indicatorSize,
    required this.indicatorRadius,
    required this.label,
    required this.labelStyle,
    this.showBackground = false,
  }) : _isNull = alliance == null,
       _indicatorColor = alliance?.color ?? Colors.grey;

  StatusIndicator.robotMode({
    super.key,
    required RobotMode? robotMode,
    required this.indicatorSize,
    required this.indicatorRadius,
    required this.label,
    required this.labelStyle,
    this.showBackground = false,
  }) : _isNull = robotMode == null,
       _indicatorColor = robotMode?.color ?? Colors.grey;

  const StatusIndicator.bool({
    super.key,
    required bool? boolean,
    required this.indicatorSize,
    required this.indicatorRadius,
    required this.label,
    required this.labelStyle,
    this.showBackground = false,
  }) : _isNull = boolean == null,
       _indicatorColor =
           boolean == null
               ? Colors.grey
               : (boolean ? Colors.green : Colors.red);

  StatusIndicator.canCoderMagnetHealth({
    super.key,
    required CANCoderMagnetHealth? health,
    required this.indicatorSize,
    required this.indicatorRadius,
    required this.label,
    required this.labelStyle,
    this.showBackground = false,
  }) : _isNull = health == null,
       _indicatorColor = health?.color ?? Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: showBackground ? _indicatorColor.withAlpha(64) : null,
        borderRadius: BorderRadius.circular(indicatorRadius),
      ),
      child: Row(
        spacing: 10,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: _indicatorColor,
                  borderRadius: BorderRadius.circular(indicatorRadius),
                ),
                child: SizedBox.square(dimension: indicatorSize),
              ),
              Positioned(
                top: indicatorSize * 2 / 5,
                bottom: indicatorSize * 2 / 5,
                left: indicatorSize / 5,
                right: indicatorSize / 5,
                child:
                    _isNull
                        ? SizedBox.expand(
                          child: Container(
                            color: themeData.colorScheme.secondaryContainer,
                          ),
                        )
                        : SizedBox.shrink(),
              ),
            ],
          ),
          Flexible(
            child: Text(
              label,
              style: labelStyle,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}
