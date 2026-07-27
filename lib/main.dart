import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/hosting_screen.dart'; // لاحظ أننا سنغير اسم الملف في الخطوة التالية

void main() {
  runApp(const PocketCloudApp());
}

class PocketCloudApp extends StatelessWidget {
  const PocketCloudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Cloud',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // استخدام خط Cairo الحديث للعربية
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: const Color(0xFF0F111A), // خلفية داكنة فاخرة
        primaryColor: const Color(0xFF3B82F6), // أزرق عصري
        cardTheme: CardTheme(
          color: const Color(0xFF1A1D2D),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF2A2E40), width: 1),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0F111A),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF3B82F6),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket Cloud'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم الترحيب
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحباً بك 👋',
                    style: GoogleFonts.cairo(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'حوّل هاتفك إلى خادم سحابي لامركزي قوي وآمن.',
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            Text(
              'الخدمات المتاحة',
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            
            // شبكة الخدمات
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                ServiceCard(
                  icon: Icons.code_rounded,
                  title: 'محرر والاستضافة',
                  subtitle: 'اكتب وارفع مواقعك',
                  color: const Color(0xFF3B82F6),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HostingScreen()),
                    );
                  },
                ),
                const ServiceCard(
                  icon: Icons.smart_toy_rounded,
                  title: 'بوتات تيليجرام',
                  subtitle: 'تشغيل مستمر 24/7',
                  color: Color(0xFF8B5CF6),
                ),
                const ServiceCard(
                  icon: Icons.folder_open_rounded,
                  title: 'مدير الملفات',
                  subtitle: 'تحكم كامل في التخزين',
                  color: Color(0xFF10B981),
                ),
                const ServiceCard(
                  icon: Icons.link_rounded,
                  title: 'الروابط الحية',
                  subtitle: 'مشاركة فورية وآمنة',
                  color: Color(0xFFF59E0B),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}