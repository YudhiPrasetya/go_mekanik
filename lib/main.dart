import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:go_mekanik/screen/widget/order/sympton.dart';
import 'package:go_mekanik/screen/widget/splashScreen.dart';
//import 'package:package_info_plus/package_info_plus.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'screen/widget/customDialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:responsive_builder/responsive_builder.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  await Firebase.initializeApp();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FirebaseMessaging _firebaseMessaging;

  String token = '';
  // static String dataLine = '';
  static String dataMachineBrand = '';
  static String dataMachineType = '';
  static String dataMachineSN = '';
  static String dataSymptom = '';
  static String dataBarcode = '';

  // PackageInfo _packageInfo = PackageInfo(
  //     appName: 'Unknown',
  //     packageName: 'Unknown',
  //     version: 'Unknown',
  //     buildNumber: 'Unknown',
  //     buildSignature: 'Unknown',
  //     installerStore: 'Unknown');

  // static Future<dynamic>? onBackgroundMessage(Map<String, dynamic> message) {
  //   print('onBackgroundMessage: $message');
  //   if (message.containsKey('data')) {
  //     String line = '';
  //     String machineBrand = '';
  //     String machineType = '';
  //     String machineSN = '';
  //     String symptom = '';
  //     if (Platform.isIOS) {
  //       line = message['Line'];
  //       machineBrand = message['Machine Brand'];
  //       machineType = message['Machine Type'];
  //       machineSN = message['Machine SN'];
  //       symptom = message['Symptom'];
  //     } else if (Platform.isAndroid) {
  //       var data = message['data'];
  //       line = data['Line'];
  //       machineBrand = data['Machine Brand'];
  //       machineType = data['Machine Type'];
  //       machineSN = data['Machine SN'];
  //       symptom = data['Symptom'];
  //     }
  //     dataLine = line;
  //     dataMachineBrand = machineBrand;
  //     dataMachineType = machineType;
  //     dataMachineSN = machineSN;
  //     dataSymptom = symptom;
  //   }

  //   return null;
  // }

  @override
  void initState() {
    firebaseCloudMessagingListeners();

    // _firebaseMessaging.getToken().then((token) => setState(() {
    //       this.token = token;
    //     }));
    super.initState();
    // _initPackageInfo();
  }

  // _iosPermission() {
  //   _firebaseMessaging.requestNotificationPermissions(
  //       IosNotificationSettings(sound: true, badge: true, alert: true));

  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  // }

  firebaseCloudMessagingListeners() async {
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC4ek31wOO1hp9X6MmAzsQ29nwEZyOcVm0",
            appId: "1:18874484821:android:603be4c8041c598a0eecdc",
            messagingSenderId: "18874484821",
            projectId: "go-mekanik-skm"));

    _firebaseMessaging = FirebaseMessaging.instance;

    NotificationSettings _settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (_settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }

    // FirebaseMessaging.onMessage.listen((event) {
    //   showMessage(event.data);
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // showMessage(event.data);
      if (kDebugMode) {
        print("Message from fcm: ${message.data}");
      }
      showMessage(message.data);
    });

    // if (Platform.isIOS) _iosPermission();

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //     showMessage(message);
    //   },
    //   onBackgroundMessage: onBackgroundMessage,
    //   onResume: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //     showMessage(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //     showMessage(message);
    //   },
    // );
  }

  showMessage(Map<String, dynamic> msg) {
    // String line = '';
    String machineBrand = '';
    String machineType = '';
    String machineSN = '';
    String symptom = '';
    String barcode = '';

    if (Platform.isIOS) {
      // line = msg['Line'] ?? "-";
      machineBrand = msg['Merk Mesin'] ?? "-";
      machineType = msg['Tipe Mesin'] ?? "-";
      machineSN = msg['SN Mesin'] ?? "-";
      symptom = msg['Kerusakan'] ?? "-";
      barcode = msg['Barcode'] ?? "-";
    } else if (Platform.isAndroid) {
      // machineBrand = data['Machine Brand'];
      machineBrand = msg['Merk Mesin'];
      // machineType = data['Machine Type'];
      machineType = msg['Tipe Mesin'];
      // machineSN = data['Machine SN'];
      machineSN = msg['SN Mesin'];
      // symptom = data['Symptom'];
      symptom = msg['Kerusakan'];
      barcode = msg['Barcode'];
    }
    if (machineBrand.isNotEmpty &&
        machineType.isNotEmpty &&
        machineSN.isNotEmpty &&
        symptom.isNotEmpty &&
        barcode.isNotEmpty) {
      if (mounted) {
        setState(() {
          // dataLine = line;
          dataMachineBrand = machineBrand;
          dataMachineType = machineType;
          dataMachineSN = machineSN;
          dataSymptom = symptom;
          dataBarcode = barcode;
        });
      }
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            // title: msg['notification']['title'].toString(),
            title: "New Order Available",
            descriptions:
                'Merk: $dataMachineBrand. Tipe: $dataMachineType. SN: $dataMachineSN. Kerusakan: $dataSymptom. Barcode: $dataBarcode',
            text: 'OK',
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ResponsiveApp(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GoMekanik-GI2',
          theme: ThemeData(
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(bodyColor: const Color(0xFF535353)),
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: const SplashScreen(),
        );
      },
      // return MaterialApp(
      //     debugShowCheckedModeBanner: false,
      //     title: 'GoMekanik-GI2',
      //     theme: ThemeData(
      //       textTheme: Theme.of(context)
      //           .textTheme
      //           .apply(bodyColor: const Color(0xFF535353)),
      //       visualDensity: VisualDensity.adaptivePlatformDensity,
      //     ),
      //     home: const SplashScreen()),
    );
  }

  // Future<void> _initPackageInfo() async {
  //   final info = await PackageInfo.fromPlatform();
  //   setState(() {
  //     _packageInfo = info;
  //   });
  // }
}


// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       seconds: 5,
//       backgroundColor: Colors.blueGrey,
//       image: Image.asset('assets/images/gomekanik_logo.png'),
//       photoSize: 200.0,
//       navigateAfterSeconds: Welcome(),
//     );
//   }
// }
