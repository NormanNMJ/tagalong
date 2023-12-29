import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> messages = [
    ChatMessage(text: 'Hello!', isMe: false),
    ChatMessage(text: 'Hi there!', isMe: true),
    ChatMessage(text: 'How are you?', isMe: false),
    ChatMessage(text: 'I\'m doing well, thanks!', isMe: true),
    // Add more chat messages as needed
  ];

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Friend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Align(
                    alignment: message.isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: message.isMe ? Colors.blue : Colors.green,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          message.text,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        contentPadding: const EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FloatingActionButton(
                    onPressed: () {
                      sendMessage();
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    String messageText = _textController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(text: messageText, isMe: true));
        _textController.clear();
      });
    }
  }
}
