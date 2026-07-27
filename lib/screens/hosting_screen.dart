import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

class HostingScreen extends StatefulWidget {
  const HostingScreen({super.key});

  @override
  State<HostingScreen> createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  final TextEditingController _codeController = TextEditingController(text: '<!DOCTYPE html>\n<html>\n<body>\n  <h1>مرحباً بالعالم!</h1>\n</body>\n</html>');
  String _language = 'html';
  List<String> _errors = [];
  bool _isHosting = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _detectErrors() {
    setState(() {
      _errors = [];
      if (_language == 'html') {
        final lines = _codeController.text.split('\n');
        for (int i = 0; i < lines.length; i++) {
          final line = lines[i];
          if (line.contains('<') && !line.contains('>') && line.trim().isNotEmpty) {
            _errors.add('السطر ${i + 1}: وسم غير مكتمل');
          }
        }
      }
    });
  }

  void _startHosting() {
    _detectErrors();
    if (_errors.isNotEmpty) {
      _showModernSnackbar('يوجد أخطاء في الكود تمنع الاستضافة', Colors.redAccent);
      return;
    }

    setState(() => _isHosting = true);
    
    // محاكاة عملية الاستضافة
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isHosting = false);
      _showModernSnackbar('تم نشر الموقع بنجاح! 🚀', const Color(0xFF10B981));
    });
  }

  void _showModernSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1A1D2D),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محرر والاستضافة'),
        actions: [
          TextButton.icon(
            onPressed: _detectErrors,
            icon: const Icon(Icons.bug_report_outlined, size: 20),
            label: Text(
              _errors.isEmpty ? 'فحص' : '${_errors.length} أخطاء',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // شريط الأدوات العلوي
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1D2D),
              border: Border(bottom: BorderSide(color: Color(0xFF2A2E40))),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2E40),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _language,
                      dropdownColor: const Color(0xFF2A2E40),
                      style: GoogleFonts.cairo(color: Colors.white, fontSize: 14),
                      items: const [
                        DropdownMenuItem(value: 'html', child: Text('HTML')),
                        DropdownMenuItem(value: 'css', child: Text('CSS')),
                        DropdownMenuItem(value: 'javascript', child: Text('JavaScript')),
                      ],
                      onChanged: (value) => setState(() => _language = value!),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: _isHosting ? null : _startHosting,
                  icon: _isHosting 
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.rocket_launch, size: 18),
                  label: Text(_isHosting ? 'جاري النشر...' : 'نشر الموقع', style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),

          // منطقة محرر الأكواد
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF282C34),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF3A3F55)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    // شريط تبويب بسيط للمحرر
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: const Color(0xFF21252B),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF282C34),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                              border: Border.all(color: const Color(0xFF3A3F55), width: 1),
                              borderBottom: const BorderSide(color: Color(0xFF282C34), width: 2),
                            ),
                            child: Text('index.$_language', style: GoogleFonts.firaCode(fontSize: 12, color: Colors.grey.shade300)),
                          ),
                        ],
                      ),
                    ),
                    // حقل إدخال الكود
                    Expanded(
                      child: TextField(
                        controller: _codeController,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.firaCode(color: Colors.white, fontSize: 14, height: 1.5),
                        decoration: const InputDecoration(
                          hintText: '// اكتب الكود هنا...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // عرض الأخطاء بشكل أنيق (إذا وجدت)
          if (_errors.isNotEmpty)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A1515),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF502020)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 20),
                      const SizedBox(width: 8),
                      Text('تنبيهات الفحص', style: GoogleFonts.cairo(color: const Color(0xFFEF4444), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._errors.map((error) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(color: Color(0xFFEF4444))),
                        Expanded(
                          child: Text(error, style: GoogleFonts.cairo(color: Colors.grey.shade300, fontSize: 13)),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}