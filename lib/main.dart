import 'package:flutter/material.dart';
import 'package:izmalogintask/AppCore/Login/ViewModel/loginVM.dart';
import 'package:izmalogintask/AppCore/Login/Views/LoginView.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  // Set preferred orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
         child: LoginView(),
    )
    );
  }
}



