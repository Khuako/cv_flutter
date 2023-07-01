import 'package:chat_app_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../pages/chat_page.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userName});
  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        onTap: () {
          nextScreen(
            context,
            ChatPage(
              groupId: widget.groupId,
              userName: widget.userName,
              groupName: widget.groupName,
            ),
          );
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            widget.groupName.substring(0, 1).toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        title: Text(
          widget.groupName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Join the conversation as ${widget.userName}',
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
