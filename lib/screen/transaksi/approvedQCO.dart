import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/qcoBloc.dart';
import 'package:go_mekanik/bloc/spvBloc.dart';
import 'package:go_mekanik/screen/mainNavigation.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:page_transition/page_transition.dart';

class ApprovedQCO extends StatefulWidget {
  final String? idQCODetail;

  const ApprovedQCO({
    Key? key,
    this.idQCODetail,
  }) : super(key: key);

  @override
  _ApprovedQCOState createState() => _ApprovedQCOState();
}

class _ApprovedQCOState extends State<ApprovedQCO> {
  final TextEditingController _nikController = TextEditingController();

  bool isCek = false;

  bool isNIKValid = false;
  String isNIKValidText = "NIK harus diisi!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    getBack(),
                  ],
                ),
              );
            },
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
            'APPROVED Setting Machine For QCO',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          Text(
            'Silahkan isi NIK Anda.',
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
                  'NIK',
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
                    onChanged: (text) {
                      validateNIK(state);
                    },
                    controller: _nikController,
                    obscureText: true,
                    autofocus: false,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintText: 'NIK Supervisor',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    autocorrect: false,
                    // ignore: deprecated_member_use
                    // autovalidate: true,
                    autovalidateMode: AutovalidateMode.always,
                    // maxLengthEnforced: true,
                    validator: (value) {
                      return !isNIKValid ? isNIKValidText : null;
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
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30.0)),
                  // color: !isNIKValid
                  //     ? Colors.lightBlue[800].withOpacity(0.5)
                  //     : Colors.lightBlue[800],
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    !isNIKValid
                        ? Colors.lightBlue[800]!.withOpacity(0.5)
                        : Colors.lightBlue[800]!,
                  )),
                  onPressed: () {
                    if (isNIKValid) {
                      // _simpanApprove();
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
                        isCek
                            ? Container(
                                height: 16.0,
                                width: 16.0,
                                child: const CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Expanded(
                                child: Text('APPROVE',
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

  Widget getBack() {
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

  _simpanApprove() async {
    final res = await qcoBloc.finishQCODetail(widget.idQCODetail!);

    bool status = res['status'];
    // String message = res['message'];

    if (status) {
      ShowToast().showToast('Simpan data berhasil...terima kasih.');
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const MainNavigation(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 2500),
          ),
          (route) => false);
    } else {
      ShowToast().showToastError('Error...!!');
    }
  }

  _getValidateNIK() async {
    final res = await spvBloc.cekNIK(_nikController.text);

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      _simpanApprove();
    } else {
      ShowToast().showToastWarning(message);
    }
  }

  void validateNIK(StateSetter updateState) {
    if (_nikController.text.isNotEmpty) {
      updateState(() {
        isNIKValid = true;
      });
    } else {
      updateState(() {
        isNIKValid = true;
      });
    }
  }
}
