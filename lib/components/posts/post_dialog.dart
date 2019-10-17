import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/post.dart';

class GroupPostDialog extends StatefulWidget {
  final Group group;
  final Post post;
  GroupPostDialog(this.post, this.group);

  @override
  _GroupPostDialogState createState() => _GroupPostDialogState(post, group);
}

class _GroupPostDialogState extends State<GroupPostDialog> {
  bool _saveNeeded = false;
  bool _hasTitle = false;
  bool _hasDescription = false;
  String _screenName = '';
  Post post;
  Group group;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<File> _files = List();

  _GroupPostDialogState(Post post, this.group) {
    if (post != null) {
      this.post = post;
      _titleController.text = post.title;
      _descriptionController.text = post.content;
      _files = post.attachments;
      _screenName = 'Editar publicação';
    } else {
      post = Post();
      _screenName = 'Criar nova publicação';
    }
  }

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasTitle && _hasDescription;

    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'Tem certeza que deseja descartar a publicação?',
                style: dialogTextStyle,
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('CANCELAR'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: const Text('DESCARTAR'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future getAttachment() async {
    var file = await FilePicker.getFile(type: FileType.ANY, fileExtension: '');

    if (file != null) {
      setState(() {
        _files.add(file);
        post.attachments.add(file);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(_screenName),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Salvar',
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white),
            ),
            onPressed: () {
              if (post == null) {
                post = Post();
              }

              post.content = _descriptionController.text;
              post.title = _titleController.text;
              Navigator.of(context).pop(post);
            },
          )
        ],
      ),
      body: Form(
        onWillPop: _onWillPop,
        child: Scrollbar(
          child:
              ListView(padding: const EdgeInsets.all(16.0), children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  setState(() {
                    _hasTitle = value.isNotEmpty;

                    if (_hasTitle) {
                      post.title = value.toString();
                    }
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.bottomLeft,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                maxLines: 5,
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(labelText: 'Descrição'),
                onChanged: (value) {
                  setState(() {
                    _hasDescription = value.isNotEmpty;

                    if (_hasDescription) {
                      post.content = value.toString();
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Anexos',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Builder(
              builder: (BuildContext context) => Container(
                padding: const EdgeInsets.only(bottom: 30.0),
                height: MediaQuery.of(context).size.height * 0.50,
                child: Scrollbar(
                  child: ListView.separated(
                    itemCount:
                        post.attachments != null && post.attachments.isNotEmpty ? post.attachments.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      final String filePath = post.attachments[index].path;
                      final String name = filePath.split("/").last;
                      return ListTile(
                        leading: Icon(Icons.attachment),
                        title: Text(
                          name,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              _files.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.attach_file),
        onPressed: () => getAttachment(),
      ),
    );
  }
}
