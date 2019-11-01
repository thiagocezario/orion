import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:provider/provider.dart';

class EventDialog extends StatefulWidget {
  final Event event;

  EventDialog(this.event);

  @override
  _EventDialogState createState() => _EventDialogState(event);
}

class _EventDialogState extends State<EventDialog> {
  DateTime _fromDateTime = DateTime.now();
  bool _saveNeeded = false;
  bool _hasDescription = false;
  bool _hasName = false;
  bool _userCanEditEvent = false;
  bool _isCreating = false;
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDescriptionController = TextEditingController();
  String _screenName;
  Event event;

  _EventDialogState(Event event) {
    if (event != null) {
      this.event = event;
      _eventNameController.text = event.title;
      _eventDescriptionController.text = event.content;
      _fromDateTime = event.date;
      _screenName = 'Editar evento';

      _userCanEditEvent = event.student.id == Singleton().user.id;
    } else {
      event = Event();
      _screenName = 'Criar evento';
      _isCreating = true;
    }
  }

  // Should i notify here or pass on to the Event list screen to deal with it?
  void _saveEvent(Event event) async {
    if (event == null) {
      event = Event();
    }

    event.title = _eventNameController.text;
    event.content = _eventDescriptionController.text;
    event.date = _fromDateTime;
    Navigator.of(context).pop(event);
  }

  Future<bool> _deleteEvent(Event event) async {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Você tem certeza que deseja excluir esse evento? Essa ação não pode ser desfeita.',
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
                  await EventResource.delete(event.id.toString())
                      .then((response) {
                    // Navigator.of(context).pop("delete");
                    Provider.of<GroupEventsProvider>(context)
                        .fetchEvents(event.group.id.toString());
                  });

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<bool> _onWillPop() async {
    _saveNeeded = (_hasDescription && _hasName) || _saveNeeded;
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'Descartar o novo evento?',
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
    Widget _deleteEventButton = Container();
    Widget _saveEventButton = Container();

    if (_userCanEditEvent) {
      _deleteEventButton = IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deleteEvent(event),
      );

      _saveEventButton = IconButton(
        icon: Icon(Icons.save),
        onPressed: () => _saveEvent(event),
      );
    }

    if (_isCreating) {
      _saveEventButton = IconButton(
        icon: Icon(Icons.save),
        onPressed: () => _saveEvent(event),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff8893f2),
        title: Text(_screenName),
        actions: <Widget>[
          _deleteEventButton,
          _saveEventButton,
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
                  enabled: _userCanEditEvent || _isCreating,
                  controller: _eventNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _hasName = value.isNotEmpty;
                      if (_hasName) {
                        event.title = value;
                      }
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  enabled: _userCanEditEvent || _isCreating,
                  controller: _eventDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descriçao',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _hasDescription = value.isNotEmpty;
                      if (_hasDescription) {
                        event.content = value;
                      }
                    });
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Horário', style: textStyle),
                  DateTimeItem(
                    dateTime: _fromDateTime,
                    canUserEdit: _userCanEditEvent || _isCreating,
                    onChanged: (DateTime value) {
                      setState(() {
                        _fromDateTime = value;
                        _saveNeeded = true;
                      });
                    },
                  ),
                ],
              ),
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

class DateTimeItem extends StatelessWidget {
  DateTimeItem(
      {Key key, DateTime dateTime, @required this.onChanged, this.canUserEdit})
      : assert(onChanged != null),
        date = DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;
  final bool canUserEdit;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.subhead,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: theme.dividerColor))),
              child: InkWell(
                onTap: () {
                  if (canUserEdit) {
                    showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: date.subtract(const Duration(days: 30)),
                      lastDate: date.add(const Duration(days: 30)),
                    ).then<void>((DateTime value) {
                      if (value != null)
                        onChanged(DateTime(value.year, value.month, value.day,
                            time.hour, time.minute));
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(DateFormat('EEE, MMM d yyyy').format(date)),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: theme.dividerColor))),
            child: InkWell(
              onTap: () {
                if (canUserEdit) {
                  showTimePicker(
                    context: context,
                    initialTime: time,
                  ).then<void>((TimeOfDay value) {
                    if (value != null)
                      onChanged(DateTime(date.day, date.month, date.year,
                          value.hour, value.minute));
                  });
                }
              },
              child: Row(
                children: <Widget>[
                  Text('${time.format(context)}'),
                  const Icon(Icons.arrow_drop_down, color: Colors.black54),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
