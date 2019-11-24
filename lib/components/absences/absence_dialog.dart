import 'package:flutter/material.dart';
import 'package:orion/api/resources/absence_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/events/evet_dialog.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/model/global.dart';
import 'package:orion/provider/discipline_absences_provider.dart';
import 'package:provider/provider.dart';

class AbsenceDialog extends StatefulWidget {
  final Absence grade;

  AbsenceDialog(this.grade);
  @override
  _AbsenceDialogState createState() => _AbsenceDialogState(grade);
}

class _AbsenceDialogState extends State<AbsenceDialog> {
  bool _saveNeeded = false;
  bool _hasGrade = false;
  bool _hasMaxGrade = false;
  bool _hasDescription = false;
  bool _isCreatingAbsence = true;
  String _screenName = '';
  Absence absence;
  TextEditingController _gradeController = TextEditingController();
  DateTime _formDate = DateTime.now();
  TextEditingController _maxGradeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  _AbsenceDialogState(Absence absence) {
    if (absence != null) {
      this.absence = absence;
      _gradeController.text = absence.quantity.toString();
      // _maxGradeController.text = absence.maxValue;
      // _descriptionController.text = absence.description;
      _screenName = 'Editar falta';
      _isCreatingAbsence = false;
    } else {
      _gradeController.text = '1';
      absence = Absence();
      _screenName = 'Adicionar nova falta';
    }
  }

  void _saveAbsence(Absence absence) {
    if (absence == null) {
      absence = Absence();
    }

    // absence.description = _descriptionController.text;
    // absence.value = _gradeController.text;
    // absence.maxValue = _maxGradeController.text;
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
              'Você tem certeza que deseja excluir essa falta? Essa ação não pode ser desfeita.',
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
                  await AbsenceResource.delete(absence.id.toString())
                      .then((response) {
                    // Navigator.of(context).pop("delete");
                    Provider.of<DisciplineAbsencesProvider>(context)
                        .fetchAbsences(absence.discipline.id.toString());
                  });

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasGrade && _hasMaxGrade && _hasDescription;

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
      onPressed: () => _saveAbsence(absence),
    );

    Widget _deleteAbsenceButton = Container();

    if (!_isCreatingAbsence) {
      _deleteAbsenceButton = IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deleteAbsence(absence),
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
      body: Form(
        onWillPop: _onWillPop,
        child: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Horário', style: textStyle),
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.bottomLeft,
                      width: MediaQuery.of(context).size.width / 2.7,
                      child: TextField(
                        controller: _gradeController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Quantidade'),
                        onChanged: (value) {
                          setState(() {
                            _hasGrade = value.isNotEmpty;

                            if (_hasGrade) {
                              absence.quantity = value as int;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_upward)
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_downward)
                        )
                      ],
                    )
                  ],
                ),
              )
            ].map<Widget>((Widget child) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                height: 96.0,
                child: child,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
