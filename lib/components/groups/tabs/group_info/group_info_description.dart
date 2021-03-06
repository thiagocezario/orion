import 'package:flutter/material.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';

class GroupInfoDescription extends StatefulWidget {
  final Group group;

  GroupInfoDescription(this.group);

  @override
  _GroupInfoDescriptionState createState() => _GroupInfoDescriptionState(group);
}

class _GroupInfoDescriptionState extends State<GroupInfoDescription> {
  final TextEditingController _descriptionTextController =
      TextEditingController();

  final FocusNode _descriptionFocusNode = FocusNode();
  final Group group;

  _GroupInfoDescriptionState(this.group) {
    _descriptionTextController.text = group.description;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListTile(
        leading: Icon(Icons.description),
        title: EditableText(
          onSubmitted: (value) {
            _editDescription(value);
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          backgroundCursorColor: themeColor,
          textAlign: TextAlign.justify,
          controller: _descriptionTextController,
          cursorColor: themeColor,
          focusNode: _descriptionFocusNode,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  void _editDescription(String description) async {
    group.description = description;
    await GroupResource.updateObject(group);
  }
}
