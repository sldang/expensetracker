import 'package:flutter/material.dart';
import 'screens/home/views/home_screen.dart';


class  MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground: Colors.black,
          primary: Color(0xFF7F7FD5),
          secondary: Color(0xFF91EAE4),
          outline: Colors.grey
        )
      ),
      home: const HomeScreen(),
    );
  }
}
