import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'chat_message.dart';
import 'model.dart';

void main() => runApp(const ChatGptClient());

Future<String> loadApiKey() async {
  await dotenv.load();
  return dotenv.get('API_KEY');
}

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

  Future<String> getChatGptResponse(String prompt) async {
    // final apiKey = loadApiKey();
    String apiKey = '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';
    var url = Uri.https("api.openai.com", "/v1/completions");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    Map<String, dynamic> chatGptResponse = jsonDecode(response.body);

    print('Response: $chatGptResponse');
    return chatGptResponse['choices'][0]['text'];
  }

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
            onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textEditingController.text,
                    type: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textEditingController.text;
            _textEditingController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            getChatGptResponse(input).then((value) {
              setState(() {
                isLoading = false;
                _messages.add(
                  ChatMessage(
                    text: value,
                    type: ChatMessageType.bot,
                  ),
                );
              });
            });
            _textEditingController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
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
