import 'package:flutter/material.dart';

class CreateDialog extends StatefulWidget {
  final String label;

  CreateDialog(this.label);

  @override
  _CreateDialogState createState() => _CreateDialogState(label);
}

class _CreateDialogState extends State<CreateDialog> {
  TextEditingController _controller = TextEditingController();
  final String _label;

  _CreateDialogState(this._label);

  void _createPressed() {
    Navigator.of(context).pop(_controller.text);
  }

  void _cancelPressed() {
    Navigator.of(context).pop(null);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar novo(a) $_label'),
      content: TextField(
        controller: _controller,
        maxLength: 30,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCELAR'),
          onPressed: () => _cancelPressed(),
        ),
        FlatButton(
          child: Text('CRIAR'),
          onPressed: () => _createPressed(),
        ),
      ],
    );
  }
}
