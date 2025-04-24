import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('تواصل معي'),
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
              children: [
                const Text(
                  'تواصل معي',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'لو عايز تتعاون أو تسأل عن أي حاجة، راسلني!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'الاسم',
                            border: OutlineInputBorder(),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            border: OutlineInputBorder(),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
                            labelText: 'الرسالة',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // لإرسال الرسالة (بدون تكامل Firebase حاليًا)
                            _launchUrl(
                                'mailto:your.email@example.com?subject=تواصل من الموقع&body=الاسم: ${nameController.text}%0Aالبريد: ${emailController.text}%0Aالرسالة: ${messageController.text}');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('إرسال'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      IconButton(
                      icon: const Image(
                        image: AssetImage('assets/icon/whatsapp.png'),
                        height: 30,
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () => _launchUrl('https://wa.link/bvaw3f'),
                      tooltip: 'Whatsapp',
                    ),
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
      ),
    );
  }
}