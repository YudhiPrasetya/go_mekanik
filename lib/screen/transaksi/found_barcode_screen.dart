// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:go_mekanik/bloc/machineSettledBloc.dart';
import 'package:go_mekanik/bloc/masalahMesinBloc.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/components/review_spv.dart';
import 'package:go_mekanik/components/send_order.dart';
// import 'package:go_mekanik/model/masalahMesinModel.dart';
// import 'package:go_mekanik/screen/machines_breakdown/home_page.dart';
// import 'package:go_mekanik/util/SessionManager.dart';
// import 'package:go_mekanik/util/ShowToast.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:page_transition/page_transition.dart';

class FoundBarcodeScreen extends StatefulWidget {
  final String idUser;
  // final Barcode value;
  final String? value;
  final Function() screenClosed;
  const FoundBarcodeScreen(
      {super.key,
      required this.idUser,
      required this.value,
      required this.screenClosed});

  @override
  State<FoundBarcodeScreen> createState() => _FoundBarcodeScreenState();
}

class _FoundBarcodeScreenState extends State<FoundBarcodeScreen> {
  // final List<MasalahMesinModel> _listMasalahMesin = [];
  // late List<MultiSelectItem<MasalahMesinModel?>> _masalahMesinItems;
  // List<MasalahMesinModel?> _selectedMslhMesin = [];
  bool? waitingStatus;
  final TextEditingController catatanSPVController = TextEditingController();
  double? rating = 0;
  String? machineBarcode;
  // bool _isLoading = false;
  // int _countSelectedMslhMesin = 0;

  @override
  void initState() {
    super.initState();
    machineBarcode = widget.value;
    _getMachineStatus();
  }

  _getMachineStatus() async {
    final machineData =
        await orderBloc.getByBarcodeAndRepairing(machineBarcode);
    if (machineData['status'] == false ||
        machineData['data']['status'] == "Waiting...") {
      setState(() {
        waitingStatus = true;
      });
    } else {
      setState(() {
        waitingStatus = false;
      });
    }
  }

  @override
  void dispose() {
    masalahMesinBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barcode Found',
          style: TextStyle(fontSize: 15.0),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scanned Code:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Text(
                widget.value ?? "-",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              waitingStatus == true
                  ? SendOrder(idUser: widget.idUser, barcode: widget.value)
                  : ReviewSPV(
                      machineBarcode: widget.value,
                      idUser: widget.idUser,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
