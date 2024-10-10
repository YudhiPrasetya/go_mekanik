import 'package:flutter/material.dart';
// import 'package:go_mekanik/bloc/machineBloc.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcodePage extends StatefulWidget {
  const ScanBarcodePage({super.key});

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodePageState();
}

class _ScanBarcodePageState extends State<ScanBarcodePage> {
  final MobileScannerController cameraController = MobileScannerController();
  Barcode? _barcode;

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan Barcode Mesin Bermasalah',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }
    return Text(
      value.displayValue ?? 'No Barcode Value',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
      _sendBarcode();
    }
  }

  _sendBarcode() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [CircularProgressIndicator(), Text('Loading...')],
            ),
          );
        });
    Future.delayed(const Duration(milliseconds: 200), () async {
      // tambah machine Breakdown(order)
      String? idUser = await SessionManager().getIdUser();
      final resOrder = await orderBloc.tambahMachineBreakdown(
          _barcode?.rawValue, idUser, "masalah mesin");
      bool? statusOrder = resOrder['status'];
      if (statusOrder == true) {
        var showToast = ShowToast();
        showToast.showToastSuccess('Order berhasil ditambahkan');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode Mesin Bermasalah'),
      ),
      body: Stack(
        children: [
          MobileScanner(onDetect: _handleBarcode),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: _buildBarcode(_barcode),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
