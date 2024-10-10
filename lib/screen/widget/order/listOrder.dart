import 'package:flutter/material.dart';
import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/screen/transaksi/transaksi.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:page_transition/page_transition.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';

class ListOrder extends StatefulWidget {
  final String? idMachineBreakdown;
  final String? machineBrand;
  final String? machineType;
  final String? type;
  final String? machineSN;
  final String? sympton;
  final String? line;
  final String? floor;
  final String? startWaiting;
  final String? dateStartWaiting;
  final String? spv;
  final String? barcode;

  const ListOrder(
      {super.key,
      this.idMachineBreakdown,
      this.machineBrand,
      this.machineType,
      this.type,
      this.machineSN,
      this.sympton,
      this.line,
      this.floor,
      this.startWaiting,
      this.dateStartWaiting,
      this.spv,
      this.barcode});

  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  bool? isLogin;
  dynamic _displayTimer;
  final _isHours = true;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
  );

  @override
  void initState() {
    cekLogin();
    // _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    super.initState();
  }

  // @override
  // void dispose() async {
  //   super.dispose();
  //   await _stopWatchTimer.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // print(diffTime);
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 5.0, left: 15.0, right: 15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ],
            color: Colors.white),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.idMachineBreakdown.toString(),
                  child: Container(
                    height: 65.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            // // image: NetworkImage('http://192.168.15.128/GO-MEKANIK-API/public/uploads/img/' + widget.gambar),
                            // image: AssetImage(widget.machineType == null
                            //     ? 'assets/images/noimage.jpg'
                            //     : 'assets/images/' +
                            //         '${widget.machineType}'.toLowerCase() +
                            //         '.jpg'),
                            image: AssetImage('assets/images/zz.jpg'),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0),
              child: RichText(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Varela',
                          color: Colors.lightBlue[800]),
                      text: '${widget.machineBrand}')),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              '${widget.machineType} - ${widget.machineSN}',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 10.0,
                  color: Colors.lightBlue[800]),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              '${widget.spv} - ${widget.barcode}',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 10.0,
                  color: Colors.lightBlue[800]),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                color: const Color(0xFFEBEBEB),
                height: 1.0,
              ),
            ),
            // SizedBox(height: 4.0),
            StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data;
                  // print('value: $value');
                  // final dateNow = DateTime.now();
                  // final diffTime =
                  //     dateNow.difference(widget.startWaiting).inSeconds;
                  final dateTimeNow = DateTime.now();
                  final duration = dateTimeNow
                      .difference(
                          DateTime.parse(widget.dateStartWaiting.toString()))
                      .inMilliseconds;
                  final diffTime = value! + duration;
                  // print('diffTime: $diffTime');
                  _displayTimer = StopWatchTimer.getDisplayTime(diffTime,
                      hours: _isHours,
                      minute: true,
                      second: true,
                      milliSecond: false);
                  // _stopWatchTimer.setPresetTime(mSec: duration);
                  _stopWatchTimer.setPresetSecondTime(value);

                  // _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                  // print(_displayTimer);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_displayTimer,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontFamily: 'Helvitica',
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              // ignore: deprecated_member_use
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade800),
                ),
                onPressed: () async {
                  if (isLogin == true) {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: Transaksi(
                                idMachineBreakdown: widget.idMachineBreakdown),
                            type: PageTransitionType.leftToRight,
                            duration: const Duration(milliseconds: 500)));
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: const Login(),
                            type: PageTransitionType.leftToRight,
                            duration: const Duration(milliseconds: 500)),
                        (route) => false);
                  }
                },
                child: const Text(
                  'Ambil Order',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Varela',
                      fontSize: 12.0),
                ),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                // color: Colors.green[800],
              ),
            ),
          ],
        ),
      ),
    );

    // final sizeWidth = MediaQuery.of(context).size.width;
    // return Container(
    //   width: sizeWidth / 2,
    //   margin: const EdgeInsets.all(10),
    //   padding: const EdgeInsets.all(25),
    //   decoration: BoxDecoration(
    //     // color: Theme.of(context).colorScheme.primary,
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       AspectRatio(
    //         aspectRatio: 1,
    //         child: Container(
    //           decoration: BoxDecoration(
    //               // color: Theme.of(context).colorScheme.secondary,
    //               borderRadius: BorderRadius.circular(12)),
    //           padding: const EdgeInsets.all(25),
    //           width: double.infinity,
    //           child: Image.asset('assets/images/zz.jpg'),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 25,
    //       ),
    //       Text(
    //         '${widget.machineBrand}',
    //         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //       )
    //     ],
    //   ),
    // );
  }

  cekLogin() async {
    bool? _isLogin = await SessionManager().getIsLogin();
    setState(() {
      isLogin = _isLogin;
    });
  }
}
