import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_display/data/app_state.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/widgets/fading_scroll.dart';
import 'package:status_display/widgets/inspector_widgets.dart';

class InspectorWidget extends StatelessWidget {
  const InspectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    if (!appState.hasInspectionData) {
      return Center(
        child: Text(
          "Click an inspectable data point to view more details",
          softWrap: true,
          textAlign: TextAlign.center,
          style: bodyMedium,
        ),
      );
    }

    InspectionData data = appState.inspectionData!;

    return FadingSingleChildScrollView(
      padding: EdgeInsets.all(25),
      fadePercentage: 0.25,
      child: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InspectorText(data.targetName),
            ),
            Divider(
              color: themeData.colorScheme.onSecondaryContainer,
              thickness: 0.25,
            ),
            Column(spacing: 8, children: data.properties),
          ],
        ),
      ),
    );
  }
}

class InspectionData {
  String targetName;
  List<Widget> properties;

  InspectionData({required this.targetName, required this.properties});
}
