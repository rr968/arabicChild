import '/StartPage.dart';
import '/childpage/child/mainchildPage.dart';
import '/controller/my_provider.dart';
import '/firstTimeOpenTheApp/page1.dart';
import '/view/Auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/sharedpref.dart';

//crossAxisAlignment: CrossAxisAlignment.stretch,
//mainAxisSize: MainAxisSize.min,
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyProvider(),
        child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'المتحدث العربي',
            theme: ThemeData(primarySwatch: Colors.grey, fontFamily: "Almarai"),
            home: Start()));
  }
}
