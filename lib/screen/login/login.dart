// import 'dart:convert';

// import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_mekanik/bloc/authBloc.dart';
import 'package:go_mekanik/screen/login/register.dart';
import 'package:go_mekanik/screen/lupaPassword/cekNIK.dart';
import 'package:go_mekanik/screen/machines_breakdown/home_page.dart';
import 'package:go_mekanik/screen/mainNavigation.dart';
// import 'package:go_mekanik/screen/transaksi/scan_barcode.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLogin = false;
  bool isValidUserName = false;
  bool isValidPassword = false;
  bool isValidEmail = false;

  String isValidEmailText = 'Email harus diisi!';
  String isValidUserNameText = 'User Name harus diisi!';
  String isValidPasswordText = 'Password harus diisi!';

  String? tokenFromFirebase;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    firebaseCloudMessagingListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainNavigation()),
            (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: const AssetImage('assets/images/app.jpg'),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.05), BlendMode.dstATop),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      getLogo(),
                      getUserName(state),
                      // getEmail(state),
                      getPassword(state),
                      getButtonLogin(state),
                      getRegistrasi()
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getLogo() {
    return Container(
      padding: const EdgeInsets.all(60.0),
      child: Center(
        child: Image.asset(
          'assets/images/gomekanik_logo2.png',
          width: 100.0,
          // color: Colors.lightBlue[800],
        ),
      ),
    );
  }

  Widget getUserName(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'USER NAME',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[800],
                      fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: userNameController,
                    autofocus: false,
                    onChanged: (text) {
                      validateUserName(state);
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: 'User Name...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    autocorrect: false,
                    validator: (value) {
                      return !isValidUserName ? isValidUserNameText : null;
                    },
                  ),
                )
              ]),
        ),
        const SizedBox(height: 24.0)
      ],
    );
  }

  Widget getEmail(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'EMAIL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[800],
                      fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: emailController,
                    autofocus: false,
                    onChanged: (text) {
                      validateEmail(state);
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: 'Email...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    autocorrect: false,
                    validator: (value) {
                      return !isValidEmail ? isValidEmailText : null;
                    },
                  ),
                )
              ]),
        ),
        const SizedBox(height: 24.0)
      ],
    );
  }

  Widget getPassword(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'PASSWORD',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[800],
                      fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    obscureText: true,
                    autofocus: false,
                    onChanged: (text) {
                      validatePassword(state);
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: '*******',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    autocorrect: false,
                    validator: (value) {
                      return !isValidPassword ? isValidPasswordText : null;
                    },
                  ),
                )
              ]),
        ),
        const SizedBox(height: 24.0)
      ],
    );
  }

  Widget getButtonLogin(state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const CekNIK(),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 1000)));
                },
                child: Text(
                  'Lupa password?',
                  style:
                      TextStyle(color: Colors.lightBlue[800], fontSize: 14.0),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 24.0),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                // ignore: deprecated_member_use
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    backgroundColor: !isValidUserName || !isValidPassword
                        ? Colors.lightBlue[800]?.withOpacity(0.5)
                        : Colors.lightBlue[800],
                  ),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30.0)),
                  // color: !isValidUserName || !isValidPassword
                  //     ? Colors.lightBlue[800].withOpacity(0.5)
                  //     : Colors.lightBlue[800],
                  onPressed: () {
                    // if (isValidEmail && isValidPassword) {
                    //   _login();
                    // } else {
                    //   validateEmail(state);
                    //   validatePassword(state);
                    // }
                    if (isValidUserName && isValidPassword) {
                      _getValidateUserName();
                    } else {
                      validateUserName(state);
                      validatePassword(state);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLogin
                            ? const SizedBox(
                                height: 16.0,
                                width: 16.0,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Expanded(
                                child: Text('LOG IN',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24.0,
        )
      ],
    );
  }

  Widget getRegistrasi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Belum mendaftar? ',
          style: TextStyle(
              fontFamily: 'Varela',
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              fontSize: 14.0),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const Register(),
                    type: PageTransitionType.leftToRight,
                    duration: const Duration(milliseconds: 1000)));
          },
          child: Text('Daftar',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue[800],
                  fontSize: 14.0)),
        )
      ],
    );
  }

  validateUserName(StateSetter updateState) async {
    if (userNameController.text.isNotEmpty) {
      updateState(() {
        isValidUserName = true;
      });
    } else {
      updateState(() {
        isValidUserName = false;
      });
    }
  }

  validateEmail(StateSetter updateState) async {
    if (emailController.text.isNotEmpty) {
      updateState(() {
        isValidEmail = true;
      });
    } else {
      updateState(() {
        isValidEmail = false;
      });
    }
  }

  validatePassword(StateSetter updateState) async {
    if (passwordController.text.length >= 6) {
      updateState(() {
        isValidPassword = true;
      });
    } else {
      updateState(() {
        isValidPassword = false;
      });
    }
  }

  _getValidateUserName() async {
    setState(() {
      isLogin = true;
    });

    final res = await authBloc.getValidateUserName(userNameController.text);

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      setState(() {
        isLogin = false;
      });
      _login();
    } else {
      setState(() {
        isLogin = false;
      });
      ShowToast().showToastError(message);
    }
  }

  _login() async {
    final res = await authBloc.login(
        userNameController.text, passwordController.text, tokenFromFirebase!);

    bool? status = res['status'];
    String message = res['message'];
    if (status == true) {
      //cek token
      SessionManager().setSession(res['data']['id'], res['data']['nik']);
      ShowToast().showToastSuccess(message);

      if (kDebugMode) {
        print('id_user: ${res['data']['id']}');
      }

      switch (res['data']['bagian']) {
        case "Mekanik":
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 2500),
                  child: const MainNavigation()),
              // MaterialPageRoute(
              //   builder: (context) => MainNavigation(),
              // ),
              (route) => false);
          break;
        case "SPV Sewing":
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 2500),
                  // child: ScanBarcode()),
                  child: HomePage(
                    idUser: res['data']['id'],
                  )),
              // MaterialPageRoute(
              //   builder: (context) => MainNavigation(),
              // ),
              (route) => false);
          //
          break;
      }
    } else {
      ShowToast().showToastError(message);
    }
  }

  firebaseCloudMessagingListeners() {
    // if (Platform.isIOS) _iosPermission();

    _firebaseMessaging
        .getToken(
            vapidKey:
                "BO7qbTke1CbmgpmtoFtjHD3kL7voY29kfQs3UW4MUjwx8qjZpn5I9FzP9cM386TRk_u6deHLw43gFE_F3UXRVd8")
        .then((value) {
      // assert(value != null);
      setState(() {
        tokenFromFirebase = value;
      });
      // print('token: $token');
    });

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     // print('on message $message');
    //     showMessage(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     // print('on message $message');
    //     showMessage(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     // print('on message $message');
    //     showMessage(message);
    //   },
    // );
  }

  // _iosPermission() {
  //   _firebaseMessaging.requestNotificationPermissions(
  //       IosNotificationSettings(sound: true, badge: true, alert: true));

  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  // }
}
