import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_web_app/core/utilities/app_color.dart';
import 'package:my_web_app/core/utilities/app_strings.dart';
import 'package:my_web_app/core/utilities/widget/main_button.dart';
import 'package:my_web_app/core/utilities/widget/main_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
          _launchUrl('https://wa.link/bvaw3f');
        },
        backgroundColor: Colors.teal,
        icon: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        label: Text(
          'تواصل معنا الآن',
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
              _buildServicesSection(context, isMobile),
              _buildProjectLifecycleSection(context, isMobile),
              _buildWhyChooseUsSection(context, isMobile),
              _buildServerSelectionSection(context, isMobile),
              _buildDigitalTransformationSection(context, isMobile),
              _buildStatsSection(context, isMobile),
              _buildTestimonialsSection(context, isMobile),
              _buildContactSection(context, isMobile),
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
    final isServicesPage = currentRoute == '/services';
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
                if (isServicesPage) {
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
                  'خدمات تقنية شاملة من البداية إلى النهاية',
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
                  'فريقنا يقدم حلولاً تقنية متكاملة: من تطوير تطبيقات الموبايل والويب إلى تصميم UI/UX وإدارة المشاريع.',
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
                    _launchUrl('https://wa.link/bvaw3f');
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
                    'تواصل معنا الآن',
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

  // Services Section (Updated with Tools as Icons)
  Widget _buildServicesSection(BuildContext context, bool isMobile) {
    final services = [
      Service(
        title: 'تطوير تطبيقات الموبايل',
        description:
            'نصمم ونطور تطبيقات موبايل متجاوبة لضمان أداء عالٍ وتجربة مستخدم سلسة على منصتي iOS وAndroid.',
        icon: Icons.phone_android,
        tools: [
          Tool(name: 'Flutter', icon: Icons.developer_board),
          Tool(name: 'Dart', icon: Icons.code),
          Tool(name: 'Firebase', icon: Icons.cloud),
          Tool(name: 'API', icon: Icons.api),
          Tool(name: 'State Management', icon: Icons.settings),
        ],
      ),
      Service(
        title: 'تطوير الباك إند',
        description:
            'فريقنا التقني يبني أنظمة باك إند قوية لضمان أداء مستقر وآمن.',
        icon: Icons.storage,
        tools: [
          Tool(name: 'PHP', icon: Icons.code),
          Tool(name: 'Laravel', icon: Icons.web),
          Tool(name: 'Node.js', icon: Icons.developer_board),
          Tool(name: 'MongoDB', icon: Icons.storage),
        ],
      ),
      Service(
        title: 'تطوير تطبيقات الويب',
        description:
            'نقدم حلول ويب حديثة مع التركيز على واجهات تفاعلية وأداء عالٍ.',
        icon: Icons.web,
        tools: [
          Tool(name: 'JavaScript', icon: Icons.code),
          Tool(name: 'React', icon: Icons.web_asset),
          Tool(name: 'Angular', icon: Icons.web),
        ],
      ),
      Service(
        title: 'تصميم UI/UX',
        description:
            'فريق التصميم لدينا يبتكر واجهات مستخدم جذابة وسهلة الاستخدام تلبي احتياجات العملاء.',
        icon: Icons.design_services,
        tools: [
          Tool(name: 'Figma', icon: Icons.design_services),
          Tool(name: 'Adobe XD', icon: Icons.brush),
        ],
      ),
      Service(
        title: 'إدارة المشاريع من البداية إلى النهاية',
        description:
            'نبدأ معك من الفكرة وصولاً إلى الإطلاق، مع إدارة كاملة لدورة حياة المشروع.',
        icon: Icons.work,
        tools: [
          Tool(name: 'Clickup', icon: Icons.view_kanban),
          Tool(name: 'Jira', icon: Icons.task),
          Tool(name: 'Slack', icon: Icons.chat),
        ],
      ),
      Service(
        title: 'تطوير وتحسين المشاريع القائمة',
        description:
            'نستلم مشاريعك الحالية، نحللها، ونطورها لتحسين الأداء وإضافة ميزات جديدة.',
        icon: Icons.update,
        tools: [
          Tool(name: 'Git', icon: Icons.code),
          Tool(name: 'Postman', icon: Icons.api),
          Tool(name: 'Unit Testing', icon: Icons.bug_report),
        ],
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
              'خدماتنا المميزة',
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
            crossAxisCount: isMobile ? 1 : 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: services.asMap().entries.map((entry) {
              final index = entry.key;
              final service = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: _ServiceCard(service: service, isMobile: isMobile),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectLifecycleSection(BuildContext context, bool isMobile) {
    final projectSteps = [
      ProjectStep(
        title: 'جمع المتطلبات',
        description: 'نناقش فكرتك ونحدد المتطلبات الأساسية للمشروع.',
        icon: Icons.description, // 📋
      ),
      ProjectStep(
        title: 'التخطيط والتصميم',
        description: 'نضع خطة شاملة ونصمم الواجهات (UI/UX).',
        icon: Icons.design_services, // ✏️
      ),
      ProjectStep(
        title: 'التطوير',
        description: 'نبدأ في بناء التطبيق باستخدام أحدث التقنيات.',
        icon: Icons.code, // 💻
      ),
      ProjectStep(
        title: 'الاختبار',
        description: 'نجري اختبارات شاملة لضمان الجودة والأداء.',
        icon: Icons.science, // 🧪
      ),
      ProjectStep(
        title: 'الإطلاق والدعم',
        description: 'نطلق المشروع ونقدم دعمًا مستمرًا.',
        icon: Icons.rocket_launch, // 🚀
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
              'دورة حياة المشروع',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: projectSteps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        step.icon,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.title,
                              style: TextStyle(
                                fontSize: isMobile ? 18 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step.description,
                              style: TextStyle(
                                fontSize: isMobile ? 16 : 18,
                                color: Colors.white70,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Why Choose Us Section
  Widget _buildWhyChooseUsSection(BuildContext context, bool isMobile) {
    final benefits = [
      Benefit(
        title: 'فريق شامل متعدد التخصصات',
        description:
            'فريقنا يضم مطوري موبايل، ويب، باك إند، ومصممي UI/UX لتقديم حلول متكاملة.',
        icon: Icons.group,
      ),
      Benefit(
        title: 'جودة عالية وأداء مضمون',
        description:
            'نركز على تقديم منتجات بجودة عالية مع اختبارات شاملة لضمان الأداء.',
        icon: Icons.verified,
      ),
      Benefit(
        title: 'دعم فني مستمر',
        description:
            'نقدم دعمًا فنيًا بعد الإطلاق لضمان استمرارية عمل مشروعك بسلاسة.',
        icon: Icons.support_agent,
      ),
      Benefit(
        title: 'التسليم في الوقت المحدد',
        description:
            'نلتزم بالجداول الزمنية لتسليم مشاريعك في الموعد المحدد دون تأخير.',
        icon: Icons.timer,
      ),
      Benefit(
        title: 'حلول مخصصة',
        description:
            'نقدم حلولاً تقنية مصممة خصيصًا لتلبية احتياجات مشروعك وأهدافك.',
        icon: Icons.settings,
      ),
      Benefit(
        title: 'خبرة واسعة في السوق',
        description:
            'لدينا خبرة واسعة في السوق التقني تمتد لأكثر من 3 سنوات مع مشاريع متنوعة.',
        icon: Icons.star,
      ),
    ];

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'لماذا تختار فريقنا؟',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          StaggeredGrid.count(
            crossAxisCount: isMobile ? 1 : 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: benefits.asMap().entries.map((entry) {
              final index = entry.key;
              final benefit = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: _BenefitCard(benefit: benefit, isMobile: isMobile),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildServerSelectionSection(BuildContext context, bool isMobile) {
    final serverSteps = [
      ServerStep(
        title: 'فهم احتياجات المشروع',
        description: 'نحلل عدد المستخدمين، حجم البيانات، ونوع التطبيق.',
        icon: Icons.extension, // 🧩
      ),
      ServerStep(
        title: 'الأداء والسرعة',
        description: 'نختار سيرفرات عالية الأداء مثل AWS وGoogle Cloud.',
        icon: Icons.speed, // ⚡
      ),
      ServerStep(
        title: 'التكلفة المناسبة',
        description: 'نراعي ميزانيتك مع خيارات مثل DigitalOcean.',
        icon: Icons.attach_money, // 💰
      ),
      ServerStep(
        title: 'قابلية التوسع',
        description: 'نضمن دعم نمو مشروعك المستقبلي.',
        icon: Icons.trending_up, // 📈
      ),
      ServerStep(
        title: 'الأمان',
        description: 'نستخدم سيرفرات تدعم التشفير و firewalls.',
        icon: Icons.lock, // 🔒
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
              'كيف نختار السيرفرات المناسبة لمشروعك؟',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: serverSteps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        step.icon,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.title,
                              style: TextStyle(
                                fontSize: isMobile ? 18 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step.description,
                              style: TextStyle(
                                fontSize: isMobile ? 16 : 18,
                                color: Colors.white70,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            child: MainButton(
              color: AppColors.white,
              onPressed: () => _launchUrl('https://wa.link/bvaw3f'),
              verticalPadding: 16,
              horizontalPadding: 32,
              child: const MainText.title(
                'استشرنا الآن لاختيار السيرفر المثالي',
                color: AppColors.main,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalTransformationSection(
      BuildContext context, bool isMobile) {
    final benefits = [
      DigitalBenefit(
        title: 'زيادة الكفاءة',
        description: 'أتمتة العمليات اليومية لتوفير الوقت والجهد.',
        icon: Icons.settings, // ⚙️
      ),
      DigitalBenefit(
        title: 'جذب عملاء جدد',
        description: 'التواجد الرقمي يوسع قاعدة العملاء.',
        icon: Icons.language, // 🌐
      ),
      DigitalBenefit(
        title: 'تحسين تجربة العملاء',
        description: 'تطبيقات سهلة الاستخدام تعزز رضا العملاء.',
        icon: Icons.sentiment_satisfied, // 😊
      ),
      DigitalBenefit(
        title: 'تقليل التكاليف',
        description: 'الحلول التقنية تقلل من التكاليف على المدى الطويل.',
        icon: Icons.money_off, // 💸
      ),
      DigitalBenefit(
        title: 'البقاء في صدارة المنافسة',
        description: 'التحول الرقمي يجعلك متميزًا عن المنافسين.',
        icon: Icons.emoji_events, // 🏆
      ),
    ];

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'لماذا تحتاج إلى التحول الرقمي؟',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          StaggeredGrid.count(
            crossAxisCount: isMobile ? 1 : 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: benefits.asMap().entries.map((entry) {
              final index = entry.key;
              final benefit = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        benefit.icon,
                        size: 40,
                        color: Colors.teal,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        benefit.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        benefit.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Stats Section
  Widget _buildStatsSection(BuildContext context, bool isMobile) {
    final stats = [
      Stat(label: 'مشاريع مكتملة', value: 14),
      Stat(label: 'سنوات الخبرة', value: 3),
      Stat(label: 'أعضاء الفريق', value: 7),
      Stat(label: 'عملاء سعداء', value: 9),
    ];

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
              'إحصائيات فريقنا',
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
            crossAxisCount: isMobile ? 2 : 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: stats.asMap().entries.map((entry) {
              final index = entry.key;
              final stat = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Countup(
                        begin: 0,
                        end: stat.value.toDouble(),
                        duration: const Duration(seconds: 2),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        stat.label,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Testimonials Section
  Widget _buildTestimonialsSection(BuildContext context, bool isMobile) {
    final testimonials = [
      Testimonial(
        name: 'دعاية | DIEAYA',
        comment:
            'تم تنفيذ تطبيق يلبي خدمات شركتي لتقديم خدمات التصميم من قبل المهندس عبدالله حماد والتيم التقني المتميز ',
        image: AppStrings.dieayaicon,
      ),
      Testimonial(
        name: 'السوق العربي',
        comment:
            'تم تنفيذ تطبيق السوق العربي لتسهيل عمليه البيع والشراء الالكتروني داخل الاردن واتوجه له بالشكر على الاداء الرائع ',
        image: AppStrings.arabicon,
      ),
      Testimonial(
        name: 'توب تن',
        comment:
            'تم تلبية احتياج شركتي في انشاء تطبيق يعرض منتجات الشركه من ملابس ومستحضرات تجميل ويرجع الفضل للمهندس عبدالله والتيم التقني المميز',
        image: AppStrings.tobtenicon,
      ),
    ];

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'ماذا يقول العملاء عن خدماتنا؟',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          CarouselSlider(
            options: CarouselOptions(
              height: isMobile ? 220 : 250,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: isMobile ? 0.9 : 0.4,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            items: testimonials.map((testimonial) {
              return FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: _TestimonialCard(
                    testimonial: testimonial, isMobile: isMobile),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Contact Section
  Widget _buildContactSection(BuildContext context, bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
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
            'تواصل معنا الآن',
            style: TextStyle(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Text(
            'هل لديك فكرة مشروع؟ أرسل رسالتك وسنتواصل معك في أقرب وقت!',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.white70,
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
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'البريد الإلكتروني',
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: messageController,
            decoration: InputDecoration(
              hintText: 'رسالتك',
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            maxLines: 4,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),
          MainButton(
            color: AppColors.white,
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
            verticalPadding: 16,
            horizontalPadding: 32,
            child: const MainText.title(
              'إرسال الرسالة',
              color: AppColors.main,
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
                  url: 'https://wa.link/bvaw3f',
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
class Service {
  final String title;
  final String description;
  final IconData icon;
  final List<Tool> tools;

  Service({
    required this.title,
    required this.description,
    required this.icon,
    required this.tools,
  });
}

class Tool {
  final String name;
  final IconData icon;

  Tool({required this.name, required this.icon});
}

class Benefit {
  final String title;
  final String description;
  final IconData icon;

  Benefit({required this.title, required this.description, required this.icon});
}

class Stat {
  final String label;
  final int value;

  Stat({required this.label, required this.value});
}

class Testimonial {
  final String name;
  final String comment;
  final String image;

  Testimonial({required this.name, required this.comment, required this.image});
}

// Widgets
class _ServiceCard extends StatelessWidget {
  final Service service;
  final bool isMobile;

  const _ServiceCard({required this.service, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            service.icon,
            size: 40,
            color: Colors.teal,
          ),
          const SizedBox(height: 16),
          Text(
            service.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            service.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            textDirection: TextDirection.rtl,
            children: service.tools.map((tool) {
              return Chip(
                avatar: Icon(
                  tool.icon,
                  size: 18,
                  color: Colors.teal,
                ),
                label: Text(
                  tool.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                backgroundColor: Colors.teal.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final Benefit benefit;
  final bool isMobile;

  const _BenefitCard({required this.benefit, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            benefit.icon,
            size: 40,
            color: Colors.teal,
          ),
          const SizedBox(height: 16),
          Text(
            benefit.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            benefit.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;
  final bool isMobile;

  const _TestimonialCard({required this.testimonial, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: testimonial.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            testimonial.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            testimonial.comment,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}

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
                  ? AppColors.white
                  : null,
              colorBlendMode: isHovered ? BlendMode.modulate : null,
            ),
          ),
        ),
      ),
    );
  }
}

// Data Class for Server Steps
class ServerStep {
  final String title;
  final String description;
  final IconData icon;

  ServerStep({
    required this.title,
    required this.description,
    required this.icon,
  });
} // Data Class for Project Steps

class ProjectStep {
  final String title;
  final String description;
  final IconData icon;

  ProjectStep({
    required this.title,
    required this.description,
    required this.icon,
  });
} // Data Class for Digital Benefits

class DigitalBenefit {
  final String title;
  final String description;
  final IconData icon;

  DigitalBenefit({
    required this.title,
    required this.description,
    required this.icon,
  });
}
