import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/components/commom_items/year_picker.dart';
import 'package:orion/components/groups/search/course/course_search.dart';
import 'package:orion/components/groups/search/discipline/discipline_search.dart';
import 'package:orion/components/groups/search/institution/institution_search.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
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

  static Institution initialInstitution =
      Institution(name: "Nenhum selecionado");
  static Course initialCourse = Course(name: "Nenhum selecionado");
  static Discipline initialDiscipline = Discipline(name: "Nenhum selecionado");

  Group group = Group(
    institution: initialInstitution,
    course: initialCourse,
    discipline: initialDiscipline,
    year: DateTime.now().year.toString(),
  );

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
    var vertical = MediaQuery.of(context).size.height / 10;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: Consumer<SearchGroupsProvider>(
        builder: (context, items, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 5,
              child: ListTile(
                isThreeLine: true,
                leading: Icon(Icons.school,
                    color: group.institution.id == null
                        ? Colors.grey
                        : themeColor),
                title: Text('Instituição'),
                subtitle: Text(group.institution.name),
                trailing: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_forward_ios,
                        color: group.institution.id == null
                            ? Colors.grey
                            : themeColor),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                onTap: () async {
                  Institution result = await showSearch(
                    context: context,
                    delegate: InstitutionSearch(items.institutions),
                  );

                  if (result != null) {
                    setState(() {
                      group.institution = result;
                      Provider.of<SearchGroupsProvider>(context)
                          .refreshCourses(result.id);
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
                leading: Icon(Icons.computer,
                    color: group.course.id == null ? Colors.grey : themeColor),
                title: Text('Curso'),
                subtitle: Text(group.course.name),
                trailing: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_forward_ios,
                        color:
                            group.course.id == null ? Colors.grey : themeColor),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
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
                leading: Icon(Icons.class_,
                    color:
                        group.discipline.id == null ? Colors.grey : themeColor),
                title: Text('Disciplina'),
                subtitle: Text(group.discipline.name),
                trailing: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_forward_ios,
                        color: group.discipline.id == null
                            ? Colors.grey
                            : themeColor),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                onTap: () async {
                  Discipline result = await showSearch(
                    context: context,
                    delegate: DisciplineSearch(items.disciplines, group.course),
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
                  onTap: () async {
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
                  leading: Icon(
                    Icons.calendar_today,
                    color: group.year == null ? Colors.grey : themeColor,
                  ),
                  title: Text("Ano"),
                  subtitle: Text(group.year),
                  trailing: Icon(Icons.keyboard_arrow_down)),
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
                            group: group,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
