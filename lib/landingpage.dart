import 'package:flutter/material.dart';
import 'homepage.dart';
import 'member_page.dart';
import 'participant_page.dart';

class LandingPage extends StatefulWidget {
  final String code;

  const LandingPage({super.key, required this.code});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isInvalid = false;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _processQRCode();
  }

  void _processQRCode() async {
    if (isProcessing) return;
    isProcessing = true;

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    List<String> details = widget.code.split(",");

    if (widget.code.startsWith("MEMBER:")) {
      if (details.length < 6) {
        setState(() => isInvalid = true);
        return;
      }

      try {
        String name = _extractValue(details[0]);
        String position = _extractValue(details[1]);
        String domain = _extractValue(details[2]);
        String contribution = _extractValue(details[3]);
        String tenure = _extractValue(details[4]);
        String imageUrl = details[5].substring(6);

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MemberDetailsPage(
              name: name,
              position: position,
              domain: domain,
              contribution: contribution,
              tenure: tenure,
              imageUrl: imageUrl,
            ),
          ),
        );
      } catch (e) {
        setState(() => isInvalid = true);
      }
    } else if (widget.code.startsWith("PARTICIPANT:")) {
      if (details.length < 4) {
        setState(() => isInvalid = true);
        return;
      }

      try {
        String name = _extractValue(details[0]);
        String eventName = _extractValue(details[1]);
        String eventDate = _extractValue(details[2]);
        String category = _extractValue(details[3]);

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EventParticipantPage(
              name: name,
              eventName: eventName,
              eventDate: eventDate,
              category: category,
            ),
          ),
        );
      } catch (e) {
        setState(() => isInvalid = true);
      }
    } else {
      setState(() => isInvalid = true);
    }
  }

  String _extractValue(String field) {
    return field.contains("=") ? field.split("=")[1] : "";
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            if (isInvalid)
              Positioned(
                top: 40,
                left: 15,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.orange, size: 35),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  },
                ),
              ),
            Center(
              child: isInvalid
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cancel, color: Colors.red, size: 100),
                        SizedBox(height: 20),
                        Text(
                          "QR Not Valid",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
