import 'package:flutter/material.dart';
import 'package:status_display/data/status.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/widgets/common_widgets.dart';

class StatusTableEntry {
  final Widget key;
  final Widget value;
  final Status? status;

  StatusTableEntry(this.key, this.value, this.status);
}

class StatusTable extends StatelessWidget {
  final List<StatusTableEntry> entries;
  final String? title;

  const StatusTable(this.entries, {super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(
      color: themeData.colorScheme.onSecondaryContainer,
      width: 0.25,
    );

    final table = Table(
      border: TableBorder(verticalInside: border, horizontalInside: border),
      children:
          entries.map((entry) {
            return TableRow(
              decoration: BoxDecoration(
                color:
                    entry.status?.color.withAlpha(128) ??
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
                  child: entry.key,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    left: 8,
                    bottom: 4,
                    right: 2,
                  ),
                  child: entry.value,
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
          child: FadingText(title!, style: bodySmallBold),
        ),
        table,
      ],
    );
  }
}
