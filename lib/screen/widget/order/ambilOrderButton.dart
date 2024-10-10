import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/screen/transaksi/transaksi.dart';
import 'package:go_mekanik/util/SessionManager.dart';

class AmbilOrderButton extends StatefulWidget {
  final String idMachineBreakdown;
  const AmbilOrderButton({
    Key? key,
    required this.idMachineBreakdown,
  }) : super(key: key);
  @override
  _AmbilOrderButtonState createState() => _AmbilOrderButtonState();
}

class _AmbilOrderButtonState extends State<AmbilOrderButton> {
  bool? isLogin;

  @override
  void initState() {
    _getLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50.0,
              // ignore: deprecated_member_use
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade800),
                ),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(18.0)),
                // color: Colors.green[800],
                child: Text(
                  'Ambil Order'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () {
                  if (isLogin == true) {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: Transaksi(
                                idMachineBreakdown: widget.idMachineBreakdown),
                            type: PageTransitionType.leftToRight,
                            duration: const Duration(milliseconds: 1000)));
                  } else {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const Login(),
                            type: PageTransitionType.leftToRight,
                            duration: const Duration(milliseconds: 1000)));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _getLogin() async {
    bool? _isLogin = await SessionManager().getIsLogin();

    setState(() {
      isLogin = _isLogin;
    });
  }
}

// class AmbilOrderButton extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: 20.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: 50.0,
//               child: FlatButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18.0)),
//                 color: Colors.lightBlue[800],
//                 child: Text(
//                   'Ambil Order'.toUpperCase(),
//                   style: TextStyle(
//                       fontSize: 17.0,
//                       fontFamily: 'Varela',
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Transaksi(),
//                       ));
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
