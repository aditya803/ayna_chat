import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  User({required this.username, required this.password});
}

@HiveType(typeId: 1)
class Message extends HiveObject {
  @HiveField(0)
  String message;

  // @HiveField(1)
  // bool isSentByMe;

  Message({required this.message});
}
