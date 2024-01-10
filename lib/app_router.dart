import 'package:chitter/screens/homepage/home_screen.dart';
import 'package:chitter/screens/login/login_screen.dart';
import 'package:chitter/screens/register/register_screen.dart';

class AppRouter {
  static const String login = 'login';
  static const String register = 'register';
  static const String main = 'main';
  static const String home = 'home';

  static get routes => {
        login: (context) => LoginScreen(),
        register: (context) => RegisterScreen(),
        home:(context) => HomeScreen(),
      };
}
