import 'package:flutter/material.dart';

class YearPickerDialog extends StatefulWidget {
  final String year;

  YearPickerDialog(this.year);

  @override
  _YearPickerDialogState createState() => _YearPickerDialogState(year);
}

class _YearPickerDialogState extends State<YearPickerDialog> {
  String year;

  _YearPickerDialogState(this.year);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Selecione o ano:"),
      content: Container(
        height: 250,
        width: double.maxFinite,
          child: YearPicker(
            firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
            lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
            selectedDate: DateTime(int.parse(year)),
            onChanged: (DateTime value) {
              setState(
                () {
                  year = value.year.toString();
                },
              );
            },
          ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("CANCELAR"),
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        FlatButton(
          child: Text("SELECIONAR"),
          onPressed: () {
            Navigator.of(context).pop(year);
          },
        ),
      ],
    );
  }
}
