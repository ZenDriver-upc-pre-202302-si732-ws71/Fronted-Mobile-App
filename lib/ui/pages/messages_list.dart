import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/message.dart';
import '../../services/message_service.dart';
import 'messages.dart';

String formatDate(DateTime fecha) {
  //fecha - 5 horas
  fecha = fecha.subtract(const Duration(hours: 5));
  String hora = fecha.hour.toString().padLeft(2, '0');
  String minutos = fecha.minute.toString().padLeft(2, '0');
  String periodo = fecha.hour < 12 ? 'AM' : 'PM';

  return '$hora:$minutos $periodo';
}

getColorByRole(String role) {
  switch (role) {
    case 'driver':
      return Colors.white;
    case 'recruiter':
      return Color.fromARGB(255, 68, 158, 109);
    default:
      return Colors.white;
  }
}

getColorTextByRole(String role) {
  switch (role) {
    case 'driver':
      return Colors.grey;
    case 'recruiter':
      return Colors.white;
    default:
      return Colors.grey;
  }
}

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);
  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<Message>? messages;
  MessageService httpHelper = MessageService();
  int? userId = 0;

  Future initialize() async {
    messages = List.empty();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = int.parse(prefs.getString('id')!);
    print(userId);
    messages = await httpHelper.searchLastMessagesByUserId(userId ?? 0);
    setState(() {
      messages = messages;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis mensajes'),
      ),
      body: ListView.builder(
        itemCount: messages!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                border: const Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                  top: BorderSide(
                    color: Colors.grey,
                  ),
                  left: BorderSide(color: Colors.grey),
                  right: BorderSide(color: Colors.grey),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                color: (messages![index].emitter.id != userId)
                    ? getColorByRole(messages![index].emitter.role)
                    : getColorByRole(messages![index].receiver.role)),
            margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    messages![index].emitter.id != userId
                        ? messages![index].emitter.imageUrl
                        : messages![index].receiver.imageUrl),
              ),
              title: Text(
                messages![index].emitter.id != userId
                    ? ('${messages![index].emitter.firstName} ${messages![index].emitter.lastName}')
                    : ('${messages![index].receiver.firstName} ${messages![index].receiver.lastName}'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      (messages![index].emitter.id == userId ? 'Yo: ' : '') +
                          messages![index].content,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (messages![index].emitter.id != userId)
                              ? getColorTextByRole(
                                  messages![index].emitter.role)
                              : getColorTextByRole(
                                  messages![index].receiver.role)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              trailing: Text(formatDate(messages![index].createdAt)),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Messages(
                        emitterId: messages![index].emitter.id == userId
                            ? messages![index].receiver.id
                            : messages![index].emitter.id,
                        receiverId: messages![index].receiver.id == userId
                            ? messages![index].receiver.id
                            : messages![index].emitter.id),
                  ),
                ).then((_) {
                  initialize();
                });
              },
            ),
          );
        },
      ),
    );
  }
}
