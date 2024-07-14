import 'package:ayna_chat/screens/chat_screen.dart';
import 'package:ayna_chat/screens/login.dart';
import 'package:ayna_chat/services/web_socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/chat/chat_bloc.dart';
import 'models/models.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(MessageAdapter());
  await Hive.openBox('userBox');
  await Hive.openBox('chatBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(userBox: Hive.box('userBox')),
        ),
        BlocProvider(
          create: (context) => ChatBloc(
            webSocketService: WebSocketService('wss://echo.websocket.org'),
            messageBox: Hive.box('chatBox'),
          ),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/chat': (context) => ChatPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
