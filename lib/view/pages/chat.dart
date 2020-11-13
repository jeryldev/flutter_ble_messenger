import 'package:flutter/material.dart';
import 'package:flutter_ble_messenger/controller/devices_controller.dart';
import 'package:flutter_ble_messenger/controller/messages_controller.dart';
import 'package:flutter_ble_messenger/view/widgets/chat/chat_bubble.dart';
import 'package:flutter_ble_messenger/view/widgets/common/show_alert_dialog_box.dart';
import 'package:get/get.dart';

class Chat extends StatefulWidget {
  final String deviceId;
  final String deviceUsername;
  final String appUser;

  const Chat({
    Key key,
    this.deviceId,
    this.deviceUsername,
    this.appUser,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ScrollController _scrollController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.deviceUsername}',
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Flexible(
              child: GetX<MessagesController>(
                init: MessagesController(),
                builder: (controller) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => _scrollToBottom());

                  var conversation = controller.messages
                      .where((device) =>
                          device.fromId == widget.deviceId &&
                              device.toUsername == widget.appUser ||
                          device.toId == widget.deviceId &&
                              device.fromUsername == widget.appUser)
                      .toList();

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: conversation.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatBubble(
                          message: conversation[index],
                          deviceUsername: widget.deviceUsername,
                          appUser: widget.appUser);
                    },
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: _buildTextComposer(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer(BuildContext context) {
    final _messageController = TextEditingController();

    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.text,
                controller: _messageController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  hintText: 'Send a message',
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
                onEditingComplete: () {
                  onSendButtonPress(
                    controller: _messageController,
                    context: context,
                  );
                },
              ),
            ),
            SizedBox(
              width: 8,
            ),
            ClipOval(
              child: Material(
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).buttonColor.withOpacity(0.4),
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      splashColor: Colors.greenAccent[400],
                      highlightColor: Colors.greenAccent[400],
                      icon: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        onSendButtonPress(
                          controller: _messageController,
                          context: context,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSendButtonPress({
    BuildContext context,
    TextEditingController controller,
  }) async {
    if (controller.text.isNotEmpty) {
      var connectionState = await DevicesController(context).sendMessage(
        toId: widget.deviceId,
        toUsername: widget.deviceUsername,
        fromUsername: widget.appUser,
        message: controller.text,
      );

      if (!connectionState) {
        showAlertDialogBox(
          context: context,
          header: 'Connection Status',
          message:
              'The message is not sent.\n${widget.deviceUsername} is offline at the moment.',
          actionButtons: [
            OutlinedButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }

      controller.clear();
    }
  }
}
