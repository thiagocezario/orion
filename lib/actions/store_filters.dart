import 'package:orion/model/institution.dart';
import 'package:shared_preferences/shared_preferences.dart';

void storeInstitution(Institution institution) {
  SharedPreferences.getInstance().then((prefs) {
    prefs.setString('institution_id', institution.id.toString());
    prefs.setString('institution_name', institution.name.toString());
  });
}

Future getStoredInstitution() async {
  SharedPreferences.getInstance().then((prefs) {
    int id = prefs.getInt('institution_id');
    if (id == null) {
      return null;
    }

    Institution institution = Institution(
      id: id,
      name: prefs.getString('institution_name'),
    );
    return institution;
  });
}
