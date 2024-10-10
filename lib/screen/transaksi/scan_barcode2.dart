import 'package:flutter/material.dart';
import 'package:go_mekanik/screen/transaksi/found_barcode_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcode2 extends StatefulWidget {
  final String? idUser;
  const ScanBarcode2({super.key, required this.idUser});

  @override
  State<ScanBarcode2> createState() => _ScanBarcode2State();
}

class _ScanBarcode2State extends State<ScanBarcode2> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Barcode Mesin Bermasalah',
          style: TextStyle(fontSize: 15.0),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.grey);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front, color: Colors.grey);
                  case CameraFacing.back:
                    return const Icon(
                      Icons.camera_rear,
                      color: Colors.grey,
                    );
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          )
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _foundBarcode,
      ),
    );
  }

  void _foundBarcode(BarcodeCapture barcode) {
    if (!_screenOpened) {
      final Barcode code = barcode.barcodes.first;
      String? strBarcode = code.rawValue;

      debugPrint("barcode found!");
      _screenOpened = true;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoundBarcodeScreen(
                    idUser: widget.idUser!,
                    screenClosed: _screenWasClosed,
                    value: strBarcode,
                  )));
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}
