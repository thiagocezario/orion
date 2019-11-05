import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';

class GroupInfoDescription extends StatelessWidget {
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();
  final Group group;

  GroupInfoDescription(this.group);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListTile(
        leading: Icon(Icons.description),
        title: EditableText(
          backgroundCursorColor: Colors.black,
          textAlign: TextAlign.justify,
          controller: _descriptionTextController,
          cursorColor: Colors.black,
          focusNode: _descriptionFocusNode,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
