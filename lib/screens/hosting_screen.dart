import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HostingScreen extends StatefulWidget {
  const HostingScreen({super.key});

  @override
  State<HostingScreen> createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isHosting = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _startHosting() {
    setState(() => _isHosting = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isHosting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم نشر الموقع بنجاح!', style: GoogleFonts.tajawal(fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF059669),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محرر الاستضافة'),
        // زر الرجوع واضح وموجود افتراضياً هنا بلون داكن واضح
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _isHosting ? null : _startHosting,
              icon: _isHosting 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Icon(Icons.cloud_upload_outlined),
              label: Text(_isHosting ? 'جاري النشر...' : 'نشر الموقع الآن'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: TextField(
                  controller: _codeController,
                  maxLines: null,
                  expands: true,
                  style: GoogleFonts.firaCode(color: const Color(0xFF0F172A), fontSize: 14),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '// اكتب كود HTML هنا...',
                    hintStyle: GoogleFonts.firaCode(color: Colors.grey.shade400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
