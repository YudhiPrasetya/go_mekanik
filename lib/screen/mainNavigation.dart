// ignore: file_names
import 'package:flutter/material.dart';
import 'package:bmnav_null_safety/bmnav_null_safety.dart' as bmnav_null_safety;
import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/screen/order/orders.dart';
import 'package:go_mekanik/screen/userDasboard.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:page_transition/page_transition.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int? _currentIndex;
  dynamic page;
  bool? isLogin;

  @override
  void initState() {
    _currentIndex = 0;
    page = const Orders();
    _getLogin();

    super.initState();
    // SystemChrome.setPreferredOrientations([
    //       DeviceOrientation.landscapeRight,
    //       DeviceOrientation.landscapeLeft,
    //   ]);
  }

  // @override
  // void dispose() {
  // SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
      bottomNavigationBar: bmnav_null_safety.BottomNav(
          color: Colors.white,
          labelStyle: const bmnav_null_safety.LabelStyle(
              visible: true,
              showOnSelect: false,
              onSelectTextStyle: TextStyle(color: Colors.grey, height: 1.8),
              textStyle: TextStyle(color: Colors.grey, height: 1.8)),
          iconStyle: bmnav_null_safety.IconStyle(
              color: Colors.grey[400], onSelectSize: 22.0, size: 22.0),
          elevation: 6.0,
          onTap: (i) {
            _currentIndex = i;
            _currentPage(i);
          },
          index: _currentIndex,
          items: const [
            bmnav_null_safety.BottomNavItem(icon: Icons.list, label: 'Orders'),
            // bmnav.BottomNavItem(Icons.assignment, label: 'Transaksi'),
            bmnav_null_safety.BottomNavItem(
                icon: Icons.person, label: 'User Dashboard'),
          ]),
    );
  }

  void _currentPage(int i) {
    switch (i) {
      case 0:
        {
          // if (isLogin) {
          setState(() {
            page = const Orders();
          });
        }
        break;
      case 1:
        {
          if (isLogin == true) {
            setState(() {
              page = const UserDashboard();
            });
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const Login(),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 1000)),
                (route) => false);
          }
        }
        break;
    }
  }

  _getLogin() async {
    bool? _isLogin = await SessionManager().getIsLogin();

    setState(() {
      isLogin = _isLogin;
    });
  }
}
