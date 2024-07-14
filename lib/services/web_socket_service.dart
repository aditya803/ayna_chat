import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String url;
  late WebSocketChannel channel;
  final StreamController<String> _controller = StreamController.broadcast();

  WebSocketService(this.url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
    channel.stream.listen((message) {
      _controller.add(message);
    });
  }

  Stream<String> get messages => _controller.stream;

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  void dispose() {
    channel.sink.close();
    _controller.close();
  }
}
