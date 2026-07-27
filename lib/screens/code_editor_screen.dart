import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

class CodeEditorScreen extends StatefulWidget {
  const CodeEditorScreen({super.key});

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _language = 'html';
  List<String> _errors = [];

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _detectErrors() {
    setState(() {
      _errors = [];
      
      if (_language == 'html') {
        final code = _codeController.text;
        final lines = code.split('\n');
        
        // فحص بسيط للأخطاء الشائعة في HTML
        for (int i = 0; i < lines.length; i++) {
          final line = lines[i];
          
          // فحص الوسوم غير المغلقة
          if (line.contains('<') && !line.contains('>') && line.trim().isNotEmpty) {
            _errors.add('السطر ${i + 1}: وسم HTML غير مكتمل');
          }
          
          // فحص علامات الاقتباس غير المغلقة
          final quoteCount = '<>"'.split('').where((c) => line.contains(c)).length;
          if (quoteCount % 2 != 0 && line.contains('<')) {
            _errors.add('السطر ${i + 1}: علامة اقتباس غير مغلقة');
          }
        }
      }
    });
  }

  void _hostWebsite() {
    if (_errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يمكن الاستضافة: يوجد أخطاء في الكود'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم بدء الاستضافة بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
    
    // هنا سيتم إضافة منطق الاستضافة الفعلي لاحقاً
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محرر الأكواد'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            tooltip: 'استضافة الموقع',
            onPressed: _hostWebsite,
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط اختيار اللغة
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF1A1F3A),
            child: Row(
              children: [
                const Text(
                  'اللغة:',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _language,
                  dropdownColor: const Color(0xFF1A1F3A),
                  style: const TextStyle(color: Colors.white),
                  items: [
                    DropdownMenuItem(value: 'html', child: Text('HTML')),
                    DropdownMenuItem(value: 'css', child: Text('CSS')),
                    DropdownMenuItem(value: 'javascript', child: Text('JavaScript')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _language = value!;
                    });
                  },
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.error_outline, color: Colors.red),
                  label: Text(
                    '${_errors.length} أخطاء',
                    style: const TextStyle(color: Colors.red),
                  ),
                  onPressed: _detectErrors,
                ),
              ],
            ),
          ),

          // محرر الأكواد
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF282C34),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _codeController,
                maxLines: null,
                expands: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  hintText: 'اكتب الكود هنا...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                onChanged: (value) {
                  // يمكن إضافة التحقق التلقائي هنا
                },
              ),
            ),
          ),

          // معاينة الكود مع تلوين الصيغة
          if (_codeController.text.isNotEmpty)
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF282C34),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: HighlightView(
                    _codeController.text,
                    language: _language,
                    theme: atomOneDarkTheme,
                    padding: const EdgeInsets.all(12),
                    textStyle: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

          // عرض الأخطاء
          if (_errors.isNotEmpty)
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الأخطاء المكتشفة:',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._errors.map((error) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $error',
                      style: const TextStyle(color: Colors.redAccent),
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