// import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/authBloc.dart';
import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/screen/machines_breakdown/home_page.dart';
import 'package:go_mekanik/screen/mainNavigation.dart';
// import 'package:go_mekanik/screen/mainNavigation.dart';
// import 'package:go_mekanik/screen/transaksi/scan_barcode.dart';
import 'package:go_mekanik/util/SessionManager.dart';
// import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  String? idUser;
  String? bagian;

  @override
  void initState() {
    _getLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => isLogin == false
                    ? const Login()
                    : FutureBuilder(
                        future: _getBagian(idUser),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            String? bagian = snapshot.data;
                            if (bagian == "Mekanik") {
                              return const MainNavigation();
                            } else {
                              return HomePage(idUser: idUser);
                            }
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ))));
    return Scaffold(
      backgroundColor: Colors.lightBlue[800],
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  '@Copyright 2024. GO-MEKANIK. Powered By GI2-IT Department',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // children: [Image.asset('assets/images/gomekanik_logo.png')],
            children: [
              Image.asset('assets/images/logo.png'),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Smart Maintenance System',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _getLogin() async {
    bool _isLogin = await SessionManager().getIsLogin();
    String? _idUser = await SessionManager().getIdUser();

    setState(() {
      isLogin = _isLogin;
      idUser = _idUser;
      if (kDebugMode) {
        print("isLogin: $isLogin, _isLogin: $_isLogin");
      }
    });
    // if (isLogin == true) {
    //   final res = await authBloc.getByIdUser(idUser);
    //   if (kDebugMode) {
    //     print('res: ${res['data']['Bagian']}');
    //   }
    //   bagian = res['data']['Bagian'];
    // }
  }

  // FutureBuilder<Widget>_changeUI() async {
  //   Widget widget;

  //   String? bag = await _getBagian(idUser);
  //   switch (isLogin) {
  //     case true:
  //       {
  //         bag == "Mekanik"
  //             ? widget = const MainNavigation()
  //             : widget = HomePage(
  //                 idUser: idUser,
  //               );
  //       }
  //       break;
  //     case false:
  //       {
  //         widget = const Login();
  //       }
  //       break;
  //   }
  //   if (kDebugMode) {
  //     print('widget: $widget');
  //   }
  //   return (widget);
  // }

  Future<String>? _getBagian(String? id) async {
    final res = await authBloc.getByIdUser(idUser);

    return res['data']['Bagian'];
    // return res;
  }

  // _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => isLogin ? MainNavigation() : Login(),
  //     transitionDuration: Duration(milliseconds: 1500),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child){
  //       var begin = Offset(0.0, 1.0);
  //       var end = Offset.zero;
  //       var tween = Tween(begin: begin, end: end);
  //       var offsetAnimation = animation.drive(tween);

  //       return SlideTransition(position: offsetAnimation, child: child);
  //     }
  //   );
  // }
}
