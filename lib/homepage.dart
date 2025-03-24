import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'landingpage.dart';

const bgColor = Color.fromARGB(255, 43, 22, 2);
const accentColor = Color(0xFFFFA500);

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isProcessing = false;
  bool isFlashOn = false;
  MobileScannerController controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
      controller.toggleTorch();
    });
  }

  void _handleQRDetection(BarcodeCapture capture) async {
    if (isProcessing) return;
    setState(() => isProcessing = true);
    controller.stop();
    final barcode = capture.barcodes.first;
    if (barcode.format == BarcodeFormat.qrCode) {
      final scannedCode = barcode.rawValue ?? 'No data found';

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LandingPage(code: scannedCode),
        ),
      ).then((_) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() => isProcessing = false);
            controller.start();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double scanBoxSize = 250;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: controller,
              onDetect: _handleQRDetection,
            ),
          ),
          Positioned.fill(
            child: Stack(
              children: [
                ClipPath(
                  clipper: ScannerOverlay(scanBoxSize: scanBoxSize),
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
                Center(
                  child: Container(
                    width: scanBoxSize,
                    height: scanBoxSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: accentColor, width: 4),
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(
                isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 30,
              ),
              onPressed: toggleFlash,
            ),
          ),
          Positioned(
            bottom: 100,
            child: Column(
              children: const [
                Text(
                  "PLACE THE QR HERE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Scanning will start automatically",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('lib/assets/kiit_main.png', height: 50),
                  Image.asset('lib/assets/elabs_logo.jpg', height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlay extends CustomClipper<Path> {
  final double scanBoxSize;

  ScannerOverlay({required this.scanBoxSize});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    path.addRRect(
      RRect.fromRectXY(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: scanBoxSize,
          height: scanBoxSize,
        ),
        18,
        18,
      ),
    );

    return path..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(ScannerOverlay oldClipper) => true;
}
