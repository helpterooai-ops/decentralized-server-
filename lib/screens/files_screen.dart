import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('مدير الملفات')), body: Center(child: Text('صفحة الملفات قيد التطوير', style: GoogleFonts.tajawal())));
  }
}
