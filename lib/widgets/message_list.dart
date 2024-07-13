import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/chat_bloc.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is MessageReceived) {
          return ListView.builder(
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return ListTile(
                title: Text(message.message),
                subtitle: Text(message.timestamp.toIso8601String()),
              );
            },
          );
        }
        return const Center(child: Text('No messages yet'));
      },
    );
  }
}
