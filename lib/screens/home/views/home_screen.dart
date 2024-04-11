import 'package:expense_repository/expense_repository.dart';
import 'package:expensetracker/screens/add_expense/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:expensetracker/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:expensetracker/screens/home/blocs/get_expenses/get_expenses_bloc.dart';
import 'package:expensetracker/screens/home/views/view_screen.dart';
import 'package:expensetracker/screens/stats/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/screens/home/views/main_screen.dart';
import 'package:expensetracker/screens/add_expense/views/add_expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late Color selectedItem = Color(0xFF7F7FD5);
  Color unselectedItem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
          return Scaffold(
              appBar: AppBar(),
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30)
                ),
                child: BottomNavigationBar(
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  selectedItemColor: Colors.red,
                  backgroundColor: Colors.white,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.home,
                          color: index == 0 ? selectedItem : unselectedItem,
                        ),
                        label: 'Home'
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.chart_pie,
                          color: index == 1 ? selectedItem : unselectedItem,
                        ),
                        label: 'Pie Chart'
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () async{
                  Expense? newExpense = await Navigator.push(
                    context,
                    MaterialPageRoute<Expense>(
                      builder: (BuildContext context) =>
                          MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    CreateCategoryBloc(FirebaseExpenseRepo()),
                              ),
                              BlocProvider(
                                create: (context) =>
                                GetCategoriesBloc(FirebaseExpenseRepo())
                                  ..add(
                                      GetCategories()
                                  ),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    CreateExpenseBloc(FirebaseExpenseRepo()),
                              ),
                            ],
                            child: const AddExpense(),
                          ),
                    ),
                  );

                  if(newExpense != null) {
                    setState(() {
                      state.expenses.insert(0,newExpense);
                    });
                  }
                },
                child: const Icon(
                    CupertinoIcons.add
                ),
              ),
              body: index == 0
                  ?  MainScreen(state.expenses)
                  :  MyChart(state.expenses)
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      }
    );
  }
}
