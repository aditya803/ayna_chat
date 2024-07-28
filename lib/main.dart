import 'package:ayna_chat/screens/chat_screen.dart';
import 'package:ayna_chat/screens/login.dart';
import 'package:ayna_chat/services/web_socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event_state.dart';
import 'blocs/chat/chat_bloc.dart';
import 'blocs/chat/chat_event_state.dart';
import 'models/models.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  await Hive.openBox('messages');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Chat App',
        initialRoute: '/',
        routes: {
          '/': (context) => AuthPage(),
          '/chat': (context) => ChatPage(),
        },
      ),
    );
  }
}

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ChatBloc(
                  webSocketService: WebSocketService('wss://echo.websocket.org'),
                  messageBox: Hive.box('messages'),
                  userId: state.userId,
                )..add(LoadMessages(userId: state.userId)),
              ),
            ],
            child: ChatPage(userId: state.userId),
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
