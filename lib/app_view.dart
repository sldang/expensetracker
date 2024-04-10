import 'package:expense_repository/expense_repository.dart';
import 'package:expensetracker/screens/home/blocs/get_expenses/get_expenses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      home: BlocProvider(
          create: (context) => GetExpensesBloc(
              FirebaseExpenseRepo()
          )..add(GetExpenses()),
          child: const HomeScreen()),
    );
  }
}
