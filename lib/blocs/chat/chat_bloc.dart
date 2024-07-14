import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import '../../models/models.dart';
import '../../services/web_socket_service.dart';
import 'chat_event_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebSocketService webSocketService;
  final Box messageBox;

  ChatBloc({required this.webSocketService, required this.messageBox}) : super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
    on<MessageReceived>(_onMessageReceived);

    webSocketService.messages.listen((message) {
      add(MessageReceived(message: message));
    });
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) {
    final message = Message(message: event.message);
    // messageBox.add(message);
    webSocketService.sendMessage(event.message);
    emit(ChatUpdated(List.from(messageBox.values)));
  }

  void _onMessageReceived(MessageReceived event, Emitter<ChatState> emit) {
    final message = Message(message: event.message);
    messageBox.add(message);
    emit(ChatUpdated(List.from(messageBox.values)));
  }
}
