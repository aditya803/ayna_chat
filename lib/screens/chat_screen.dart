import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event_state.dart';
import '../blocs/chat/chat_bloc.dart';
import '../blocs/chat/chat_event_state.dart';

class ChatPage extends StatelessWidget {
  final String userId; // Accept userId parameter
  final TextEditingController messageController = TextEditingController();

  ChatPage({required this.userId}); // Constructor to initialize userId

  void _sendMessage(BuildContext context) {
    if (messageController.text.isNotEmpty) {
      context.read<ChatBloc>().add(SendMessage(message: messageController.text));
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogOut());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatUpdated) {
                  final messages = state.messages;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Align(
                          alignment: Alignment.centerLeft, // All messages are treated the same
                          child: Text(message.message),
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (_) => _sendMessage(context), // Handle Enter key
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(context), // Handle send button
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
