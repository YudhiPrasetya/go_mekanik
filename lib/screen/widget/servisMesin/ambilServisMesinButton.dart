import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/mekanikMemberBloc.dart';
import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/screen/transaksi/transaksiServisMesin.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:page_transition/page_transition.dart';

class AmbilServisMesinButton extends StatefulWidget {
  final String idServisMesin;

  const AmbilServisMesinButton({Key? key, required this.idServisMesin})
      : super(key: key);

  @override
  _AmbilServisMesinButtonState createState() => _AmbilServisMesinButtonState();
}

class _AmbilServisMesinButtonState extends State<AmbilServisMesinButton> {
  bool? isLogin;

  @override
  void initState() {
    _getLogin();
    super.initState();
  }

  _getLogin() async {
    bool? _isLogin = await SessionManager().getIsLogin();

    setState(() {
      isLogin = _isLogin;
    });
    // if (_isLogin) {
    // String _idUserMekanik = await SessionManager().getIdUserMekanik();
    // final res = await mekanikMemberBloc.getMekanikMember(_idUserMekanik);
    // }
  }

  Future<int> _getIsMaintenance() async {
    String idUserMekanik = await SessionManager().getIdUser();
    final res = await mekanikMemberBloc.getMekanikMember(idUserMekanik);
    return int.parse(res['isMaintenance']);
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
                    final _isMaintenance = await _getIsMaintenance();
                    if (_isMaintenance == 1) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              child: TransaksiServisMesin(
                                  idServisMesin: widget.idServisMesin),
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
}
