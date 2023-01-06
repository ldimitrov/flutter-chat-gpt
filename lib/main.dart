import 'package:flutter/material.dart';

void main() => runApp(ChatGptClient());

class ChatGptClient extends StatefulWidget {
  @override
  _ChatGptAppState createState() => _ChatGptAppState();
}

class _ChatGptAppState extends State<ChatGptClient> {
  final TextEditingController textEditingController = TextEditingController();
  // final _scrollController = ScrollController();
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
            // Expanded(child: _buildList()),
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
        controller: textEditingController,
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
}
