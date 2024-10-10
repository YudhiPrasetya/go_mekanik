import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/screen/machines_breakdown/home_page.dart';
import 'package:go_mekanik/screen/transaksi/found_barcode_screen.dart';
import 'package:go_mekanik/util/ShowToast.dart';

class ListMachineBreakdownStatus extends StatefulWidget {
  final String? idMachineBreakdown;
  final String? machineBrand;
  final String? machineType;
  final String? type;
  final String? machineSN;
  final String? sympton;
  final String? line;
  final String? status;
  final String? startWaiting;
  final String? dateStartWaiting;
  final String? barcode_machine;
  final String? idUser;

  const ListMachineBreakdownStatus(
      {super.key,
      this.idMachineBreakdown,
      this.machineBrand,
      this.machineType,
      this.type,
      this.machineSN,
      this.sympton,
      this.line,
      this.status,
      this.startWaiting,
      this.dateStartWaiting,
      this.barcode_machine,
      this.idUser});

  @override
  State<ListMachineBreakdownStatus> createState() =>
      _ListMachineBreakdownStatusState();
}

class _ListMachineBreakdownStatusState
    extends State<ListMachineBreakdownStatus> {
  String? strStatus;
  // bool isDisabledButton = true;
  Color? statusColor;
  bool _screenOpened = false;
  bool _isLoading = false;

  @override
  void initState() {
    _createProperties();
    super.initState();
  }

  _createProperties() {
    switch (widget.status) {
      case "Waiting...":
        setState(() {
          strStatus = "Menunggu Mekanik";
          statusColor = Colors.red;
        });
        break;
      case "Repairing...":
        setState(() {
          strStatus = "Sedang Perbaikian";
          statusColor = Colors.orange;
        });
        break;
      case "SPV Review...":
        setState(() {
          strStatus = "Tunggu Review SPV";
          statusColor = Colors.blue;
        });
    }
  }

  Widget _createButton() {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom();
    String textButton = "-";

    if (widget.status == "Repairing...") {
      return const Center(
        child: Text(
          'Perbaikan',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange),
        ),
      );
    }

    if (widget.status == "Waiting...") {
      buttonStyle = ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );
      setState(() {
        textButton = "Cancel";
      });
    } else if (widget.status == "SPV Review...") {
      buttonStyle = ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );
      setState(() {
        textButton = "Review";
      });
    }

    return ElevatedButton(
        style: buttonStyle,
        onPressed: () async {
          await _cancelOrReview();
        },
        child: Text(
          textButton,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  _cancelOrReview() {
    setState(() {
      _isLoading = true;
    });
    if (widget.status == "Waiting...") {
      _cancelOrder(widget.idMachineBreakdown);
    } else if (widget.status == "SPV Review...") {
      _reviewOrder(widget.barcode_machine);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }

  _reviewOrder(String? bm) {
    if (!_screenOpened) {
      _screenOpened = true;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoundBarcodeScreen(
                    idUser: widget.idUser!,
                    screenClosed: _screenWasClosed,
                    value: bm,
                  )));
    }
  }

  _cancelOrder(String? idMB) async {
    var rst = await orderBloc.deleteMB(idMB);
    bool status = rst['status'];
    if (status == true) {
      var showToast = ShowToast();
      showToast.showToastSuccess('Order berhasil dibatalkan');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    idUser: widget.idUser,
                  )),
          (route) => false);
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      // shadowColor: Colors.black,
      // color: Colors.greenAccent[100],
      child: SizedBox(
        width: 50,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  // backgroundColor: Colors.green,
                  radius: 35,
                  child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/zz.jpg'),
                      radius: 100),
                ),
                const SizedBox(
                  height: 1.0,
                ),
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Varela',
                            color: Colors.lightBlue[800]),
                        text: '${widget.machineBrand}')),
                const SizedBox(
                  height: 1.0,
                ),
                Text(
                  '${widget.machineType} - ${widget.machineSN}',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 12.0,
                      color: Colors.lightBlue[800]),
                ),
                const SizedBox(
                  height: 1.0,
                ),
                Text(
                  '${widget.sympton}',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 10.0,
                      color: Colors.lightBlue[800],
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 1.0,
                ),
                Text(
                  strStatus!,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 11.0,
                      color: statusColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${widget.barcode_machine}',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 15.0,
                      color: statusColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Container(
                    height: 35,
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : _createButton())
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(
  //         top: 10.0, bottom: 3.0, left: 15.0, right: 15.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(15.0),
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Colors.grey.withOpacity(0.2),
  //                 spreadRadius: 3.0,
  //                 blurRadius: 5.0)
  //           ],
  //           color: Colors.white),
  //       child: Column(
  //         children: [
  //           Stack(
  //             children: [
  //               Hero(
  //                 tag: widget.idMachineBreakdown.toString(),
  //                 child: Container(
  //                   height: 65.0,
  //                   width: double.infinity,
  //                   decoration: const BoxDecoration(
  //                       image: DecorationImage(
  //                           image: AssetImage('assets/images/zz.jpg'),
  //                           fit: BoxFit.fill),
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(15.0),
  //                         topRight: Radius.circular(15.0),
  //                       )),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(
  //             height: 2.0,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 6.0, right: 6.0),
  //             child: RichText(
  //                 overflow: TextOverflow.ellipsis,
  //                 textAlign: TextAlign.center,
  //                 text: TextSpan(
  //                     style: TextStyle(
  //                         fontSize: 15,
  //                         fontFamily: 'Varela',
  //                         color: Colors.lightBlue[800]),
  //                     text: '${widget.machineBrand}')),
  //           ),
  //           const SizedBox(
  //             height: 2.0,
  //           ),
  //           Text(
  //             '${widget.machineType} - ${widget.machineSN}',
  //             style: TextStyle(
  //                 fontFamily: 'Varela',
  //                 fontSize: 12.0,
  //                 color: Colors.lightBlue[800]),
  //           ),
  //           const SizedBox(
  //             height: 1.0,
  //           ),
  //           Text(
  //             '${widget.sympton}',
  //             style: TextStyle(
  //                 fontFamily: 'Varela',
  //                 fontSize: 10.0,
  //                 color: Colors.lightBlue[800],
  //                 fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(
  //             height: 2.0,
  //           ),
  //           Text(
  //             strStatus!,
  //             style: TextStyle(
  //                 fontFamily: 'Varela',
  //                 fontSize: 11.0,
  //                 color: statusColor,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(
  //             height: 2.0,
  //           ),
  //           _createButton()
  //           // const SizedBox(
  //           //   height: 2.0,
  //           // ),
  //           // _buildButton()
  //           // const SizedBox(
  //           //   height: 2.0,
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildButton() {
  //   return ElevatedButton(
  //     child: isDisabledButton ? const Text('Review') : const Text('Batalkan'),
  //     style:
  //         ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15.0)),
  //     onPressed:
  //         isDisabledButton == false ? null : _cancelOrder(widget.idMachineBreakdown),
  //   );
  // }
}
