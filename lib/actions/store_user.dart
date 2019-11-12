import 'package:orion/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void storeUser(User user, String token) {
  SharedPreferences.getInstance().then((prefs) {
    prefs.setString('token', token);
    prefs.setInt('user_id', user.id);
    prefs.setString('user_email', user.email);
    prefs.setString('user_name', user.name);
  });
}

Future getStoredUser() {
  return SharedPreferences.getInstance().then((prefs) {
    String token = prefs.getString('token');
    User user = User(
        id: prefs.getInt('user_id'),
        name: prefs.getString('user_name'),
        email: prefs.getString('user_email'));

    Singleton(user: user, jwtToken: token);
    Singleton().user = user;
    Singleton().jwtToken = token;
    return prefs;
  });
}
