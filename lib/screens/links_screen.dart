import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LinksScreen extends StatelessWidget {
  const LinksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('الروابط الحية')), body: Center(child: Text('صفحة الروابط قيد التطوير', style: GoogleFonts.tajawal())));
  }
}
