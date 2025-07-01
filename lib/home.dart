import 'package:flutter/material.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/extra_info.dart';
import 'package:status_display/inspector.dart';
import 'package:status_display/robot_display.dart';
import 'package:status_display/subsystems_display.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final borderSide = majorBorder;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(border: Border(right: borderSide)),
            padding: EdgeInsets.all(25),
            constraints: BoxConstraints.expand(),
            child: RobotDisplayWidget(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(border: Border(left: borderSide)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: borderSide),
                    ),
                    child: SubsystemsDisplayWidget(),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(border: Border(top: borderSide)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(right: borderSide),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: InspectorWidget(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(left: borderSide),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ExtraInfoWidget(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
