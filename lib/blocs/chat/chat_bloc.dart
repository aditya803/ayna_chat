
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../models/models.dart';
import '../../services/web_socket_service.dart';
import 'chat_event_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebSocketService webSocketService;
  final Box messageBox;
  late String userId;

  ChatBloc({required this.webSocketService, required this.messageBox, required String userId}) : super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
    on<MessageReceived>(_onMessageReceived);
    on<LoadMessages>(_onLoadMessages);

    webSocketService.messages.listen((message) {
      add(MessageReceived(message: message));
    });
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) {
    final message = Message(event.message, isSentByMe: true, userId: userId);
    messageBox.add(message);
    emit(ChatUpdated(List.from(messageBox.values.where((msg) => msg.userId == userId))));
  }

  void _onMessageReceived(MessageReceived event, Emitter<ChatState> emit) {
    final message = Message(event.message, isSentByMe: false, userId: userId);
    messageBox.add(message);
    emit(ChatUpdated(List.from(messageBox.values.where((msg) => msg.userId == userId))));
  }

  void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) {
    userId = event.userId;
    emit(ChatUpdated(List.from(messageBox.values.where((msg) => msg.userId == userId))));
  }
}
