import 'package:flutter/material.dart';
import 'package:orion/api/resources/performance_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:provider/provider.dart';

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
  bool _isCreatingPerformance = true;
  String _screenName = '';
  Performance performance;
  TextEditingController _gradeController = TextEditingController();
  TextEditingController _maxGradeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  _PerformanceDialogState(Performance performance) {
    if (performance != null) {
      this.performance = performance;
      _gradeController.text = performance.value;
      _maxGradeController.text = performance.maxValue;
      _descriptionController.text = performance.description;
      _screenName = 'Editar nota';
      _isCreatingPerformance = false;
    } else {
      performance = Performance();
      _screenName = 'Adicionar nova nota';
    }
  }

  void _savePerformance(Performance performance) {
    if (performance == null) {
      performance = Performance();
    }

    performance.description = _descriptionController.text;
    performance.value = _gradeController.text;
    performance.maxValue = _maxGradeController.text;
    Navigator.of(context).pop(performance);
  }

  Future<bool> _deletePerformance(Performance performance) async {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Você tem certeza que deseja excluir essa nota? Essa ação não pode ser desfeita.',
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
                  await PerformanceResource.delete(performance.id.toString())
                      .then((response) {
                    // Navigator.of(context).pop("delete");
                    Provider.of<DisciplinePerformancesProvider>(context)
                        .fetchPerformances(
                            performance.discipline.id.toString());
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
    IconButton _savePerformanceButton = IconButton(
      icon: Icon(Icons.save),
      onPressed: () => _savePerformance(performance),
    );

    Widget _deletePerformanceButton = Container();

    if (!_isCreatingPerformance) {
      _deletePerformanceButton = IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deletePerformance(performance),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(_screenName),
        actions: <Widget>[
          _deletePerformanceButton,
          _savePerformanceButton,
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
                        performance.description = value.toString();
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
                              performance.value = value.toString();
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
                              performance.maxValue = value.toString();
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
