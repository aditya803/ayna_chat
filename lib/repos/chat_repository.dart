import 'package:hive/hive.dart';
import '../models/chat_message.dart';

class ChatRepository {
  Future<void> storeMessage(ChatMessage message) async {
    var box = await Hive.openBox('chatBox');
    box.add(message);
  }

  Future<List<ChatMessage>> getChatHistory() async {
    var box = await Hive.openBox('chatBox');
    return box.values.cast<ChatMessage>().toList();
  }
}
