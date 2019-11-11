import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/components/groups/search/course/course_search.dart';
import 'package:orion/components/groups/search/discipline/discipline_search.dart';
import 'package:orion/components/groups/search/institution/institution_search.dart';
import 'package:orion/main.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

class NewGroupPage extends StatefulWidget {
  final institution;
  final course;
  final discipline;

  NewGroupPage({Key key, this.institution, this.course, this.discipline})
      : super(key: key);

  @override
  _NewGroupPageState createState() =>
      _NewGroupPageState(institution, course, discipline);
}

class _NewGroupPageState extends State<NewGroupPage> {
  final _groupNameKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();

  TextFormField groupField;

  Institution institution;
  Course course;
  Discipline discipline;

  _NewGroupPageState(this.institution, this.course, this.discipline);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildForm(context),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
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

    var horizontal = MediaQuery.of(context).size.width / 20;
    var vertical = MediaQuery.of(context).size.height / 7;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: Consumer<SearchGroupsProvider>(
        builder: (context, items, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.school),
                title: Text('Instituição'),
                subtitle: Text(institution.name),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  Institution result = await showSearch(
                    context: context,
                    delegate: InstitutionSearch(items.institutions),
                  );

                  if (result != null) {
                    setState(() {
                      institution = result;
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
                leading: Icon(Icons.computer),
                title: Text('Curso'),
                subtitle: Text(course.name),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  Course result = await showSearch(
                    context: context,
                    delegate: CourseSearch(items.courses, institution),
                  );

                  if (result != null) {
                    setState(() {
                      course = result;
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
                leading: Icon(Icons.class_),
                title: Text('Disciplina'),
                subtitle: Text(discipline.name),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  Discipline result = await showSearch(
                    context: context,
                    delegate: DisciplineSearch(items.disciplines, course),
                  );

                  if (result != null) {
                    setState(() {
                      discipline = result;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            groupField,
            SizedBox(
              height: 25.0,
            ),
            CustomMaterialButton('Criar', () {
              if (_groupNameController.text.length > 3) {
                Group group = Group(
                  name: _groupNameController.text,
                  institution: institution,
                  course: course,
                  discipline: discipline,
                );

                GroupResource.createObject(group).then(
                  (response) {
                    if (response.statusCode == 201) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Grupo criado com sucesso!'),
                        ),
                      );
                      var jsonResponse = json.decode(response.body);
                      var groupId = jsonResponse["id"];

                      SubscriptionResource.subscribe(groupId.toString())
                          .then((response) {
                        Provider.of<MyGroupsProvider>(context)
                            .refreshMyGroups();
                        Provider.of<MyEventsProvider>(context).fetchEvents();
                      });

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
                    content: Text('Nome de grupo vazio ou muito curto.'),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
