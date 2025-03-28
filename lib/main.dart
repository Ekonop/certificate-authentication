import 'package:flutter/material.dart';
import 'package:qr_scanner/homepage.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      )),
      debugShowCheckedModeBanner: false,
      title: "QR Scanner",
      routerConfig: GoRouter(routes: [
        GoRoute(path: '/', builder: (context, state) => const Homepage()),	

        //GoRoute(path: '/Landing', builder: (context, state) => const LandingPage(code: '',)),
      ]),
    );
  }
}
