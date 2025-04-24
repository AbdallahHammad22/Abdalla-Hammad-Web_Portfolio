import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/core/utils/const_data.dart';
import 'package:my_web_app/view/home/widget/profile_care_widget.dart';
import 'package:url_launcher/url_launcher.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/home'),
            child: const Text('الرئيسية', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            child: const Text('نبذة عني', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/projects'),
            child: const Text('أعمالي', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/services'),
            child: const Text('الخدمات', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/testimonials'),
            child: const Text('آراء العملاء', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/contact'),
            child: const Text('تواصل معي', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Abdallah\'s Portfolio',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('الرئيسية'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: const Text('نبذة عني'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              title: const Text('أعمالي'),
              onTap: () {
                Navigator.pushNamed(context, '/projects');
              },
            ),
            ListTile(
              title: const Text('الخدمات'),
              onTap: () {
                Navigator.pushNamed(context, '/services');
              },
            ),
            ListTile(
              title: const Text('آراء العملاء'),
              onTap: () {
                Navigator.pushNamed(context, '/testimonials');
              },
            ),
            ListTile(
              title: const Text('تواصل معي'),
              onTap: () {
                Navigator.pushNamed(context, '/contact');
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // قسم "نبذة مختصرة"
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/profile-pic.png'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'عبدالله حماد',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'مطور Flutter | بكالوريوس علوم حاسب',
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'مطور تطبيقات بخبرة 3 سنين في Flutter، متخصص في بناء تطبيقات موبايل وويب متجاوبة.',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Image(
                              image: AssetImage('assets/icon/linkedin.png'),
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                            onPressed: () => _launchUrl('https://www.linkedin.com/in/abdallah22/'),
                            tooltip: 'LinkedIn',
                          ),
                          IconButton(
                            icon: const Image(
                              image: AssetImage('assets/icon/github.png'),
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                            onPressed: () => _launchUrl('https://github.com/AbdallahHammad22'),
                            tooltip: 'GitHub',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // لمحة عن الأعمال
              FadeInUp(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  color: Colors.white.withOpacity(0.9),
                  child: Column(
                    children: [
                      const Text(
                        'أعمالي',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: projects.length > 2 ? 2 : projects.length,
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          return ProjectCard(
                            title: project['title']!,
                            description: project['description']!,
                            image: project['image']!,
                            url: project['url']!,
                            onTap: () => _launchUrl(project['url']!),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/projects'),
                        child: const Text('عرض جميع الأعمال', style: TextStyle(fontSize: 18, color: Colors.teal)),
                      ),
                    ],
                  ),
                ),
              ),
              // لمحة عن الخدمات
              FadeInUp(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Text(
                        'خدماتي',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: services
                            .take(2)
                            .map((service) => ServiceCard(
                                  title: service['title']!,
                                  description: service['description']!,
                                ))
                            .toList(),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/services'),
                        child: const Text('عرض جميع الخدمات', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}