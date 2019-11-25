import 'package:flutter/material.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';

class GroupInfoName extends StatefulWidget {
  final Group group;

  GroupInfoName(this.group);

  @override
  _GroupInfoNameState createState() => _GroupInfoNameState(group);
}

class _GroupInfoNameState extends State<GroupInfoName> {
  final TextEditingController _nameTextController =
      TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final Group group;

  _GroupInfoNameState(this.group) {
    _nameTextController.text = group.name;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListTile(
        leading: Icon(Icons.people),
        title: EditableText(
          onSubmitted: (value) {
            _editName(value);
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
         backgroundCursorColor: themeColor,
          textAlign: TextAlign.justify,
          controller: _nameTextController,
          cursorColor: themeColor,
          focusNode: _nameFocusNode,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  void _editName(String name) async {
    group.name = name;
    await GroupResource.updateObject(group);
  }
}
