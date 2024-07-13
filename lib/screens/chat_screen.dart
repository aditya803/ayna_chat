import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/chat_bloc.dart';
import '../services/web_socket_service.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/message_list.dart';

class ChatScreen extends StatelessWidget {
  final WebSocketService _webSocketService = WebSocketService();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLogout());
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ChatBloc(_webSocketService),
        child: Column(
          children: [
            const Expanded(
              child: MessageList(),
            ),
            ChatInputField(),
          ],
        ),
      ),
    );
  }
}
