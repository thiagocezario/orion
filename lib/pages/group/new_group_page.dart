import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:orion/api/resources/course_resource.dart';
import 'package:orion/api/resources/discipline_resource.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/api/resources/institution_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/main.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class NewGroupPage extends StatefulWidget {
  final institution;
  final course;
  final discipline;

  NewGroupPage({Key key, this.institution, this.course, this.discipline})
      : super(key: key);

  @override
  _NewGroupPageState createState() => _NewGroupPageState(institution, course, discipline);
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

  Institution institution;
  Course course;
  Discipline discipline;

  _NewGroupPageState(this.institution, this.course, this.discipline) {
    searchInstitutions("");
    searchCourses("");
    searchDisciplines("");

    _institutionFieldController.text = institution.name;
    _courseFieldController.text = course.name;
    _classFieldController.text = discipline.name;
  }

  void searchInstitutions(String text) {
    var data = {'name': text};
    InstitutionResource.list(data).then((response) {
      setState(() {
        _NewGroupPageState.institutions = institutionFromJson(response.body);
      });
    });
  }

  void searchCourses(String text) {
    var data = {'name': text};
    CourseResource.list(data).then((response) {
      _NewGroupPageState.courses = courseFromJson(response.body);
    });
  }

  void searchDisciplines(String text) {
    var data = {'name': text};
    DisciplineResource.list(data).then((response) {
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
      style: textStyle,
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(item.name,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0)),
              ),
              Container(
                width: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.metadata.subscriptions.toString(),
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
                      ),
                    ),
                    Icon(Icons.person),
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
      style: textStyle,
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(item.name,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0)),
              ),
              Container(
                width: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.metadata.subscriptions.toString(),
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
                      ),
                    ),
                    Icon(Icons.person),
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
      style: textStyle,
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(item.name,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0)),
              ),
              Container(
                width: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.metadata.subscriptions.toString(),
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
                      ),
                    ),
                    Icon(Icons.person),
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
      style: textStyle,
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
                Group group = Group(
                  name: _groupNameController.text,
                  institution: institution,
                  course: course,
                  discipline: discipline,
                );
                GroupResource.createObject(group).then((response) {
                  if (response.statusCode == 201) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Grupo criado com sucesso!'),
                      ),
                    );
                    var jsonResponse = json.decode(response.body);
                    var groupId = jsonResponse["id"];

                    SubscriptionResource.subscribe(groupId.toString()).then((response) {
                      Provider.of<MyGroupsProvider>(context).refreshMyGroups();
                      Provider.of<MyEventsProvider>(context).fetchEvents();
                    });

                    Navigator.of(context).popAndPushNamed(GroupPageRoute, arguments: group);
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
