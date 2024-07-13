import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/chat_bloc.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter your message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              BlocProvider.of<ChatBloc>(context).add(SendMessage(_controller.text));
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
