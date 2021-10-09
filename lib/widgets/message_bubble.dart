import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message;
  final isOwn;

  MessageBubble({@required this.message, @required this.isOwn});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isOwn? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(minWidth: 140),
            decoration: BoxDecoration(
                color: isOwn
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            child: Text(
              message,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary),
              textAlign: isOwn? TextAlign.end :  TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
}
