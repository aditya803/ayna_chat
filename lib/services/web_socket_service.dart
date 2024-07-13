import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/chat_message.dart';

class WebSocketService {
  final WebSocketChannel _channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));

  final StreamController<List<ChatMessage>> _messagesController = StreamController<List<ChatMessage>>.broadcast();
  Stream<List<ChatMessage>> get messages => _messagesController.stream;

  final List<ChatMessage> _messageList = [];

  WebSocketService() {
    _channel.stream.listen((message) {
      final chatMessage = ChatMessage(message: message, timestamp: DateTime.now());
      _messageList.add(chatMessage);
      _messagesController.add(_messageList);
    });
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  Future<List<ChatMessage>> getMessages() async {
    return _messageList;
  }

  void dispose() {
    _channel.sink.close();
    _messagesController.close();
  }
}
