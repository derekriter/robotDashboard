import 'package:status_display/data/status.dart';
import 'package:status_display/inspector.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/common_widgets.dart';
import 'package:status_display/widgets/inspectable.dart';
import 'package:status_display/widgets/inspector_widgets.dart';
import 'package:status_display/widgets/status_table.dart';

class ControllerData extends InspectableData {
  final String name;
  final int port;
  bool connected;

  ControllerData({
    required this.name,
    required this.port,
    required this.connected,
  });

  Status get portStatus => (port < 0 || port > 5) ? Status.warning : Status.ok;
  Status get connectedStatus => connected ? Status.ok : Status.error;

  Status get status {
    return Status.maxPriority(portStatus, connectedStatus);
  }

  @override
  InspectionData getInspectionData() {
    return InspectionData(
      targetName: "$name (Controller)",
      properties: [
        StatusTable([
          InspectorProperty(
            "Controller Status",
            SmallStatusIndicator.status(
              status: status,
              label: status.toString(),
            ),
            null,
          ),
          InspectorProperty("Port", InspectorText(port.toString()), portStatus),
          InspectorProperty(
            "Connected",
            SmallStatusIndicator.bool(
              boolean: connected,
              label: formatBoolAsString(connected),
            ),
            connectedStatus,
          ),
        ]),
      ],
    );
  }
}
