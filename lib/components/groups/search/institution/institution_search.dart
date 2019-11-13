import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orion/api/resources/institution_resource.dart';
import 'package:orion/components/groups/search/create_dialog.dart';
import 'package:orion/components/groups/search/institution/institution_tile.dart';
import 'package:orion/main.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

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

  void _addNewInstitution(BuildContext context) async {
    String result = await showDialog(
      context: context,
      builder: (context) {
        return CreateDialog('Instituição');
      },
    );

    if (result != null && result.length > 3) {
      var data = {"name": result};
      await InstitutionResource.create(data).then(
        (response) {
          if (response.statusCode == 201) {
            var json = jsonDecode(response.body);
            Institution institution = Institution.fromJson(json);
            institutions.add(institution);
            Provider.of<SearchGroupsProvider>(context).refreshItems();
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
              },
            );
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
        onPressed: () => _addNewInstitution(context),
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
