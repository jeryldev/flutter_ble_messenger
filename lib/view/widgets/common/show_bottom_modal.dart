import 'package:flutter/material.dart';
import 'package:flutter_ble_messenger/controller/devices_controller.dart';
import 'package:flutter_ble_messenger/view/widgets/common/custom_elevated_button.dart';
import 'package:flutter_ble_messenger/view/widgets/common/section_header_text.dart';
import 'package:nearby_connections/nearby_connections.dart';

/// Called upon Connection request (on both devices)
/// Both need to accept connection to start sending/receiving
void showBottomModal(
    BuildContext context, String cId, String id, ConnectionInfo info) {
  final bleMessengerController = DevicesController(context);
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            SectionHeaderText(
                headerText: 'Request to connect with ${info.endpointName}.'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customElevatedButton(
                  context: context,
                  fontSize: 20,
                  label: "Reject",
                  callback: () {
                    try {
                      bleMessengerController.rejectConnection(id: id);
                    } catch (e) {
                      print(e);
                    }
                    Navigator.pop(context);
                  },
                ),
                customElevatedButton(
                  context: context,
                  fontSize: 20,
                  label: "Accept",
                  callback: () {
                    cId = id;
                    try {
                      bleMessengerController.acceptConnection(
                          id: id, info: info);
                    } catch (e) {
                      print(e);
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
