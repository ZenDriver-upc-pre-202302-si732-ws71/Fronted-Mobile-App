import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/message.dart';

class MessageService {
  final String _baseUrl = 'https://zendriver.azurewebsites.net/api/v1/message';
  //final String _baseUrl = 'https://localhost:4500/api/v1/message';

  Future<List<Message>> getMessages() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == HttpStatus.ok) {
      final messages = json.decode(response.body).cast<Map<String, dynamic>>();
      return messages.map<Message>((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<Message>> searchByEmitterId(int emitterId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/search-by-id/$emitterId'));
    if (response.statusCode == HttpStatus.ok) {
      final messages = json.decode(response.body).cast<Map<String, dynamic>>();
      return messages.map<Message>((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<Message>> searchLastMessagesByUserId(int userId) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/search-last-messages-receiver-id/$userId'));
    if (response.statusCode == HttpStatus.ok) {
      final messages = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Message> messageList =
          messages.map<Message>((json) => Message.fromJson(json)).toList();
      messageList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return messageList;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<Message>> searchByEmitterIdAndReceiverId(
      int emitterId, int receiverId) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/search-by-emitter-receiver/$emitterId/$receiverId'));
    if (response.statusCode == HttpStatus.ok) {
      final messages = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Message> messageList =
          messages.map<Message>((json) => Message.fromJson(json)).toList();
      messageList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return messageList;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<Message> addMessage(SaveMessageRequest message) async {
    final response = await http.post(Uri.parse('$_baseUrl/add-message'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(message.toJson()));
    if (response.statusCode == HttpStatus.ok) {
      return Message.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create message.');
    }
  }
}
