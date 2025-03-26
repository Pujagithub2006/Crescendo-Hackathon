import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRPage extends StatelessWidget {
  const QRPage ({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Scan QR Code'),
          backgroundColor: Colors.orange,
        ),

        body: MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('QR Code Scanned: ${barcode.rawValue}');
                _showResult(context, barcode.rawValue ?? 'No QR Code detected');
              }
            }
        )
      );
    }

    void _showResult(BuildContext context, String result) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('QR Code Results'),
              content: Text(result),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                )
              ],
            );
          }
      );
    }
  }


