import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/performance.dart';

class PerformanceDialog extends StatefulWidget {
  final Performance grade;

  PerformanceDialog(this.grade);
  @override
  _PerformanceDialogState createState() => _PerformanceDialogState(grade);
}

class _PerformanceDialogState extends State<PerformanceDialog> {
  bool _saveNeeded = false;
  bool _hasGrade = false;
  bool _hasMaxGrade = false;
  bool _hasDescription = false;
  String _screenName = '';
  Performance grade;
  TextEditingController _gradeController = TextEditingController();
  TextEditingController _maxGradeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  _PerformanceDialogState(Performance grade) {
    if (grade != null) {
      this.grade = grade;
      _gradeController.text = grade.value;
      _maxGradeController.text = grade.maxValue;
      _descriptionController.text = grade.description;
      _screenName = 'Editar nota';
    } else {
      grade = Performance();
      _screenName = 'Adicionar nova nova';
    }
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
                'Tem certeza que deseja descartar a nota?',
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
              if (grade == null) {
                grade = Performance();
              }

              grade.description = _descriptionController.text;
              grade.value = _gradeController.text;
              grade.maxValue = _maxGradeController.text;
              Navigator.of(context).pop(grade);
            },
          )
        ],
      ),
      body: Form(
        onWillPop: _onWillPop,
        child: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  onChanged: (value) {
                    setState(() {
                      _hasDescription = value.isNotEmpty;

                      if (_hasDescription) {
                        grade.description = value.toString();
                      }
                    });
                  },
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
                        decoration: const InputDecoration(labelText: 'Nota'),
                        onChanged: (value) {
                          setState(() {
                            _hasGrade = value.isNotEmpty;

                            if (_hasGrade) {
                              grade.value = value.toString();
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '/',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: MediaQuery.of(context).size.width / 2.7,
                      alignment: Alignment.bottomLeft,
                      child: TextField(
                        controller: _maxGradeController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Nota Máxima'),
                        onChanged: (value) {
                          setState(() {
                            _hasMaxGrade = value.isNotEmpty;

                            if (_hasMaxGrade) {
                              grade.maxValue = value.toString();
                            }
                          });
                        },
                      ),
                    ),
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
