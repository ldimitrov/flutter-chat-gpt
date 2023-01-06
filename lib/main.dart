import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'model.dart';

void main() => runApp(ChatGptClient());

class ChatGptClient extends StatefulWidget {
  const ChatGptClient({super.key});

  @override
  _ChatGptAppState createState() => _ChatGptAppState();
}

class _ChatGptAppState extends State<ChatGptClient> {
  final _textEditingController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT flutter client',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ChatGPT flutter client'),
        ),
        body: Column(
          children: [
            //chat body
            Expanded(child: _chatMessagesList()),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                _inputPromt(),
                _submitButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded _inputPromt() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textEditingController,
        decoration: const InputDecoration(
            fillColor: Colors.blueGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
      ),
    );
  }

  Widget _submitButton() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: Colors.blueGrey,
        child: IconButton(
            icon: const Icon(
              Icons.send_rounded,
            ),
            onPressed: () {}),
      ),
    );
  }

  ListView _chatMessagesList() {
    return ListView.builder(
        itemCount: _messages.length,
        controller: _scrollController,
        itemBuilder: ((context, index) {

          var message = _messages[index];
          return ChatMessageWidget(
            text: message.text,
            type: message.type,
          );
        }));
  }
}
