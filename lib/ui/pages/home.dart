import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/SumWidget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.josefinSansTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(child: SumWidget()),
      ),
    );
  }
}
