import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/chat_message.dart';
import '../services/web_socket_service.dart';

class ChatEvent {}
class SendMessage extends ChatEvent {
  final String message;

  SendMessage(this.message);
}

class ChatState {}
class ChatInitial extends ChatState {}
class MessageReceived extends ChatState {
  final List<ChatMessage> messages;

  MessageReceived(this.messages);
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebSocketService webSocketService;

  ChatBloc(this.webSocketService) : super(ChatInitial()) {
    webSocketService.messages.listen((message) {
      add(SendMessage(message as String));
    });
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is SendMessage) {
      webSocketService.sendMessage(event.message);
      final messages = await webSocketService.getMessages();
      yield MessageReceived(messages);
    }
  }
}
