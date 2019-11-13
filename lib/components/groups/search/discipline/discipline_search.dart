import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orion/api/resources/discipline_resource.dart';
import 'package:orion/components/groups/search/create_dialog.dart';
import 'package:orion/components/groups/search/discipline/discipline_tile.dart';
import 'package:orion/main.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

class DisciplineSearch extends SearchDelegate<Discipline> {
  final Course selectedCourse;
  final List<Discipline> disciplines;
  List<Discipline> lastUsed;

  DisciplineSearch(this.disciplines, this.selectedCourse) {
    lastUsed = disciplines;
  }

  List<Discipline> _filterDiscipline(
      String query, List<Discipline> institutions) {
    List<Discipline> filteredDisciplines = List();

    if (query == '') return institutions;

    for (var institution in institutions) {
      if (institution.name.toLowerCase().contains(query.toLowerCase())) {
        filteredDisciplines.add(institution);
      }
    }

    return filteredDisciplines;
  }

  void _addNewDiscipline(BuildContext context) async {
    String result = await showDialog(
      context: context,
      builder: (context) {
        return CreateDialog('Disciplina');
      },
    );

    if (result != null && result.length > 3) {
      var data = {"name": result, "course_id": selectedCourse.id};
      await DisciplineResource.create(data).then(
        (response) {
          if (response.statusCode == 201) {
            var json = jsonDecode(response.body);
            Discipline discipline = Discipline.fromJson(json);
            disciplines.add(discipline);
            Provider.of<SearchGroupsProvider>(context).refreshDisciplines(selectedCourse.id);
          } else if (response.statusCode == 401) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Erro'),
                  content:
                      Text("Sua sessão expirou. Por favor entre novamente."),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () =>
                          Navigator.of(context).popAndPushNamed(LoginPageRoute),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Erro'),
                    content: Text(
                        "Ocorreu um erro inesperado. Por favor, tente novamente."),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                });
          }
        },
      ).catchError(
        (error) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Erro'),
                content: Text(
                    "Ocorreu um erro inesperado. Por favor, tente novamente."),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _addNewDiscipline(context),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Discipline> filteredDisciplines =
        _filterDiscipline(query, disciplines);
    lastUsed = filteredDisciplines;

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return DisciplineTile(filteredDisciplines[index]);
      },
      itemCount: filteredDisciplines.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return DisciplineTile(lastUsed[index]);
      },
      itemCount: lastUsed.length,
    );
  }
}
