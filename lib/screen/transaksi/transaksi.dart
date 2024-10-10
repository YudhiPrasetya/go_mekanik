// import 'dart:html';

// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_mekanik/components/progres_transaksi.dart';
// import 'package:go_mekanik/screen/transaksi/approved.dart';
// import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:go_mekanik/bloc/mekanikRepairingBloc.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/screen/mainNavigation.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';

class Transaksi extends StatefulWidget {
  final String? idMachineBreakdown;

  const Transaksi({Key? key, this.idMachineBreakdown}) : super(key: key);

  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  bool canRepaired = false;
  final _isHours = true;
  String? _idMekanikRepairing;
  String? _idUser;
  late String _displayTimer;
  String? _idMachineBreakdown;

  bool isEnabledButton = true;

  bool _isCancelOrderLoading = false;
  bool _isSendLoading = false;
  bool _isVisible = false;
  // bool _isSelesai = false;
  // bool _isSendClickable = false;

  final TextEditingController catatanMekanikController =
      TextEditingController();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  // final _scrollController = ScrollController();

  // ignore: unused_elemen

  @override
  void initState() {
    // print('idMachineBreakdown: ${widget.idMachineBreakdown}');
    // _updateEndWaiting();
    // _idUser = await SessionManager().getIdUser();
    _getIdUserMekanik();
    // _idMachineBreakdown = widget.idMachineBreakdown;
    if (kDebugMode) {
      print('widget.idMachineBreakdown: ${widget.idMachineBreakdown}');
    }
    _getMachineBreakdownStatus(widget.idMachineBreakdown!);

    //_getMachineBreakdownData();

    super.initState();

    // _disabledButtons();
  }

  // @override
  // void dispose() {
  //   _stopWatchTimer.dispose();
  //   orderBloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Go Mekanik - On Machine Repairing..',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ]),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(2),
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: StreamBuilder<int>(
                        stream: _stopWatchTimer.rawTime,
                        initialData: _stopWatchTimer.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data;
                          _displayTimer = StopWatchTimer.getDisplayTime(value!,
                              hours: true, milliSecond: false);

                          return Text(
                            _displayTimer,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: _isCancelOrderLoading == true
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white),
                                  child: const Text(
                                    'Batalkan Order',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () => _canceled(),
                                ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green),
                            child: const Text(
                              'Selesai',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.stop);
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            })
                      ],
                    ),
                  ),
                  // const Divider(
                  //   height: 10,
                  //   thickness: 1,
                  //   color: Colors.red,
                  // ),
                  Visibility(
                    visible: _isVisible,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4, bottom: 4),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: "Catatan mekanik",
                            ),
                            controller: catatanMekanikController,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 2, right: 2),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    backgroundColor: Colors.orange),
                                child: const Text(
                                  'Lanjut Kerja',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                  catatanMekanikController.text = '';
                                  _stopWatchTimer.onExecute
                                      .add(StopWatchExecute.start);
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 2, right: 2),
                              child: _isSendLoading == true
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          backgroundColor: Colors.blueAccent),
                                      child: const Text('Send',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      onPressed: () => _sendReview(),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
          // body: TransaksiProgres(
          //   idMekanikRepairing: _idMekanikRepairing,
          //   idUser: _idUser,
          // )
          // body: SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         // Container(
          //         //   width: MediaQuery.of(context).size.width / 2,
          //         //   child: Card(
          //         //     elevation: 2.0,
          //         //     child: Text('Machine Detail'),
          //         //   ),
          //         // ),
          //         // SizedBox(
          //         //   height: 5.0,
          //         // ),
          //         Card(
          //           elevation: 2.0,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(4.0),
          //                 child: StreamBuilder<int>(
          //                   stream: _stopWatchTimer.rawTime,
          //                   initialData: _stopWatchTimer.rawTime.value,
          //                   builder: (context, snap) {
          //                     final value = snap.data;
          //                     _displayTimer = StopWatchTimer.getDisplayTime(
          //                         value!,
          //                         hours: _isHours,
          //                         milliSecond: false);

          //                     return Column(
          //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                       children: <Widget>[
          //                         Padding(
          //                           padding: const EdgeInsets.all(8),
          //                           child: Text(
          //                             _displayTimer,
          //                             style: const TextStyle(
          //                                 fontSize: 20,
          //                                 fontFamily: 'Helvetica',
          //                                 fontWeight: FontWeight.bold),
          //                           ),
          //                         ),
          //                         const Divider(),
          //                         // Padding(
          //                         //   padding: const EdgeInsets.only(bottom: 2.0),
          //                         //   child: Divider(),
          //                         // ),
          //                         Padding(
          //                           padding: const EdgeInsets.all(1.0),
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceEvenly,
          //                             children: [
          //                               Container(
          //                                 decoration: const ShapeDecoration(
          //                                     shape: RoundedRectangleBorder(
          //                                         borderRadius: BorderRadius.all(
          //                                             Radius.circular(8)))),
          //                                 child: _isCancelOrderLoading
          //                                     ? const Center(
          //                                         child:
          //                                             CircularProgressIndicator(
          //                                           color: Colors.red,
          //                                         ),
          //                                       )
          //                                     : ElevatedButton(
          //                                         style: ElevatedButton.styleFrom(
          //                                           shape: RoundedRectangleBorder(
          //                                               borderRadius:
          //                                                   BorderRadius.circular(
          //                                                       8)),
          //                                           disabledBackgroundColor:
          //                                               Colors.grey,
          //                                           backgroundColor: Colors.red,
          //                                         ),
          //                                         onPressed: () {
          //                                           _canceled();
          //                                         },
          //                                         child: const Text(
          //                                             'Batalkan Order',
          //                                             style: TextStyle(
          //                                                 fontWeight:
          //                                                     FontWeight.bold,
          //                                                 fontSize: 15.0,
          //                                                 color: Colors.white)),
          //                                       ),
          //                               ),

          //                               // ignore: deprecated_member_use
          //                               ElevatedButton(
          //                                 style: ElevatedButton.styleFrom(
          //                                   shape: RoundedRectangleBorder(
          //                                       borderRadius:
          //                                           BorderRadius.circular(8)),
          //                                   disabledBackgroundColor: Colors.grey,
          //                                   backgroundColor: Colors.blueAccent,
          //                                 ),
          //                                 onPressed: () {
          //                                   // _approved();
          //                                   _stopWatchTimer.onExecute
          //                                       .add(StopWatchExecute.stop);
          //                                   _review(context);
          //                                 },
          //                                 child: const Row(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.center,
          //                                   children: [
          //                                     // Icon(Icons.thumb_up_alt),
          //                                     Text('Selesai',
          //                                         style: TextStyle(
          //                                             fontWeight: FontWeight.bold,
          //                                             fontSize: 15.0,
          //                                             color: Colors.white))
          //                                   ],
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         // const Divider(),
          //                       ],
          //                     );
          //                   },
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          ),
    );
  }

  _beginRepair(String status) async {
    // String idMachineBreakdown = widget.idMachineBreakdown;

    final res = await mekanikRepairingBloc.simpanMekanikRepairing(
        _idUser!, widget.idMachineBreakdown!);

    bool status = res['status'];
    _idMekanikRepairing = res['data']['id'].toString();
    if (status) {
      ShowToast().showToastSuccess("Selamat bekerja...");
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    }
  }

  _getMachineBreakdownStatus(String idMB) async {
    // final machineBreakdown =
    //     await orderBloc.getMachineBreakdownStatus(_idMachineBreakdown!);
    final machineBreakdown = await orderBloc.getMachineBreakdownStatus(idMB);

    // machineBreakdown =
    //     await orderBloc.getMachineBreakdownData(widget.idMachineBreakdown!);

    String status = machineBreakdown['data'];
    if (status != "Waiting...") {
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
      ShowToast().showToastWarning(
          'Mesin sedang diperbaiki atau sudah selesai diperbaiki oleh mekanik lain ');
    } else {
      setState(() {
        canRepaired = true;
      });
      _beginRepair(status);
    }
  }

  // _approved() {
  //   Navigator.push(
  //       context,
  //       PageTransition(
  //           child: Approved(
  //             idMachineBreakdown: widget.idMachineBreakdown,
  //             idUser: _idUser,
  //             idMekanikRepairing: _idMekanikRepairing,
  //           ),
  //           type: PageTransitionType.fade,
  //           duration: const Duration(milliseconds: 800)));
  // }

  // _review(BuildContext context) async {
  //   //bool _isSendLoading = false;

  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) => Dialog(
  //             elevation: 0,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             child: SizedBox(
  //               height: 150,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   TextField(
  //                     controller: catatanMekanikController,
  //                     decoration:
  //                         const InputDecoration(hintText: "Catatan mekanik"),
  //                     textAlign: TextAlign.center,
  //                     textAlignVertical: TextAlignVertical.center,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           _stopWatchTimer.onExecute
  //                               .add(StopWatchExecute.start);
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: const Text(
  //                           "Kembali",
  //                           style: TextStyle(fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       ElevatedButton(
  //                         onPressed: () => _sendReview,
  //                         // onPressed: _isSendClickable
  //                         //     ? null
  //                         //     : () async => await _onPressed(),
  //                         // onPressed: null,
  //                         // onPressed: _isSendClickable
  //                         //     ? () async {
  //                         //         setState(() {
  //                         //           _isSendClickable = false;
  //                         //         });
  //                         //         final rst = await orderBloc.sendNotifToSPV(
  //                         //             widget.idMachineBreakdown,
  //                         //             catatanMekanikController.text);
  //                         //         if (rst['status'] == true) {
  //                         //           // ShowToast().showToastSuccess(
  //                         //           //     "Berhasil mengirim notifikasi ke SPV bersangkutan");
  //                         //           Navigator.pushAndRemoveUntil(
  //                         //               context,
  //                         //               PageTransition(
  //                         //                   child: const MainNavigation(),
  //                         //                   type: PageTransitionType.fade,
  //                         //                   duration: const Duration(
  //                         //                       milliseconds: 500)),
  //                         //               (route) => false);
  //                         //         }
  //                         //       }
  //                         //     : null,
  //                         child: const Text("Send",
  //                             style: TextStyle(fontWeight: FontWeight.bold)),
  //                         style: ElevatedButton.styleFrom(
  //                           shape: const RoundedRectangleBorder(
  //                               borderRadius:
  //                                   BorderRadius.all(Radius.circular(8.0))),
  //                           backgroundColor: Colors.green[600],
  //                           foregroundColor: Colors.white,
  //                         ),
  //                       )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ));
  // }

  // _review() {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return const Dialog(
  //           child: Center(
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [CircularProgressIndicator(), Text('Loading...')],
  //             ),
  //           ),
  //         );
  //       });
  //   Future.delayed(const Duration(milliseconds: 1500), () {
  //     Navigator.pop(context);
  //     _sendReview();
  //   });
  // }

  _sendReview() async {
    // _showProgressDialog(context);
    setState(() {
      _isSendLoading = true;
    });
    final rst = await orderBloc.sendNotifToSPV(
        widget.idMachineBreakdown, catatanMekanikController.text);
    if (rst['status'] == true) {
      setState(() {
        _isSendLoading = false;
      });
      // ShowToast toast = ShowToast();
      // toast
      //     .showToastSuccess('Berhasil mengirim notifikasi ke SPV bersangkutan');
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const MainNavigation(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 500)),
          (route) => false);
    }
  }

  _showProgressDialog(BuildContext context) {
    AlertDialog progress = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: const Text("Loading..."),
          )
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return progress;
        });
  }

  // Future _onPressed() async {
  //   setState(() {
  //     _isSendClickable = true;
  //   });

  //   final rst = await orderBloc.sendNotifToSPV(
  //       widget.idMachineBreakdown, catatanMekanikController.text);
  //   if (rst['status'] == true) {
  //     // ShowToast().showToastSuccess(
  //     //     "Berhasil mengirim notifikasi ke SPV bersangkutan");

  //     // await widget.onPressed!();
  //     setState(() {
  //       _isSendClickable = false;
  //     });

  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         PageTransition(
  //             child: const MainNavigation(),
  //             type: PageTransitionType.fade,
  //             duration: const Duration(milliseconds: 500)),
  //         (route) => false);
  //   }
  // }

  _canceled() async {
    // _idUser = await SessionManager().getIdUser();
    setState(() {
      _isCancelOrderLoading = true;
    });
    final res = await mekanikRepairingBloc.cancelMekanikRepairing(
        _idMekanikRepairing!, _idUser!);

    if (res['success'] > 0) {
      setState(() {
        _isCancelOrderLoading = false;
      });
      ShowToast().showToastSuccess("Order dibatalkan oleh mekanik...");
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const MainNavigation(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 1000)),
          (route) => false);
    }
  }

  _getIdUserMekanik() async {
    _idUser = await SessionManager().getIdUser();
  }
}
