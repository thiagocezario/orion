import 'package:flutter/material.dart';
import 'package:orion/components/groups/search/institution/institution_tile.dart';
import 'package:orion/model/institution.dart';

class InstitutionSearch extends SearchDelegate<Institution> {
  final List<Institution> institutions;
  List<Institution> lastUsed;

  InstitutionSearch(this.institutions) {
    lastUsed = institutions;
  }

  List<Institution> _filterInstitution(
      String query, List<Institution> institutions) {
    List<Institution> filteredInstitutions = List();

    if (query == '') return institutions;

    for (var institution in institutions) {
      if (institution.name.toLowerCase().contains(query.toLowerCase())) {
        filteredInstitutions.add(institution);
      }
    }

    return filteredInstitutions;
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
    List<Institution> filteredInstitutions =
        _filterInstitution(query, institutions);
    lastUsed = filteredInstitutions;

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InstitutionTile(filteredInstitutions[index]);
      },
      itemCount: filteredInstitutions.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InstitutionTile(lastUsed[index]);
      },
      itemCount: lastUsed.length,
    );
  }
}


