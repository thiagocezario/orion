import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class NewGroupPage extends StatefulWidget {
  var institution = Institution();
  var course = Course();
  var discipline = Discipline();

  NewGroupPage({Key key, this.institution, this.course, this.discipline})
      : super(key: key);

  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  static List<Institution> institutions = List<Institution>();
  static List<Course> courses = List<Course>();
  static List<Discipline> disciplines = List<Discipline>();

  final _formKey = GlobalKey<FormState>();
  final _institutionKey = GlobalKey<AutoCompleteTextFieldState<Institution>>();
  final _courseKey = GlobalKey<AutoCompleteTextFieldState<Course>>();
  final _disciplineKey = GlobalKey<AutoCompleteTextFieldState<Discipline>>();
  final _groupNameKey = GlobalKey<FormState>();

  final _institutionFieldController = TextEditingController();
  final _courseFieldController = TextEditingController();
  final _classFieldController = TextEditingController();
  final _groupNameController = TextEditingController();

  AutoCompleteTextField institutionField;
  AutoCompleteTextField courseField;
  AutoCompleteTextField classField;
  TextFormField groupField;

  static Institution institution = Institution();
  static Course course = Course();
  static Discipline discipline = Discipline();

  var _singleton = Singleton();

  void searchInstitutions(String text) {
    Client.listInstitutions(_singleton.jwtToken, text).then((response) {
      _NewGroupPageState.institutions = institutionFromJson(response.body);
    });
  }

  void searchCourses(String text) {
    Client.listCourses(_singleton.jwtToken, text).then((response) {
      _NewGroupPageState.courses = courseFromJson(response.body);
    });
  }

  void searchDisciplines(String text) {
    Client.listDisciplines(_singleton.jwtToken, text).then((response) {
      _NewGroupPageState.disciplines = disciplineFromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildForm(context),
      ],
    );
  }

  Form _buildForm(BuildContext context) {
    institutionField = AutoCompleteTextField<Institution>(
      clearOnSubmit: false,
      key: _institutionKey,
      controller: _institutionFieldController,
      itemFilter: (item, query) {
        return item.name.toLowerCase().startsWith(query.toLowerCase());
      },
      suggestionsAmount: 4,
      suggestions: institutions,
      textChanged: (text) => {
        setState(() {
          this.searchInstitutions(text);
          _institutionKey.currentState.updateSuggestions(institutions);
          _institutionKey.currentState.updateOverlay(text);
        })
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Instituição',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      style: getTextStyle(),
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(item.name,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0)),
              Container(
                width: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.person),
                    Text(
                      item.metadata.subscriptions.toString(),
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemSorter: (a, b) {
        return b.metadata.subscriptions.compareTo(a.metadata.subscriptions);
      },
      itemSubmitted: (item) {
        setState(() {
          institutionField.textField.controller.text = item.name;
          institution = item;
        });
      },
    );

    courseField = AutoCompleteTextField<Course>(
      clearOnSubmit: false,
      key: _courseKey,
      controller: _courseFieldController,
      itemFilter: (item, query) {
        return item.name.toLowerCase().startsWith(query.toLowerCase());
      },
      suggestionsAmount: 4,
      suggestions: courses,
      textChanged: (text) => {
        setState(() {
          this.searchCourses(text);
          _courseKey.currentState.updateSuggestions(courses);
          _courseKey.currentState.updateOverlay(text);
        })
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Curso',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      style: getTextStyle(),
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(item.name,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0)),
              Container(
                width: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.person),
                    Text(
                      item.metadata.subscriptions.toString(),
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemSorter: (a, b) {
        return b.metadata.subscriptions.compareTo(a.metadata.subscriptions);
      },
      itemSubmitted: (item) {
        setState(() {
          courseField.textField.controller.text = item.name;
          course = item;
        });
      },
    );

    classField = AutoCompleteTextField<Discipline>(
      clearOnSubmit: false,
      key: _disciplineKey,
      controller: _classFieldController,
      itemFilter: (item, query) {
        return item.name.toLowerCase().startsWith(query.toLowerCase());
      },
      suggestionsAmount: 4,
      suggestions: disciplines,
      textChanged: (text) => {
        setState(() {
          this.searchDisciplines(text);
          _disciplineKey.currentState.updateSuggestions(disciplines);
          _disciplineKey.currentState.updateOverlay(text);
        })
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Disciplina',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      style: getTextStyle(),
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(item.name,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0)),
              Container(
                width: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.person),
                    Text(
                      item.metadata.subscriptions.toString(),
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemSorter: (a, b) {
        return b.metadata.subscriptions.compareTo(a.metadata.subscriptions);
      },
      itemSubmitted: (item) {
        setState(() {
          classField.textField.controller.text = item.name;
          discipline = item;
        });
      },
    );

    groupField = TextFormField(
      key: _groupNameKey,
      controller: _groupNameController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Grupo',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      style: getTextStyle(),
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 36.0, right: 36.0, top: 120.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            institutionField,
            SizedBox(
              height: 10.0,
            ),
            courseField,
            SizedBox(
              height: 10.0,
            ),
            classField,
            SizedBox(
              height: 10.0,
            ),
            groupField,
            SizedBox(
              height: 25.0,
            ),
            getMaterialButton(context, _formKey, 'Criar', () {
              {
                Client.createGroup(_singleton.jwtToken, institution.id,
                        course.id, discipline.id, _groupNameController.text)
                    .then((response) {
                  if (response.statusCode == 201) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Grupo criado com sucesso!'),
                      ),
                    );
                    var jsonResponse = json.decode(response.body);
                    var groupId = jsonResponse["id"];
                    Client.subscribe(_singleton.jwtToken, groupId);
                    Provider.of<MyGroupsProvider>(context).refreshMyGroups();
                    Provider.of<MyEventsProvider>(context).fetchEvents();
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('O Grupo não foi criado!'),
                      ),
                    );
                  }
                });
              }
            })
          ],
        ),
      ),
    );
  }
}