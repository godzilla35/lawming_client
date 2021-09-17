import 'package:client/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/signin.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'models/user_model.dart';

void main() async {
  // 1. 인증
  // 캐싱된 인증 정보 있으면 그걸로 인증 시도. 실패시 로그인 창으로 이동
  // 캐싱된 인증 정보가 없으면 로그인 창으로 이동.

  // 2. 로그인 창
  // 로그인 성공하면 홈으로 이동, 인증 정보 캐싱, 인증 정보를 provider를 이용하여 앱 전체 공유

  // main 메소드에서 비동기 작업을 진행해야하는 경우 반드시 다음 한줄을 실행한다
  //WidgetsFlutterBinding.ensureInitialized();
  //final prefs = await SharedPreferences.getInstance();
  //final loggedID = prefs.getString('loggedID') ?? null;
  //final loggedPassword = prefs.getString('loggedPassword') ?? null;
  //bool isLogged = false;
  //if (loggedID != null && loggedPassword != null) {
  //  Auth auth = Auth(ID: loggedID, Password: loggedPassword);
  //  isLogged = await auth.logIn();
  //}
  //runApp(LawmingApp(initialRoute: isLogged == true ? '/homeScreen' : '/login'));
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: LawmingApp(initialRoute: '/login'),
    ),
  );
}

/// This is the main application widget.
class LawmingApp extends StatelessWidget {
  LawmingApp({this.initialRoute});
  final initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/signin': (context) => SignInPage(),
        '/homeScreen': (context) => HomePage(),
        '/login': (context) => LoginScreen(),
        '/settings': (context) => SettingScreen(),
      },
    );
  }
}
