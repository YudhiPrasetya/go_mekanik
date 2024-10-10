// import 'dart:typed_data';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({super.key});

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("lkalskdsd");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode Mesin Bermasalah'),
        // actions: [
        // IconButton(
        //   color: Colors.white,
        //   icon: ValueListenableBuilder(
        //     valueListenable: cameraController.torchState,
        //     builder: (context, state, child) {
        //       switch (state) {
        //         case TorchState.off:
        //           return const Icon(
        //             Icons.flash_off,
        //             color: Colors.grey,
        //           );
        //         case TorchState.on:
        //           return const Icon(Icons.flash_on, color: Colors.yellow);
        //       }
        //     },
        //   ),
        //   iconSize: 32.0,
        //   onPressed: () => cameraController.toggleTorch(),
        // ),
        // IconButton(
        //   color: Colors.white,
        //   icon: ValueListenableBuilder(
        //     valueListenable: cameraController.cameraFacingState,
        //     builder: (context, state, child) {
        //       switch (state) {
        //         case CameraFacing.front:
        //           return const Icon(Icons.camera_front);
        //         case CameraFacing.back:
        //           return const Icon(Icons.camera_rear);
        //       }
        //     },
        //   ),
        //   iconSize: 32.0,
        //   onPressed: () => cameraController.switchCamera(),
        // ),
        // ],
      ),
      // body: MobileScanner(
      //     controller: cameraController,
      //     onDetect: (capture) {
      //       final List<Barcode> barcodes = capture.barcodes;
      //       // final Uint8List? image = capture.image;
      //       for (final barcode in barcodes) {
      //         debugPrint('Barcode found! ${barcode.rawValue}');
      //       }
      //     }),
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
