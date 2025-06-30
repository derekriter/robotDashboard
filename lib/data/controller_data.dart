import 'package:status_display/data/status.dart';
import 'package:status_display/inspector.dart';
import 'package:status_display/utils/formating.dart';
import 'package:status_display/widgets/inspectable.dart';
import 'package:status_display/widgets/inspector_widgets.dart';

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
        InspectorPropertyList([
          InspectorProperty(
            "Controller Status",
            InspectorStatusIndicator.status(
              status: status,
              label: status.toString(),
            ),
            null,
          ),
          InspectorProperty("Port", InspectorText(port.toString()), portStatus),
          InspectorProperty(
            "Connected",
            InspectorStatusIndicator.bool(
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
