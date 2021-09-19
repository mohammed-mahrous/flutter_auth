import 'package:flutter/material.dart';
import 'package:flutter_sanctum_auth_app/pages/homepage.dart';
import 'package:flutter_sanctum_auth_app/pages/loginpage.dart';
import 'package:flutter_sanctum_auth_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => Auth())],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, Auth auth, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: auth.authinticated ? '/' : '/login',
        routes: {
          '/home': (BuildContext context) => HomePage(title: 'homepage'),
          '/login': (BuildContext context) => LoginPage(),
        },
      );
    });
  }
}
