import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_mekanik/bloc/authBloc.dart';
import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:page_transition/page_transition.dart';

class KonfirmasiPassword extends StatefulWidget {
  final String? id;

  const KonfirmasiPassword({
    super.key,
    this.id,
  });

  @override
  _KonfirmasiPasswordState createState() => _KonfirmasiPasswordState();
}

class _KonfirmasiPasswordState extends State<KonfirmasiPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _konfirmasiController = TextEditingController();

  bool isCek = false;

  bool isValidPassword = false;
  bool isValidKonfirmasi = false;

  String isValidPasswordText = 'Password harus diisi!';
  String isValidKonfirmasiText = 'Masukkan lagi password Anda!';

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
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
                      getPassword(state),
                      getKonfirmasi(state),
                      getButton(state),
                      getCekNIK()
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
            'LUPA PASSWORD',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          Text(
            'Silahkan isi password baru Anda.',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
          )
        ],
      ),
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
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
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
                    // ignore: deprecated_member_use
                    // autovalidate: true,
                    autovalidateMode: AutovalidateMode.always,
                    // ignore: deprecated_member_use
                    // maxLengthEnforced: true,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
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

  Widget getKonfirmasi(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'KONFIRMASI PASSWORD',
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
                    keyboardType: TextInputType.visiblePassword,
                    controller: _konfirmasiController,
                    obscureText: true,
                    autofocus: false,
                    onChanged: (text) {
                      validateKonfirmasi(state);
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: '*******',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    autocorrect: false,
                    // ignore: deprecated_member_use
                    // autovalidate: true,
                    autovalidateMode: AutovalidateMode.always,
                    // ignore: deprecated_member_use
                    // maxLengthEnforced: true,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    validator: (value) {
                      return !isValidKonfirmasi ? isValidKonfirmasiText : null;
                    },
                  ),
                )
              ]),
        ),
        const SizedBox(height: 24.0)
      ],
    );
  }

  Widget getButton(state) {
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
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          !isValidPassword
                              ? Colors.lightBlue[800]!.withOpacity(0.5)
                              : Colors.lightBlue[800]!)),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30.0)),
                  // color: !isValidPassword
                  //     ? Colors.lightBlue[800].withOpacity(0.5)
                  //     : Colors.lightBlue[800],
                  onPressed: () {
                    if (isValidPassword) {
                      _simpanPassword();
                    } else {
                      validatePassword(state);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isCek
                            ? const SizedBox(
                                height: 16.0,
                                width: 16.0,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Expanded(
                                child: Text('SIMPAN',
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

  Widget getCekNIK() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text('Kembali',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue[800],
                  fontSize: 14.0)),
        )
      ],
    );
  }

  validatePassword(StateSetter updateState) async {
    if (_passwordController.text.length >= 6) {
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

  validateKonfirmasi(StateSetter updateState) async {
    if (_konfirmasiController.text == _passwordController.text) {
      updateState(() {
        isValidKonfirmasi = true;
      });
    } else {
      updateState(() {
        isValidKonfirmasi = false;
        isValidKonfirmasiText = "Password dan Konfirmasi Password tidak sama!!";
      });
    }
  }

  _simpanPassword() async {
    final res = await authBloc.simpanPassword(
        widget.id.toString(), _passwordController.text);

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      ShowToast().showToast(message);
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const Login(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 2500),
          ),
          (route) => false);
    } else {
      ShowToast().showToastError(message);
    }
  }
}
