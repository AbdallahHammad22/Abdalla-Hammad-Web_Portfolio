import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_web_app/core/utilities/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // استبدل هذه القيم بقيمك من EmailJS
  final String serviceId = 'service_bh773hw'; // Service ID من EmailJS
  final String templateId = 'template_71epizh'; // Template ID من EmailJS
  final String userId = 'oHmpVvEjRJz4bf0ds'; // User ID من EmailJS
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _sendEmail() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        messageController.text.isNotEmpty) {
      if (!_isValidEmail(emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يرجى إدخال بريد إلكتروني صحيح!')),
        );
        return;
      }
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': nameController.text,
            'from_email': emailController.text,
            'reply_to': emailController.text,
            'message': messageController.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إرسال الرسالة بنجاح!')),
        );
        nameController.clear();
        emailController.clear();
        messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'فشل في إرسال الرسالة: ${response.statusCode} - ${response.body}'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء جميع الحقول!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context, isMobile, _scaffoldKey),
      drawer: _buildDrawer(context, isMobile),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchUrl(
              'https://wa.me/01029576647'); // Replace with your WhatsApp link
        },
        backgroundColor: Colors.teal,
        icon: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        label: Text(
          'تواصل معي الآن',
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueGrey],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              _buildHeroSection(context, isMobile),
              _buildContactFormSection(context, isMobile),
              _buildContactInfoSection(context, isMobile),
              //_buildMapSection(context, isMobile),
              _buildSocialMediaSection(context, isMobile),
              _buildFooter(context, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar
  AppBar _buildAppBar(BuildContext context, bool isMobile,
      GlobalKey<ScaffoldState> scaffoldKey) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isContactPage = currentRoute == '/contact';
    bool isHovered = false;

    return AppBar(
      backgroundColor: Colors.teal.shade600,
      foregroundColor: Colors.white,
      elevation: 2,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) {
              setState(() {
                isHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                isHovered = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                if (isContactPage) {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isHovered
                        ? Colors.white.withOpacity(0.8)
                        : Colors.white,
                    letterSpacing: 0.5,
                  ),
                  child: const Text(
                    'عبدالله حماد',
                  ),
                ),
              ),
            ),
          );
        },
      ),
      actions: isMobile
          ? []
          : [
              _buildAppBarButton(
                context: context,
                title: 'الرئيسية',
                icon: Icons.home,
                route: '/home',
              ),
              _buildAppBarButton(
                context: context,
                title: 'نبذة عني',
                icon: Icons.person,
                route: '/about',
              ),
              _buildAppBarButton(
                context: context,
                title: 'أعمالي',
                icon: Icons.work,
                route: '/projects',
              ),
              _buildAppBarButton(
                context: context,
                title: 'الخدمات',
                icon: Icons.build,
                route: '/services',
              ),
              _buildAppBarButton(
                context: context,
                title: 'آراء العملاء',
                icon: Icons.star,
                route: '/testimonials',
              ),
              _buildAppBarButton(
                context: context,
                title: 'تواصل معي',
                icon: Icons.contact_mail,
                route: '/contact',
              ),
              const SizedBox(width: 8),
            ],
    );
  }

  Widget _buildAppBarButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String route,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: () {
          if (ModalRoute.of(context)?.settings.name != route) {
            Navigator.pushNamed(context, route);
          }
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white70,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer
  Drawer _buildDrawer(BuildContext context, bool isMobile) {
    return Drawer(
      width: isMobile ? null : 350,
      elevation: 16,
      child: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal, Colors.tealAccent],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(AppStrings.profile),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'عبدالله حماد',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 22 : 26,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  _buildDrawerItem(
                    context: context,
                    title: 'الرئيسية',
                    icon: Icons.home,
                    route: '/home',
                    isMobile: isMobile,
                  ),
                  _buildDrawerItem(
                    context: context,
                    title: 'نبذة عني',
                    icon: Icons.person,
                    route: '/about',
                    isMobile: isMobile,
                  ),
                  _buildDrawerItem(
                    context: context,
                    title: 'أعمالي',
                    icon: Icons.work,
                    route: '/projects',
                    isMobile: isMobile,
                  ),
                  _buildDrawerItem(
                    context: context,
                    title: 'الخدمات',
                    icon: Icons.build,
                    route: '/services',
                    isMobile: isMobile,
                  ),
                  _buildDrawerItem(
                    context: context,
                    title: 'آراء العملاء',
                    icon: Icons.star,
                    route: '/testimonials',
                    isMobile: isMobile,
                  ),
                  _buildDrawerItem(
                    context: context,
                    title: 'تواصل معي',
                    icon: Icons.contact_mail,
                    route: '/contact',
                    isMobile: isMobile,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 16 : 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '© 2025 عبدالله حماد - صمم بكل ',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String route,
    required bool isMobile,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16, vertical: 4),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
            size: isMobile ? 28 : 32,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
          onTap: () {
            Navigator.pop(context);
            if (ModalRoute.of(context)?.settings.name != route) {
              Navigator.pushNamed(context, route);
            }
          },
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          hoverColor: Colors.teal.withOpacity(0.1),
          splashColor: Colors.teal.withOpacity(0.3),
        ),
      ),
    );
  }

  // Hero Section
  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      height: isMobile
          ? MediaQuery.of(context).size.height * 0.6
          : MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppStrings.hero),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  'تواصل معي الآن',
                  style: TextStyle(
                    fontSize: isMobile ? 25 : 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(height: 16),
              FadeInDown(
                duration: const Duration(milliseconds: 300),
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'هل لديك فكرة مشروع؟ أرسل رسالتك وسنتواصل معك في أقرب وقت!',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 24,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(height: 32),
              Pulse(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: () {
                    _launchUrl(
                        'https://wa.me/01029576647'); // Replace with your WhatsApp link
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 32 : 48,
                      vertical: isMobile ? 16 : 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: Text(
                    'راسلني على WhatsApp',
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Contact Form Section
  Widget _buildContactFormSection(BuildContext context, bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildContactForm(context, isMobile),
                const SizedBox(height: 24),
                _buildContactImage(isMobile),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Flexible(flex: 6, child: _buildContactForm(context, isMobile)),
                const SizedBox(width: 32),
                Flexible(flex: 4, child: _buildContactImage(isMobile)),
              ],
            ),
    );
  }

  Widget _buildContactForm(BuildContext context, bool isMobile) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            'أرسل رسالتك',
            style: TextStyle(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Text(
            'لو عايز تتعاون أو تسأل عن أي حاجة، راسلني!',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.black87,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'الاسم',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'البريد الإلكتروني',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: messageController,
            decoration: InputDecoration(
              hintText: 'الرسالة',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            maxLines: 4,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  messageController.text.isNotEmpty) {
                await _sendEmail();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('يرجى ملء جميع الحقول!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'إرسال الرسالة',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactImage(bool isMobile) {
    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          AppStrings.profile,
          height: isMobile ? 200 : 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Contact Info Section
  Widget _buildContactInfoSection(BuildContext context, bool isMobile) {
    final contactInfo = [
      ContactInfo(
        icon: Icons.email,
        title: 'البريد الإلكتروني',
        value: 'abdallahhamad343@gmail.com',
        url: 'mailto:your.email@example.com',
      ),
      ContactInfo(
        icon: Icons.phone,
        title: 'رقم الهاتف',
        value: '201029576647+',
        url: 'tel:01029576647',
      ),
      ContactInfo(
        icon: Icons.location_on,
        title: 'الموقع',
        value: 'القاهرة، مصر',
        url: '',
      ),
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'معلومات التواصل',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          StaggeredGrid.count(
            crossAxisCount: isMobile ? 1 : 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: contactInfo.asMap().entries.map((entry) {
              final index = entry.key;
              final info = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: GestureDetector(
                  onTap:
                      info.url.isNotEmpty ? () => _launchUrl(info.url) : null,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          info.icon,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              info.value,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // // Map Section
  // Widget _buildMapSection(BuildContext context, bool isMobile) {
  //   return Container(
  //     constraints: const BoxConstraints(maxWidth: 1200),
  //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
  //     padding: const EdgeInsets.all(32),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.95),
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         FadeInUp(
  //           duration: const Duration(milliseconds: 800),
  //           child: Text(
  //             'موقعي',
  //             style: TextStyle(
  //               fontSize: isMobile ? 28 : 32,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.teal,
  //             ),
  //             textDirection: TextDirection.rtl,
  //           ),
  //         ),
  //         const SizedBox(height: 24),
  //         FadeInUp(
  //           duration: const Duration(milliseconds: 1000),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: Image.network(
  //               'https://maps.googleapis.com/maps/api/staticmap?center=Cairo,Egypt&zoom=12&size=600x300&maptype=roadmap&key=YOUR_API_KEY', // Replace with a static map image URL
  //               height: isMobile ? 200 : 300,
  //               width: double.infinity,
  //               fit: BoxFit.cover,
  //               errorBuilder: (context, error, stackTrace) => Container(
  //                 height: isMobile ? 200 : 300,
  //                 color: Colors.grey.shade200,
  //                 child: const Center(
  //                   child: Text(
  //                     'فشل تحميل الخريطة',
  //                     style: TextStyle(color: Colors.black54),
  //                     textDirection: TextDirection.rtl,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Social Media Section
  Widget _buildSocialMediaSection(BuildContext context, bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'تابعني على وسائل التواصل',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment:
                isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: [
              ElasticIn(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 200),
                child: _SocialIcon(
                  asset: AppStrings.whatsapp,
                  url:
                      'https://wa.me/+01029576647', // Replace with your WhatsApp link
                  tooltip: 'WhatsApp',
                  onTap: _launchUrl,
                ),
              ),
              const SizedBox(width: 16),
              ElasticIn(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 300),
                child: _SocialIcon(
                  asset: AppStrings.facebook,
                  url: 'https://www.facebook.com/DevAbdallahHammad/',
                  tooltip: 'Facebook',
                  onTap: _launchUrl,
                ),
              ),
              const SizedBox(width: 16),
              ElasticIn(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 400),
                child: _SocialIcon(
                  asset: AppStrings.linkedin,
                  url: 'https://www.linkedin.com/in/abdallah22/',
                  tooltip: 'LinkedIn',
                  onTap: _launchUrl,
                ),
              ),
              const SizedBox(width: 16),
              ElasticIn(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 500),
                child: _SocialIcon(
                  asset: AppStrings.github,
                  url: 'https://github.com/AbdallahHammad22',
                  tooltip: 'GitHub',
                  onTap: _launchUrl,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Footer
  Widget _buildFooter(BuildContext context, bool isMobile) {
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'عبدالله حماد - مطور Flutter',
            style: TextStyle(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: const Text('الرئيسية',
                    style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                child: const Text('نبذة عني',
                    style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/projects'),
                child: const Text('أعمالي',
                    style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/services'),
                child: const Text('الخدمات',
                    style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '© 2025 جميع الحقوق محفوظة - عبدالله حماد',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.white70,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}

// Data Classes
class ContactInfo {
  final IconData icon;
  final String title;
  final String value;
  final String url;

  ContactInfo({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
  });
}

// Widgets
class _SocialIcon extends StatefulWidget {
  final String asset;
  final String url;
  final String tooltip;
  final void Function(String) onTap;

  const _SocialIcon({
    required this.asset,
    required this.url,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..scale(isHovered ? 1.3 : 1.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Tooltip(
            message: widget.tooltip,
            child: Image(
              image: AssetImage(widget.asset),
              height: 36,
              fit: BoxFit.cover,
              color: widget.asset == AppStrings.whatsapp && !isHovered
                  ? Colors.white
                  : null,
              colorBlendMode: isHovered ? BlendMode.modulate : null,
            ),
          ),
        ),
      ),
    );
  }
}
