import 'package:flutter/material.dart';
import 'package:flutter_ble_messenger/controller/dates_controller.dart';
import 'package:flutter_ble_messenger/model/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final String deviceUsername;
  final String appUser;

  const ChatBubble({Key key, this.message, this.deviceUsername, this.appUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double defaultWidth = width * 2 / 3;

    return Align(
      alignment: message.sent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color:
              message.sent ? Theme.of(context).primaryColor : Colors.blue[50],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(10, 10),
              color: Colors.black12,
            ),
          ],
        ),
        constraints: BoxConstraints(maxWidth: defaultWidth),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              message.sent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.sent ? appUser : deviceUsername,
              style: TextStyle(
                fontSize: 16,
                color: message.sent
                    ? Colors.grey[300]
                    : Colors.grey.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 15),
            Text(
              message.message,
              style: TextStyle(
                fontSize: 20,
                color: message.sent
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // : Colors.black54,
              ),
            ),
            SizedBox(height: 15),
            Text(
              DatesController()
                  .getVerboseDateTimeRepresentation(message.dateTime),
              style: TextStyle(
                fontSize: 16,
                color: message.sent
                    ? Colors.grey[300]
                    : Colors.grey.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
