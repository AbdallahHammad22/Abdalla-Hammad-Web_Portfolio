import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/core/utilities/app_strings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نبذة عني'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
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
          padding: const EdgeInsets.all(32),
          child: FadeInUp(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(AppStrings.profile),
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
                  'حاصل على بكالوريوس علوم الحاسب من [اسم الجامعة] عام [السنة]. بدأت رحلتي كمطور Flutter من 3 سنين، واشتغلت على مشاريع متنوعة زي تطبيقات التجارة الإلكترونية والتطبيقات التحفيزية. مهمتي هي تحويل الأفكار إلى تطبيقات سهلة الاستخدام ومتجاوبة.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 32),
                const Text(
                  'تعليمي',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'بكالوريوس علوم الحاسب',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '[اسم الجامعة] - [السنة]',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'رحلتي المهنية',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مطور Flutter - 2022-الآن',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'اشتغلت على تطوير تطبيقات موبايل وويب باستخدام Flutter، مع التركيز على الأداء وتجربة المستخدم.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
