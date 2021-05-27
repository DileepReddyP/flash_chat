import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/message_bubble.dart';
import 'package:flutter/material.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream({
    Key key,
    @required FirebaseFirestore firestore,
    @required this.email,
  })  : _firestore = firestore,
        super(key: key);

  final FirebaseFirestore _firestore;
  final String email;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy('timeStamp').snapshots(),
      builder: (BuildContext context, snapshot) {
        List<Widget> messageBubbles = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final sender = message.get('sender');
          messageBubbles.add(
            MessageBubble(
              sender: sender,
              text: messageText,
              messageFromUser: sender == email,
            ),
          );
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messageBubbles,
            reverse: true,
          ),
        );
      },
    );
  }
}
