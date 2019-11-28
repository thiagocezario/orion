import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/components/commom_items/year_picker.dart';
import 'package:orion/components/groups/search/course/course_search.dart';
import 'package:orion/components/groups/search/discipline/discipline_search.dart';
import 'package:orion/components/groups/search/institution/institution_search.dart';
import 'package:orion/controllers/group_controller.dart';
import 'package:orion/main.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

class NewGroupPage extends StatefulWidget {
  final group;

  NewGroupPage({Key key, this.group}) : super(key: key);

  @override
  _NewGroupPageState createState() => _NewGroupPageState(group);
}

class _NewGroupPageState extends State<NewGroupPage> {
  final _groupNameKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  bool _isPrivate = false;
  Icon _privateIcon = Icon(Icons.lock_open);

  TextFormField groupField;

  Institution initialInstitution = Institution(name: "Nenhum selecionado");
  Course initialCourse = Course(name: "Nenhum selecionado");
  Discipline initialDiscipline = Discipline(name: "Nenhum selecionado");

  Group group;

  _NewGroupPageState(this.group);

  void _changeGroupType() {
    setState(() {
      if (_isPrivate) {
        _privateIcon = Icon(Icons.lock_open);
      } else {
        _privateIcon = Icon(Icons.lock);
      }

      _isPrivate = !_isPrivate;
    });
  }

  void _createGroup(BuildContext context) {
    if (_groupNameController.text.length > 3 &&
        group.institution.id != null &&
        group.course.id != null &&
        group.discipline.id != null) {
      group.name = _groupNameController.text;
      group.isPrivate = _isPrivate;

      GroupResource.createObject(group).then(
        (response) {
          if (response.statusCode == 201) {
            var body = json.decode(response.body);
            group = Group.fromJson(body);

            Provider.of<MyGroupsProvider>(context).refreshMyGroups();
            GroupController.refreshAll(context, group: group);

            Navigator.of(context)
                .popAndPushNamed(GroupPageRoute, arguments: group);
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('O Grupo não foi criado!'),
              ),
            );
          }
        },
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Existem informações faltando ou inválidas.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0.0,
        title: Text(
          'Novo Grupo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: _privateIcon,
            onPressed: () {
              _changeGroupType();
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: themeColor,
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    groupField = TextFormField(
      key: _groupNameKey,
      controller: _groupNameController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Nome do Grupo',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      style: textStyle,
    );

    var horizontal = MediaQuery.of(context).size.width / 20;
    var vertical = MediaQuery.of(context).size.height / 12;

    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Consumer<SearchGroupsProvider>(
          builder: (context, items, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 5,
                child: ListTile(
                  isThreeLine: true,
                  leading: Icon(
                    Icons.school,
                    color:
                        group.institution.id == null ? Colors.grey : themeColor,
                  ),
                  title: Text('Instituição'),
                  subtitle: Text(group.institution.name),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    Institution result = await showSearch(
                      context: context,
                      delegate: InstitutionSearch(items.institutions),
                    );

                    if (result != null) {
                      setState(() {
                        group.institution = result;
                        Provider.of<SearchGroupsProvider>(context)
                            .refreshCourses(group.institution.id);
                        group.course = initialCourse;
                        group.discipline = initialDiscipline;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  isThreeLine: true,
                  leading: Icon(
                    Icons.computer,
                    color: group.course.id == null ? Colors.grey : themeColor,
                  ),
                  title: Text('Curso'),
                  subtitle: Text(group.course.name),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    Course result = await showSearch(
                      context: context,
                      delegate: CourseSearch(items.courses, group.institution),
                    );

                    if (result != null) {
                      setState(() {
                        group.course = result;
                        Provider.of<SearchGroupsProvider>(context)
                            .refreshDisciplines(group.course.id);
                        group.discipline = initialDiscipline;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  isThreeLine: true,
                  leading: Icon(
                    Icons.class_,
                    color:
                        group.discipline.id == null ? Colors.grey : themeColor,
                  ),
                  title: Text('Disciplina'),
                  subtitle: Text(group.discipline.name),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    Discipline result = await showSearch(
                      context: context,
                      delegate:
                          DisciplineSearch(items.disciplines, group.course),
                    );

                    if (result != null) {
                      setState(() {
                        group.discipline = result;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  leading: Icon(
                    Icons.calendar_today,
                    color: group.year == null ? Colors.grey : themeColor,
                  ),
                  title: Text("Ano"),
                  subtitle: Text(group.year),
                  trailing: IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () async {
                      var year = await showDialog(
                        context: context,
                        builder: (context) {
                          return YearPickerDialog(group.year);
                        },
                      );

                      if (year != null) {
                        setState(() {
                          group.year = year;
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              groupField,
              SizedBox(
                height: 25.0,
              ),
              CustomMaterialButton('Criar', () {
                _createGroup(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
