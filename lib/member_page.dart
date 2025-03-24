import 'package:flutter/material.dart';
import 'homepage.dart';

class MemberDetailsPage extends StatelessWidget {
  final String name;
  final String position;
  final String domain;
  final String contribution;
  final String tenure;
  final String imageUrl;

  const MemberDetailsPage({
    super.key,
    required this.name,
    required this.position,
    required this.domain,
    required this.contribution,
    required this.tenure,
    required this.imageUrl,
  });

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
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                color: Colors.orange,
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Positioned(
              right: -20,
              top: 20,
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'TEAM E LABS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 75,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 18.0,
                    shadows: [
                      Shadow(
                        blurRadius: 20,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('lib/assets/kiit_main.png', height: 60),
                      const SizedBox(width: 45),
                      const Text(
                        'MEMBER',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 150,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 135,
                              backgroundColor: Colors.orange,
                              child: CircleAvatar(
                                radius: 125,
                                backgroundImage: imageUrl.isNotEmpty
                                    ? NetworkImage(imageUrl)
                                    : AssetImage(
                                            'lib/assets/default_profile.jpg')
                                        as ImageProvider,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailItem('Position', position),
                  _buildDetailItem('Domain', domain),
                  _buildDetailItem('Contribution', contribution),
                  _buildDetailItem('Tenure', tenure),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('lib/assets/elabs_logo.jpg', height: 40),
                          const Padding(
                            padding: EdgeInsets.only(right: 80),
                            child: Text(
                              '@elabs.kiit',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
                color: Colors.orange,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
