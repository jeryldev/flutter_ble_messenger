class Message {
  final bool sent;
  final String toId;
  final String toUsername;
  final String fromId;
  final String fromUsername;
  final String message;
  final DateTime dateTime;

  Message(
      {this.sent,
      this.toId,
      this.toUsername,
      this.fromId,
      this.fromUsername,
      this.message,
      this.dateTime});
}
