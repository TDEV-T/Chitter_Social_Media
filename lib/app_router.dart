import 'package:chitter/screens/login_screen.dart';

class AppRouter {
  static const String login = 'login';

  static get routes => {
        login: (context) => LoginPage(),
      };
}
