import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class BotsScreen extends StatelessWidget {
  const BotsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('بوتات تيليجرام')), body: Center(child: Text('صفحة البوتات قيد التطوير', style: GoogleFonts.tajawal())));
  }
}
