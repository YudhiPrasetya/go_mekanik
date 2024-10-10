import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
import 'package:go_mekanik/bloc/mekanikRepairingBloc.dart';
// import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TransaksiProgres extends StatefulWidget {
  final String? idMekanikRepairing;
  final String? idUser;
  const TransaksiProgres({super.key, this.idMekanikRepairing, this.idUser});

  @override
  State<TransaksiProgres> createState() => _TransaksiProgresState();
}

class _TransaksiProgresState extends State<TransaksiProgres> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(isLapHours: true);
  String? _displayTimer;
  ShowToast toast = ShowToast();
  final TextEditingController catatanMekanikController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0)
          ],
        ),
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
                    _displayTimer!,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: const Text(
                      'Batalkan Order',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _canceled,
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
                    onPressed: _sendReview,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 10,
              thickness: 1,
              color: Colors.redAccent,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: const Text('Lanjut Kerja'),
                        onPressed: null,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 2, right: 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.blueAccent),
                        child: const Text('Send'),
                        onPressed: null,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _canceled() async {
    _showProgressDialog(context);
    final res = await mekanikRepairingBloc.cancelMekanikRepairing(
        widget.idMekanikRepairing!, widget.idUser!);
    if (res['success'] > 0) {
      toast.showToastWarning("Order dibatalkan oleh mekanik...");
      Navigator.pop(context);
    }
  }

  _sendReview() async {}

  _showProgressDialog(BuildContext context) {
    AlertDialog progress = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: const Text('Loading...'),
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
}
