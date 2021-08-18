import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message;
  final isOwn;

  MessageBubble({@required this.message, @required this.isOwn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isOwn? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(minWidth: 140),
            decoration: BoxDecoration(
                color: isOwn
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            child: Text(
              message,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary),
              textAlign: isOwn? TextAlign.start :  TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
