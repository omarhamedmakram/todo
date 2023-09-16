import 'package:flutter/material.dart';
import 'package:todo/modules/settings_tab/setting_tab.dart';
import 'package:todo/modules/task_tab/task_tab.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;

  List<Widget> Screan = [TaskTab(), SettingTab()];

  @override
  Widget build(BuildContext context) {
    List<String> titleAppBar = ["To Do List", "Settings"];
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(titleAppBar[selectedIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 3)),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Screan[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 9.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0.0,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
    );
  }
}
