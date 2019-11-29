import 'package:flutter/material.dart';
import 'package:orion/api/resources/absence_resource.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/provider/discipline_absences_provider.dart';
import 'package:provider/provider.dart';

class AbsenceController {
  DisciplineAbsencesProvider disciplineAbsencesProvider;

   setProviders(BuildContext context) {
     disciplineAbsencesProvider = Provider.of<DisciplineAbsencesProvider>(context);
  }

  refresh({discipline}) {
    disciplineAbsencesProvider.fetchAbsences(discipline.id.toString());
  }

  create(context, {Absence absence}) {
    setProviders(context);

    AbsenceResource.createObject(absence).then(
      (response) {
        refresh(discipline: absence.discipline);
      },
    );
  }

  update(context, {Absence absence}) {
    setProviders(context);

    AbsenceResource.updateObject(absence).then(
      (response) {
        refresh(discipline: absence.discipline);
      },
    );
  }

  remove(context, {Absence absence}) {
    setProviders(context);

    AbsenceResource.delete(absence.id.toString()).then(
      (response) {
        disciplineAbsencesProvider.removeAbsence(absence);
      },
    );
  }
}
