import 'package:chitter/screens/login/login_screen.dart';
import 'package:chitter/screens/register/register_screen.dart';
import 'package:chitter/screens/testscreens/mainscreen.dart';

class AppRouter {
  static const String login = 'login';
  static const String register = 'register';
  static const String main = 'main';

  static get routes => {
        login: (context) => LoginScreen(),
        register: (context) => RegisterScreen(),
        main: (context) => mainScreen(),
      };
}
