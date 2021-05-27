import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String sender, text;
  final bool messageFromUser;
  const MessageBubble({
    Key key,
    this.sender,
    this.text,
    this.messageFromUser = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            messageFromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            color: messageFromUser ? Colors.lightBlueAccent : Colors.white,
            borderRadius: BorderRadius.only(
              topRight: messageFromUser
                  ? Radius.circular(0.0)
                  : Radius.circular(30.0),
              topLeft: messageFromUser
                  ? Radius.circular(30.0)
                  : Radius.circular(0.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: messageFromUser ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
