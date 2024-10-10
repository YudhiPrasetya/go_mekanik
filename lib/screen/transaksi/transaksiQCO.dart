// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/qcoBloc.dart';
import 'package:go_mekanik/screen/transaksi/approvedQCO.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:go_mekanik/screen/mainNavigation.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';
// import 'package:screen/screen.dart';

class TransaksiQCO extends StatefulWidget {
  final String? idQCODetail;

  const TransaksiQCO({
    Key? key,
    this.idQCODetail,
  }) : super(key: key);

  @override
  _TransaksiQCOState createState() => _TransaksiQCOState();
}

class _TransaksiQCOState extends State<TransaksiQCO> {
  bool canRepaired = false;
  final _isHours = true;
  // ignore: unused_field
  var _idQCODetail;
  var _idUser;
  var _displayTimer;

  bool isEnabledButton = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  // ignore: unused_field
  final _scrollController = ScrollController();

  // ignore: unused_element
  _disabledButton() {
    setState(() {
      isEnabledButton = false;
    });
  }

  // ignore: unused_element
  _enabledButton() {
    setState(() {
      isEnabledButton = true;
    });
  }

  @override
  void initState() {
    // print('idMachineBreakdown: ${widget.idMachineBreakdown}');
    // _updateEndWaiting();

    _getIdUserMekanik();
    _checkQCOStatus();

    super.initState();

    // _disabledButtons();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Screen.keepOn(true);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Go Mekanik - On Setting Machine..',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   width: MediaQuery.of(context).size.width / 2,
              //   child: Card(
              //     elevation: 2.0,
              //     child: Text('Machine Detail'),
              //   ),
              // ),
              // SizedBox(
              //   height: 5.0,
              // ),
              Card(
                elevation: 3.0,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: StreamBuilder<int>(
                        stream: _stopWatchTimer.rawTime,
                        initialData: _stopWatchTimer.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data;

                          _displayTimer = StopWatchTimer.getDisplayTime(value!,
                              hours: _isHours, milliSecond: false);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  _displayTimer,
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 2.0),
                              //   child: Divider(),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // ignore: deprecated_member_use
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              disabledBackgroundColor:
                                                  Colors.grey,
                                              backgroundColor: Colors.blue,
                                            ),
                                            // textColor: Colors.white,
                                            // color: Colors.blue,
                                            // disabledColor: Colors.grey,
                                            // shape: StadiumBorder(),
                                            onPressed: () async {
                                              _stopWatchTimer.onExecute
                                                  .add(StopWatchExecute.start);
                                            },
                                            child: const Text('Start',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        // ignore: deprecated_member_use
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              disabledBackgroundColor:
                                                  Colors.grey,
                                              backgroundColor: Colors.purple,
                                            ),
                                            // textColor: Colors.white,
                                            // color: Colors.purple,
                                            // disabledColor: Colors.grey,
                                            // shape: StadiumBorder(),
                                            onPressed: () async {
                                              _stopWatchTimer.onExecute
                                                  .add(StopWatchExecute.stop);
                                            },
                                            child: const Text('Stop',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // RaisedButton(
                                        //     textColor: Colors.white,
                                        //     color: Colors.red,
                                        //     disabledColor: Colors.grey,
                                        //     shape: StadiumBorder(),
                                        //     onPressed: () {
                                        //       _canceled();
                                        //     },
                                        //     child: Text('Cancel',
                                        //         style: TextStyle(
                                        //             fontSize: 12.0,
                                        //             fontWeight:
                                        //                 FontWeight.bold))),
                                        // ignore: deprecated_member_use
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              disabledBackgroundColor:
                                                  Colors.grey,
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                            // textColor: Colors.white,
                                            // color: Colors.blueAccent,
                                            // disabledColor: Colors.grey,
                                            // shape: StadiumBorder(),
                                            onPressed: () {
                                              _approved();
                                            },
                                            child: const Text('Approve',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _beginSetting() async {
    _idUser = await SessionManager().getIdUser();
    String _idQCODetail = widget.idQCODetail!;

    final res = await qcoBloc.updateQCODetail(_idUser, _idQCODetail);
    if (kDebugMode) {
      print('resQCOUpdate: $res');
    }

    bool status = res['status'];
    _idQCODetail = res['data']['id'].toString();
    if (status) {
      ShowToast().showToastSuccess("Selamat bekerja...");
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    }
  }

  _checkQCOStatus() async {
    final res = await qcoBloc.getQCOStatus(widget.idQCODetail!);

    String status = res['data'];
    if (kDebugMode) {
      print('status: $status');
    }
    if (status != "QCO...") {
      setState(() {
        canRepaired = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom,
              duration: const Duration(milliseconds: 1000),
              child: const MainNavigation()),
          (route) => false);
      ShowToast().showToastWarning('Mesin sedang di seting oleh mekanik lain.');
    } else {
      setState(() {
        canRepaired = true;
      });
      _beginSetting();
    }
  }

  _approved() {
    Navigator.push(
        context,
        PageTransition(
            child: ApprovedQCO(
              idQCODetail: widget.idQCODetail,
            ),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 800)));
  }

  // _canceled() async {
  //   _idUser = await SessionManager().getIdUserMekanik();
  //   final res = await mekanikRepairingBloc.cancelMekanikRepairing(
  //       _idMekanikRepairing, _idUser);

  //   if (res['success'] > 0) {
  //     ShowToast().showToastSuccess("Order dibatalkan oleh mekanik...");
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         PageTransition(
  //             child: MainNavigation(),
  //             type: PageTransitionType.fade,
  //             duration: Duration(milliseconds: 1000)),
  //         (route) => false);
  //   }
  // }

  _getIdUserMekanik() async {}
}
