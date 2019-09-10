import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/institution.dart';

import 'group_filters.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();

  static Future loadInstitutions() async {
    try {
      String json = await rootBundle.loadString('assets/json/institution.json');
      _NewGroupPageState.institutions = institutionFromJson(json);
    } catch (e) {
      print(e);
    }
  }

  static Future loadDisciplines() async {
    try {
      String json = await rootBundle.loadString('assets/json/classes.json');
      _NewGroupPageState.disciplines = disciplineFromJson(json);
    } catch (e) {
      print(e);
    }
  }

  static Future loadCourses() async {
    try {
      String json = await rootBundle.loadString('assets/json/courses.json');
      _NewGroupPageState.courses = courseFromJson(json);
    } catch (e) {
      print(e);
    }
  }
}

class _NewGroupPageState extends State<NewGroupPage> {
  static List<Institution> institutions = List<Institution>();
  static List<Course> courses = List<Course>();
  static List<Discipline> disciplines = List<Discipline>();

  final _formKey = GlobalKey<FormState>();
  final _institutionKey = GlobalKey<AutoCompleteTextFieldState<Institution>>();
  final _courseKey = GlobalKey<AutoCompleteTextFieldState<Course>>();
  final _disciplineKey = GlobalKey<AutoCompleteTextFieldState<Discipline>>();
  final _institutionFieldController = TextEditingController();
  final _courseFieldController = TextEditingController();
  final _classFieldController = TextEditingController();
  AutoCompleteTextField institutionField;
  AutoCompleteTextField courseField;
  AutoCompleteTextField classField;

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
                      item.members.toString(),
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
        return b.members.compareTo(a.members);
      },
      itemSubmitted: (item) {
        setState(() {
          institutionField.textField.controller.text = item.name;
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
                      item.members.toString(),
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
        return b.members.compareTo(a.members);
      },
      itemSubmitted: (item) {
        setState(() {
          courseField.textField.controller.text = item.name;
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
                      item.members.toString(),
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
        return b.members.compareTo(a.members);
      },
      itemSubmitted: (item) {
        setState(() {
          classField.textField.controller.text = item.name;
        });
      },
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
              height: 25.0,
            ),
            getMaterialButton(context, _formKey, 'Procurar', () {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewGroupFilter()),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
