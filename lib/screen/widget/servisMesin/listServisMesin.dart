import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/mekanikMemberBloc.dart';
import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/screen/transaksi/transaksiServisMesin.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';

class ListServisMesin extends StatefulWidget {
  final String? idServisMesin;
  final String? tgl;
  final String? idMesin;
  final String? jenis;
  final String? merk;
  final String? tipe;
  final String? noSeri;
  final String? lokasi;
  final String? line;
  final String? status;
  final String? startWaiting;

  const ListServisMesin(
      {Key? key,
      this.idServisMesin,
      this.tgl,
      this.idMesin,
      this.jenis,
      this.merk,
      this.tipe,
      this.noSeri,
      this.lokasi,
      this.line,
      this.status,
      this.startWaiting})
      : super(key: key);

  @override
  _ListServisMesinState createState() => _ListServisMesinState();
}

class _ListServisMesinState extends State<ListServisMesin> {
  bool? isLogin;
  final _isHours = true;
  var _displayTimer;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(isLapHours: true);
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  void initState() {
    cekLogin();
    _beginTimer();
    super.initState();
  }

  void _beginTimer() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  Future<int> _getIsMaintenance() async {
    String idUserMekanik = await SessionManager().getIdUser();
    final res = await mekanikMemberBloc.getMekanikMember(idUserMekanik);
    return int.parse(res['isMaintenance']);
  }

  @override
  Widget build(BuildContext context) {
    final DateTime dateFromTable = dateFormat.parse(widget.startWaiting!);

    final dateNow = DateTime.now();
    final hoursDateDiff = dateNow.difference(dateFromTable).inHours;
    final minutesDateDiff = dateNow.difference(dateFromTable).inMinutes;
    final secondsDateDiff = dateNow.difference(dateFromTable).inSeconds;

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
                  tag: widget.idServisMesin!,
                  child: Container(
                    height: 75.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            // image: NetworkImage('http://192.168.15.128/GO-MEKANIK-API/public/uploads/img/' + widget.gambar),
                            image: AssetImage(widget.jenis == null
                                ? 'assets/images/noimage.jpg'
                                : 'assets/images/' +
                                    '${widget.jenis}'.toLowerCase() +
                                    '.jpg'),
                            fit: BoxFit.fill),
                        borderRadius: const BorderRadius.only(
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
                      text: '${widget.merk}')),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              '${widget.tipe} - ${widget.noSeri}',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 10.0,
                  color: Colors.lightBlue[800]),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              '${widget.line} - ${widget.lokasi}',
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
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data;
                  _stopWatchTimer.setPresetHoursTime(hoursDateDiff);
                  _stopWatchTimer.setPresetMinuteTime(minutesDateDiff);
                  _stopWatchTimer.setPresetSecondTime(secondsDateDiff);
                  // print('value" $value');
                  _displayTimer = StopWatchTimer.getDisplayTime(value!,
                      hours: _isHours, milliSecond: false);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          _displayTimer,
                          style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Helvetica',
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              // ignore: deprecated_member_use
              child: TextButton(
                onPressed: () async {
                  if (isLogin == true) {
                    final _isMaintenance = await _getIsMaintenance();
                    if (_isMaintenance == 1) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              child: TransaksiServisMesin(
                                  idServisMesin: widget.idServisMesin!),
                              type: PageTransitionType.leftToRight,
                              duration: const Duration(milliseconds: 800)),
                          (route) => false);
                    } else {
                      ShowToast().showToastWarning(
                          'Maaf, Anda tidak berhak mengambil order ini.');
                    }
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: const Login(),
                            type: PageTransitionType.leftToRight,
                            duration: const Duration(milliseconds: 1000)),
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
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cekLogin() async {
    bool? _isLogin = await SessionManager().getIsLogin();
    setState(() {
      isLogin = _isLogin;
    });
  }
}
