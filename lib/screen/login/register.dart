// import 'package:device_info/device_info.dart';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/authBloc.dart';
// import 'package:go_mekanik/bloc/authFirebaseBloc.dart';
import 'package:go_mekanik/screen/login/login.dart';
// import 'package:go_mekanik/util/SessionManager.dart';
// import 'package:go_mekanik/screen/mainNavigation.dart';
// import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nikController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isRegister = false;

  bool isValidNIK = false;
  bool isValidUserName = false;
  bool isValidPassword = false;
  bool isValidEmail = false;

  String isValidNIKText = 'NIK harus diisi!';
  String isValidUserNameText = 'User Name harus diisi!';
  String isValidPasswordText = 'Password harus diisi!';
  // String isValidEmailText = 'Email harus diisi!';

  String deviceId = "";
  String tokenFromFirebase = "";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // _getDeviceId();
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
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                      getTitle(),
                      getNIK(state),
                      getUserName(state),
                      // getEmail(state),
                      getPassword(state),
                      getButtonRegister(state),
                      getLogin()
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

  Widget getTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
      child: const Column(
        children: [
          Text(
            'REGISTRASI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          Text(
            'Silahkan isi form registrasi dibawah ini.',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
          )
        ],
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

  Widget getNIK(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'N I K',
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
                    controller: nikController,
                    autofocus: false,
                    onChanged: (text) {
                      validateNIK(state);
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: 'NIK',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    autocorrect: false,
                    validator: (value) {
                      return !isValidNIK ? isValidNIKText : null;
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

  Widget getButtonRegister(state) {
    return Column(
      children: [
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
                    backgroundColor:
                        !isValidNIK || !isValidUserName || !isValidPassword
                            ? Colors.lightBlue[800]?.withOpacity(0.5)
                            : Colors.lightBlue[800],
                  ),
                  onPressed: () {
                    if (isValidNIK && isValidUserName && isValidPassword) {
                      _register();
                      // _getValidateNIK();
                      // _getValidateEmailRegister();
                      // _getValidateUserNameRegister();
                    } else {
                      validateNIK(state);
                      // validateEmail(state);
                      validatePassword(state);
                    }
                    // if (isValidNIK && isValidUserName && isValidPassword) {
                    //   _getValidateNIK();
                    //   _getValidateUserNameRegister();
                    // } else {
                    //   validateNIK(state);
                    //   validateUserName(state);
                    //   validatePassword(state);
                    // }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isRegister
                            ? const SizedBox(
                                height: 16.0,
                                width: 16.0,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Expanded(
                                child: Text('REGISTER',
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

  Widget getLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah punya akun? ',
          style: TextStyle(
              fontFamily: 'Varela',
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              fontSize: 14.0),
        ),
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false);
          },
          child: Text('Login',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue[800],
                  fontSize: 14.0)),
        )
      ],
    );
  }

  validateNIK(StateSetter updateState) async {
    if (nikController.text.isNotEmpty) {
      updateState(() {
        isValidNIK = true;
      });
    } else {
      updateState(() {
        isValidNIK = false;
      });
    }
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

  validatePassword(StateSetter updateState) async {
    if (passwordController.text.length >= 6) {
      updateState(() {
        isValidPassword = true;
      });
    } else {
      updateState(() {
        isValidPasswordText = "Password minimal 6 karakter!";
        isValidPassword = false;
      });
    }
  }

  // _getValidateNIK() async {
  //   final res = await authBloc.getValidateNIK(nikController.text);

  //   bool status = res['status'];
  //   String message = res['message'];

  //   if (status) {
  //     setState(() {
  //       isRegister = false;
  //     });
  //     // _register();
  //   } else {
  //     setState(() {
  //       isRegister = false;
  //     });
  //     ShowToast().showToastError(message);
  //   }
  // }

  // _getValidateUserNameRegister() async {
  //   setState(() {
  //     isRegister = true;
  //   });

  //   final res =
  //       await authBloc.getValidateUserNameRegister(userNameController.text);

  //   bool status = res['status'];
  //   String message = res['message'];

  //   print('res: $res');

  //   if (status == true) {
  //     setState(() {
  //       isRegister = false;
  //     });
  //     _register();
  //   } else if(status == false){
  //     setState(() {
  //       isRegister = false;
  //     });
  //     ShowToast().showToastError(message);
  //   }
  // }

  _register() async {
    // String deviceId = await _getDeviceId();
    final res = await authBloc.register(nikController.text,
        userNameController.text, passwordController.text, tokenFromFirebase);

    bool? status = res['status'];
    String message = res['message'];

    if (kDebugMode) {
      print("status: $status, message: $message");
    }

    if (status == true) {
      // SessionManager().setSession(res1['data']['id']);
      ShowToast().showToast(message);
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: const Login(),
              duration: const Duration(milliseconds: 1500)),
          (route) => false);
    } else if (status == false) {
      ShowToast().showToastError(message);
    }
  }

  firebaseCloudMessagingListeners() {
    if (Platform.isIOS) _iosPermission();

    _firebaseMessaging
        .getToken(
            vapidKey:
                "BO7qbTke1CbmgpmtoFtjHD3kL7voY29kfQs3UW4MUjwx8qjZpn5I9FzP9cM386TRk_u6deHLw43gFE_F3UXRVd8")
        .then((value) {
      assert(value != null);
      setState(() {
        tokenFromFirebase = value!;
      });
      //print('token: $tokenFromFirebase');
    });
  }

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       // print('on message $message');
  //       showMessage(message);
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       // print('on message $message');
  //       showMessage(message);
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       // print('on message $message');
  //       showMessage(message);
  //     },
  //   );
  // }

  _iosPermission() {
    // _firebaseMessaging.requestNotificationPermissions(
    //     IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.requestPermission(
        // IosNotificationSettings(sound: true, badge: true, alert: true));
        sound: true,
        badge: true,
        alert: true);

    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
  }
}
