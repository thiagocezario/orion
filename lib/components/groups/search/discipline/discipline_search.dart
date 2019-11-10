import 'package:flutter/material.dart';
import 'package:orion/components/groups/search/discipline/discipline_tile.dart';
import 'package:orion/model/discipline.dart';

class DisciplineSearch extends SearchDelegate<Discipline> {
  final List<Discipline> disciplines;
  List<Discipline> lastUsed;

  DisciplineSearch(this.disciplines) {
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

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => {},
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
