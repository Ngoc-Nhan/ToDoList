import 'package:flutter/material.dart';
import 'package:todolist/screens/calendar_page.dart';
import 'package:todolist/screens/files_page.dart';
import 'package:todolist/screens/home_page.dart';
import 'package:todolist/screens/setting_page.dart';

class LayOutPage extends StatefulWidget {
  const LayOutPage({super.key});

  @override
  State<LayOutPage> createState() => _LayOutPageState();
}

class _LayOutPageState extends State<LayOutPage> {
  int _currentIndex = 0;
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(),
      CalendarPage(),
      FilesPage(),
      SettingPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: IndexedStack(index: _currentIndex, children: pages),
      // Nut +
      floatingActionButton: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.pink.shade200,
        ),
        child: IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            icon: Icon(Icons.add, color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //bottom bar
      // child: Padding(
      // padding: const EdgeInsets.only(bottom: 8.0),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomAppBar(
            elevation: 0,
            shape: CircularNotchedRectangle(),
            // notchMargin: 6.0,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tab(Icons.home_rounded, 0),
                _tab(Icons.calendar_month, 1),
                SizedBox(width: 48),
                _tab(Icons.folder_rounded, 2),
                _tab(Icons.settings, 3)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _tab(IconData icon, int index) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsetsGeometry.only(bottom: 6),
        child: Icon(icon,
            size: 40, color: isActive ? Colors.pink.shade200 : Colors.grey),
      ),
    );
  }
}
