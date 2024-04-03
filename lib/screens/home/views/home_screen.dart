import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/screens/home/views/main_screen.dart';
import 'package:expensetracker/screens/stats/stats.dart';
import 'package:expensetracker/screens/add_expense/views/add_expense.dart';


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
        items:  [
          BottomNavigationBarItem(
              icon: Icon(
                  CupertinoIcons.home,
                  color: index == 0 ? selectedItem : unselectedItem,
              ),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  CupertinoIcons.graph_square_fill,
                  color: index == 1 ? selectedItem : unselectedItem,
              ),
              label: 'Stats'
          ),
        ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpense()),
          );
        },
        child: const Icon(
          CupertinoIcons.add
      ),
      ),
      body: index == 0
        ? MainScreen()
        : StatScreen()
    );
  }
}
