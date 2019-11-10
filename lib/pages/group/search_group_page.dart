import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/components/groups/search/course/course_search.dart';
import 'package:orion/components/groups/search/discipline/discipline_search.dart';
import 'package:orion/components/groups/search/institution/institution_search.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

import 'group_filters.dart';

class SearchGroupPage extends StatefulWidget {
  final Institution institution;
  final Course course;
  final Discipline discipline;

  SearchGroupPage({Key key, this.institution, this.course, this.discipline})
      : super(key: key);

  @override
  _SearchGroupPageState createState() => _SearchGroupPageState();
}

class _SearchGroupPageState extends State<SearchGroupPage> {
  static List<Institution> institutions = List<Institution>();
  static List<Course> courses = List<Course>();
  static List<Discipline> disciplines = List<Discipline>();

  static Institution institution = Institution(name: "Nenhum selecionado");
  static Course course = Course(name: "Nenhum selecionado");
  static Discipline discipline = Discipline(name: "Nenhum selecionado");

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildForm(context),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
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
                    delegate: CourseSearch(items.courses),
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
                    delegate: DisciplineSearch(items.disciplines),
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
              height: 25.0,
            ),
            CustomMaterialButton(
              'Procurar',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewGroupFilter(
                          institution: institution,
                          course: course,
                          discipline: discipline)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
