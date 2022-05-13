import 'package:custom_app/fifthpage/fifth.dart';
import 'package:custom_app/firstpage/first.dart';
import 'package:custom_app/forthpage/forth.dart';
import 'package:custom_app/save_value.dart';
import 'package:custom_app/secondpage/second.dart';
import 'package:custom_app/splash.dart';
import 'package:custom_app/thirdpage/third.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lock_screen.dart';
import 'other/constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _selectedIndex = 1;
  List<Widget> pages = [
    FirstRoute(),
    SecondRoute(),
    ThirdRoute(),
    ForthRoute(),
    FifthRoute()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isShowSplash = false;

  @override
  void initState() {
    super.initState();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Splash()));

    WidgetsBinding.instance.addObserver(this);
    SaveValue.isFirstTime().then((value) => {
          if (value == null)
            {
              isShowSplash = true,
              setState(() {}),
            },
        });




  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // print("app in resumed");
        // Navigator.of(context).pushNamed('/LockScreen');

        if (Constant.isRequired)
          SaveValue.isLockOn().then((value) => {
                if (value != null && value)
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LockScreen(isGoToMain: false))),
                  }
              });

        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const int iconColor = 0xFF718027;
    const int iconSelectedColor = 0xFF196319;

    return Scaffold(
      body: isShowSplash ? Splash() : pages[_selectedIndex],
      bottomNavigationBar: isShowSplash
          ? null
          : BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage('assets/first.png'),
                      color: _selectedIndex == 0
                          ? Color(iconSelectedColor)
                          : Color(iconColor),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage('assets/second.png'),
                      color: _selectedIndex == 1
                          ? Color(iconSelectedColor)
                          : Color(iconColor),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage('assets/third.png'),
                      color: _selectedIndex == 2
                          ? Color(iconSelectedColor)
                          : Color(iconColor),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage('assets/forth.png'),
                      color: _selectedIndex == 3
                          ? Color(iconSelectedColor)
                          : Color(iconColor),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage('assets/fifth.png'),
                      color: _selectedIndex == 4
                          ? Color(iconSelectedColor)
                          : Color(iconColor),
                    ),
                    label: ''),
              ],
              currentIndex: _selectedIndex,
              backgroundColor: Color(Constant.toolbar_color),
              onTap: _onItemTapped,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
            ),
    );
  }
}
