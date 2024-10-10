import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/mekanikMemberBloc.dart';
import 'package:go_mekanik/screen/transaksi/transaksiQCO.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:page_transition/page_transition.dart';

import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/util/SessionManager.dart';

class AmbilQCOButton extends StatefulWidget {
  final String idQCODetail;
  const AmbilQCOButton({
    Key? key,
    required this.idQCODetail,
  }) : super(key: key);
  @override
  _AmbilQCOButtonState createState() => _AmbilQCOButtonState();
}

class _AmbilQCOButtonState extends State<AmbilQCOButton> {
  bool? isLogin;

  @override
  void initState() {
    _getLogin();
    super.initState();
  }

  Future<int> _getIsQCO() async {
    String idUserMekanik = await SessionManager().getIdUser();
    final res = await mekanikMemberBloc.getMekanikMember(idUserMekanik);
    return int.parse(res['isQuickChange']);
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green.shade800)),
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
                onPressed: () async {
                  if (isLogin == true) {
                    final _isQCO = await _getIsQCO();
                    if (_isQCO == 1) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              child:
                                  TransaksiQCO(idQCODetail: widget.idQCODetail),
                              type: PageTransitionType.leftToRight,
                              duration: const Duration(milliseconds: 800)),
                          (route) => false);
                    } else {
                      ShowToast().showToastWarning(
                          'Maaf, Anda tidak berhak mengambil order ini.');
                    }
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
