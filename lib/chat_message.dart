import 'package:flutter/material.dart';

import 'model.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType type;
  const ChatMessageWidget({super.key, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      color: type == ChatMessageType.bot ? Colors.blueGrey : Colors.deepOrange,
      child: Row(
        children: [
          type == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Image.asset(
                      'assets/chatgpt.png',
                      color: Colors.white,
                      scale: 1.0,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
