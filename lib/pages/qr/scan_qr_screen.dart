// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// import 'package:crypto_wallet/utils/theme.dart';

// class ScanQRScreen extends StatefulWidget {
//   const ScanQRScreen({super.key});

//   @override
//   State<ScanQRScreen> createState() => _ScanQRScreenState();
// }

// class _ScanQRScreenState extends State<ScanQRScreen> {
//   final MobileScannerController controller = MobileScannerController();

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.bodyBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppTheme.appBarColor,
//         title: const Text(
//           'Scan QR Code',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null) {
//                   // Extract address from QR code
//                   String? address = barcode.rawValue;
//                   // Handle ethereum: prefix if present
//                   if (address != null && address.startsWith('ethereum:')) {
//                     address = address.substring(9).split('?')[0];
//                   }
//                   if (address != null && address.startsWith('0x')) {
//                     Navigator.pop(context, address);
//                     return;
//                   }
//                 }
//               }
//             },
//           ),
//           Positioned(
//             bottom: 50,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.black54,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Text(
//                   'Position QR code within the frame',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:crypto_wallet/utils/theme.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  bool _isScanned = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onBarcodeDetected(Barcode barcode) {
    if (_isScanned) return;

    String? value = barcode.rawValue;
    if (value == null) return;

    // Handle ethereum: prefix (EIP-681)
    if (value.startsWith('ethereum:')) {
      value = value.replaceFirst('ethereum:', '').split('?').first;
    }

    // Basic Ethereum address validation
    if (value.startsWith('0x') && value.length == 42) {
      _isScanned = true;
      Navigator.pop(context, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bodyBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        title: const Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          /// Camera view
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              for (final barcode in capture.barcodes) {
                _onBarcodeDetected(barcode);
              }
            },
          ),

          /// Scanner frame
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),

          /// Instruction text
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Align the QR code inside the frame',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


