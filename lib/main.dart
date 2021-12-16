import 'package:flutter/material.dart';
import 'package:mylib/Pages/Login/LoginPage.dart';
import 'GenericClasses/Constants.dart';

//bool value = false;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // value = false;
  // print("Main: " + value.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("MyApp: " + value.toString());
    // value = false;
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Globals.subColor,
        buttonBarTheme: const ButtonBarThemeData(
          alignment: MainAxisAlignment.center,
        ),
        dividerColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Globals.mainColor, brightness: Brightness.light),
      ),
      title: "MyLibrary",
      //initialRoute: '/',
      home: const LoginPage(),
      //home: value == true ? HomePage() : LoginScreen(), //LoginPage(),
      //onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
