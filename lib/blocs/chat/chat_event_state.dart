

import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  final String message;

  const SendMessage({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageReceived extends ChatEvent {
  final String message;

  const MessageReceived({required this.message});

  @override
  List<Object> get props => [message];
}


abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatUpdated extends ChatState {
  final List<Message> messages;

  const ChatUpdated(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatMessageSent extends ChatState {}

class ChatMessageReceived extends ChatState {}

