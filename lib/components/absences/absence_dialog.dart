import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/events/evet_dialog.dart';
import 'package:orion/controllers/absence_controller.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/model/global.dart';

class AbsenceDialog extends StatefulWidget {
  final Absence grade;

  AbsenceDialog(this.grade);
  @override
  _AbsenceDialogState createState() => _AbsenceDialogState(grade);
}

class _AbsenceDialogState extends State<AbsenceDialog> {
  int _absences;
  bool _saveNeeded;
  bool _isCreatingAbsence;
  String _screenName;
  Absence _absence;
  DateTime _formDate;

  _AbsenceDialogState(Absence absence) {
    if (absence != null) {
      this._absence = absence;
      _formDate = absence.date;
      _absences = absence.quantity;
      _saveNeeded = false;
      _isCreatingAbsence = false;
      _screenName = 'Editar falta';
    } else {
      this._absence = Absence();
      _formDate = DateTime.now();
      _absences = 1;
      _saveNeeded = true;
      _isCreatingAbsence = true;
      _screenName = 'Adicionar nova falta';
    }
  }

  void _saveAbsence(Absence absence) {
    if (absence == null) {
      absence = Absence();
    }

    absence.date = _formDate;
    absence.quantity = _absences;
    absence.year = _formDate.year;
    Navigator.of(context).pop(absence);
  }

  Future<bool> _deleteAbsence(Absence absence) async {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Você tem certeza que deseja excluir essa falta?',
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
                child: const Text('EXCLUIR'),
                onPressed: () async {
                  AbsenceController.remove(context, absence: absence);

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<bool> _onWillPop() async {
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'Tem certeza que deseja descartar a falta?',
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

  @override
  Widget build(BuildContext context) {
    IconButton _saveAbsenceButton = IconButton(
      icon: Icon(Icons.save),
      onPressed: () => _saveAbsence(_absence),
    );

    Widget _deleteAbsenceButton = Container();
    if (!_isCreatingAbsence) {
      _deleteAbsenceButton = IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deleteAbsence(_absence),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(_screenName),
        actions: <Widget>[
          _deleteAbsenceButton,
          _saveAbsenceButton,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: FloatingActionButton(
                heroTag: 'decrease',
                onPressed: () {
                  setState(() {
                    _absences -= 1;
                  });
                },
                backgroundColor: themeColor,
                child: Icon(Icons.arrow_downward),
              ),
            ),
            FloatingActionButton(
              heroTag: 'increase',
              onPressed: () {
                setState(() {
                  _absences += 1;
                });
              },
              backgroundColor: themeColor,
              child: Icon(Icons.arrow_upward),
            )
          ],
        ),
      ),
      body: Form(
        onWillPop: _onWillPop,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                '$_absences ${_absences == 1 ? 'falta' : 'faltas'}',
                style: TextStyle(color: themeColor, fontSize: 40),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Data', style: textStyle),
                  DateItem(
                    dateTime: _formDate,
                    canUserEdit: true,
                    onChanged: (DateTime value) {
                      setState(() {
                        _formDate = value;
                        _saveNeeded = true;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
