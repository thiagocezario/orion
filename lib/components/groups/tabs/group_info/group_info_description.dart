import 'package:flutter/material.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

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

  void _editDescription(String description) {
    group.description = description;
    GroupResource.updateObject(group);
    Provider.of<MyGroupsProvider>(context).refreshMyGroups();
  }
}
