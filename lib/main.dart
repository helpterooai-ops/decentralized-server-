import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/hosting_screen.dart';
import 'screens/bots_screen.dart';
import 'screens/files_screen.dart';
import 'screens/links_screen.dart';

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
        brightness: Brightness.light, // وضع فاتح
        primaryColor: const Color(0xFF2563EB), // أزرق حديث وواضح
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // خلفية فاتحة جداً ونظيفة
        
        // الخط العربي الحديث
        textTheme: GoogleFonts.tajawalTextTheme(ThemeData.light().textTheme),
        
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.tajawal(
            color: const Color(0xFF0F172A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Color(0xFF0F172A)), // أيقونة الرجوع واضحة جداً
        ),
        
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16),
          ),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الترحيب
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحباً بك 👋',
                    style: GoogleFonts.tajawal(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'منصتك السحابية اللامركزية لإدارة مشاريعك بسهولة واحترافية.',
                    style: GoogleFonts.tajawal(
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
              'الخدمات',
              style: GoogleFonts.tajawal(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 16),
            
            // شبكة الخدمات (كل زر يفتح صفحة مستقلة)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                ServiceCard(
                  icon: Icons.code_outlined,
                  title: 'الاستضافة',
                  subtitle: 'محرر ومواقع ويب',
                  color: const Color(0xFF2563EB),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HostingScreen())),
                ),
                ServiceCard(
                  icon: Icons.smart_toy_outlined,
                  title: 'بوتات تيليجرام',
                  subtitle: 'إدارة وتشغيل',
                  color: const Color(0xFF7C3AED),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BotsScreen())),
                ),
                ServiceCard(
                  icon: Icons.folder_open_outlined,
                  title: 'مدير الملفات',
                  subtitle: 'تخزين سحابي',
                  color: const Color(0xFF059669),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FilesScreen())),
                ),
                ServiceCard(
                  icon: Icons.link_outlined,
                  title: 'الروابط الحية',
                  subtitle: 'مشاركة سريعة',
                  color: const Color(0xFFD97706),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LinksScreen())),
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
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.tajawal(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
