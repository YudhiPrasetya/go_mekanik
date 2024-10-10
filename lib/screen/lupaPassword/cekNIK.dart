import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_mekanik/bloc/authBloc.dart';
// import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/screen/lupaPassword/konfirmasiPassword.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:page_transition/page_transition.dart';

class CekNIK extends StatefulWidget {
  const CekNIK({super.key});

  @override
  _CekNIKState createState() => _CekNIKState();
}

class _CekNIKState extends State<CekNIK> {
  final TextEditingController nikController = TextEditingController();

  bool isCekNIK = false;

  bool isValidNIK = false;

  String isValidNIKText = 'NIK harus diisi!';

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
                      getNIK(state),
                      getButton(state),
                      getLogin(state)
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
            'Silahkan Masukan NIK Anda di bawah ini:',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
          )
        ],
      ),
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
                    // ignore: deprecated_member_use
                    // autovalidate: true,
                    autovalidateMode: AutovalidateMode.always,
                    // ignore: deprecated_member_use
                    // maxLengthEnforced: true,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
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

  Widget getLogin(state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Kembali',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[800],
                fontSize: 14.0),
          ),
        )
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
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30.0)),
                  // color: !isValidNIK
                  //     ? Colors.lightBlue[800].withOpacity(0.5)
                  //     : Colors.lightBlue[800],
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          !isValidNIK
                              ? Colors.lightBlue[800]!.withOpacity(0.5)
                              : Colors.lightBlue[800]!)),
                  onPressed: () {
                    if (isValidNIK) {
                      _getValidateNIK();
                    } else {
                      validateNIK(state);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isCekNIK
                            ? const SizedBox(
                                height: 16.0,
                                width: 16.0,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Expanded(
                                child: Text('LANJUTKAN',
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

  _getValidateNIK() async {
    final res = await authBloc.getValidateNIK2(nikController.text);

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      setState(() {
        isCekNIK = false;
      });
      // _register();
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 2500),
              child: const KonfirmasiPassword()),
          (route) => false);
    } else {
      setState(() {
        isCekNIK = false;
      });
      ShowToast().showToastError(message);
    }
  }
}
