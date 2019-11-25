import 'package:orion/api/resources/absence_resource.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/provider/discipline_absences_provider.dart';
import 'package:provider/provider.dart';

class AbsenceController {
  static refresh(context, {discipline}) {
    Provider.of<DisciplineAbsencesProvider>(context).fetchAbsences(discipline.id.toString());
  }

  static create(context, {Absence absence}) {
    AbsenceResource.createObject(absence).then(
      (response) {
        refresh(context, discipline: absence.discipline);
      },
    );
  }

  static update(context, {Absence absence}) {
    AbsenceResource.updateObject(absence).then(
      (response) {
        refresh(context, discipline: absence.discipline);
      },
    );
  }

  static remove(context, {Absence absence}) {
    AbsenceResource.delete(absence.id.toString()).then(
      (response) {
        Provider.of<DisciplineAbsencesProvider>(context).removeAbsence(absence);
      },
    );
  }
}
