import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_web_app/core/utilities/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
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
              'https://wa.me/+201234567890'); // Replace with your WhatsApp link
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
              _buildProfessionalJourneySection(context, isMobile),
              _buildEducationSection(context, isMobile),
              _buildSkillsSection(context, isMobile),
              _buildLanguagesSection(context, isMobile),
              _buildExperienceBenefitsSection(context, isMobile),
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
    final isAboutPage = currentRoute == '/about';
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
                if (isAboutPage) {
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
    return SizedBox(
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
                  'نبذة عن عبدالله حماد',
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
                  'مطور Flutter |   متخصص في بناء تطبيقات عالية الأداء',
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
                        'https://wa.me/+201234567890'); // Replace with your WhatsApp link
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
                    'تواصل معي الآن',
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

  // Professional Journey Section (Similar to Services Section)
  Widget _buildProfessionalJourneySection(BuildContext context, bool isMobile) {
    final experiences = [
      Experience(
        title: 'تقنية لتكنولوجيا المعلومات',
        description:
            'أغسطس 2023 - أكتوبر 2023\n- تطوير مكونات واجهة مستخدم لتطبيق عقاري.\n- تحسين أداء التطبيق وإصلاح الأخطاء.',
        icon: Icons.work,
        tools: [
          Tool(name: 'Flutter', icon: Icons.developer_mode),
          Tool(name: 'Ui Implementation', icon: Icons.design_services),
          Tool(name: 'Problem Solving', icon: Icons.bug_report),
        ],
      ),
      Experience(
        title: 'مطور مستقل (Freelancer)',
        description:
            'يناير 2024 - الآن\n- دعاية : منصة تجارة إلكترونية لخدمات التصميم الرقمي\n- توب تن : تطبيق تابع لسلسلة براند توب تن داخل السعودية\n- الدواء : تطبيق لصيدليات الدواء النموذجية داخل السعودية\n- السوق العربي : سوق بيع وشراء الكتروني داخل الأردن\n- الخيال : تطبيق تجاري و استكشاف المملكة العربية السعودية ',
        icon: Icons.work,
        tools: [
          Tool(name: 'Project Management', icon: Icons.manage_accounts),
          Tool(name: 'Time Management', icon: Icons.timelapse),
          Tool(name: 'Clickup', icon: Icons.ads_click),
          Tool(name: 'Team Management', icon: Icons.people),
          Tool(name: 'Mobile Development', icon: Icons.mobile_friendly),
        ],
      ),
      Experience(
        title: 'Goaluin',
        description:
            'يونيو 2023 - نوفمبر 2023\n- المساهمة في تطوير ت إدارة المطاعم.\n- تحسين قابلية التوسع وتحسين كود Flutter.',
        icon: Icons.work,
        tools: [
          Tool(name: 'Flutter', icon: Icons.flutter_dash),
          Tool(name: 'Firebase', icon: Icons.cloud),
          Tool(name: 'StateMangment', icon: Icons.settings),
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
              'رحلتي المهنية',
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
            children: experiences.asMap().entries.map((entry) {
              final index = entry.key;
              final experience = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child:
                    _ExperienceCard(experience: experience, isMobile: isMobile),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Education Section (Similar to Project Lifecycle Section)
  Widget _buildEducationSection(BuildContext context, bool isMobile) {
    final educationSteps = [
      EducationStep(
        title: 'بكالوريوس علوم الحاسب',
        description:
            'جامعة الزقازيق - 2023\nتخرجت بدرجة بكالوريوس في علوم الحاسب، حيث تعلمت أساسيات البرمجة وهياكل البيانات وانظمة التشغيل ',
        icon: Icons.school,
      ),
      EducationStep(
        title: 'الدورات التدريبية',
        description:
            '- The Complete Flutter Development Guide [2022 Edition] | Udemy\n- The Complete 2022 Flutter & Dart Development Course [Arabic] | Udemy\n- Clean Architecture In Flutter 3 (Arabic) | Udemy',
        icon: Icons.book,
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
              'تعليمي ودوراتي',
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
            children: educationSteps.asMap().entries.map((entry) {
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

  // Skills Section (Similar to Why Choose Us Section)
  Widget _buildSkillsSection(BuildContext context, bool isMobile) {
    final skills = [
      Skill(
        title: 'لغات البرمجة',
        description: '++C\n #C\nDart',
        icon: Icons.code,
      ),
      Skill(
        title: 'قواعد البيانات وإطار العمل',
        description: 'Flutter - GetX & Provider\nFirebase - MySQL\nRest API',
        icon: Icons.storage,
      ),
      Skill(
        title: 'مفاهيم عامة',
        description:
            'OOP - Algorithm & Data Structure\nSolid Principles - Git & GitHub\nResponsive design',
        icon: Icons.lightbulb,
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
              'مهاراتي التقنية',
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
            children: skills.asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: _SkillCard(skill: skill, isMobile: isMobile),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Languages Section (Similar to Server Selection Section)
  Widget _buildLanguagesSection(BuildContext context, bool isMobile) {
    final languageSteps = [
      LanguageStep(
        title: 'العربية',
        description: 'اللغة الأم',
        icon: Icons.language,
      ),
      LanguageStep(
        title: 'الإنجليزية',
        description: 'إجادة عملية',
        icon: Icons.language,
      ),
      LanguageStep(
        title: 'المهارات الناعمة',
        description: 'إدارة الوقت - العمل الجماعي - التعلم السريع',
        icon: Icons.people,
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
              'اللغات والمهارات الناعمة',
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
            children: languageSteps.asMap().entries.map((entry) {
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

  // Experience Benefits Section (Similar to Digital Transformation Section)
  Widget _buildExperienceBenefitsSection(BuildContext context, bool isMobile) {
    final benefits = [
      ExperienceBenefit(
        title: 'خبرة متنوعة',
        description:
            'عملت على مشاريع متنوعة تشمل التجارة الإلكترونية - توصيل الطلبات - واسائل دفع متنوعة',
        icon: Icons.star,
      ),
      ExperienceBenefit(
        title: 'تركيز على الأداء',
        description: 'أركز على بناء تطبيقات عالية الأداء وسهلة الاستخدام.',
        icon: Icons.speed,
      ),
      ExperienceBenefit(
        title: 'كود نظيف',
        description: 'أتبع مبادئ الكود النظيف والهندسة القابلة للتطوير.',
        icon: Icons.code,
      ),
      ExperienceBenefit(
        title: 'التعلم المستمر',
        description: 'أواصل تعلم أحدث التقنيات من خلال الدورات والممارسة.',
        icon: Icons.book,
      ),
      ExperienceBenefit(
        title: 'التزام بالمواعيد',
        description: 'ألتزم بتسليم المشاريع في الوقت المحدد.',
        icon: Icons.timer,
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
              'لماذا تختار التعامل معي؟',
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
      Stat(label: 'مشاريع مكتملة', value: 18),
      Stat(label: 'سنوات الخبرة', value: 3),
      Stat(label: 'دورات تدريبية', value: 8),
      Stat(label: 'مهارات تقنية', value: 14),
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
              'إحصائياتي',
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
        name: 'محمد علي',
        comment: 'عبدالله قدم لي تطبيق موبايل رائع بأداء عالٍ وتصميم مميز!',
        image:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
      ),
      Testimonial(
        name: 'سارة أحمد',
        comment: 'سرعة التنفيذ والالتزام بالمواعيد كانا مذهلين!',
        image:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
      ),
      Testimonial(
        name: 'خالد محمود',
        comment: 'تعاملت مع عبدالله في مشروع تجارة إلكترونية، نتيجة مبهرة!',
        image:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
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
              'ماذا يقول العملاء عني؟',
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
            'تواصل معي الآن',
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
            decoration: InputDecoration(
              labelText: 'الاسم',
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني',
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'رسالتك',
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            maxLines: 4,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'إرسال الرسالة',
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal,
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
                      'https://wa.me/+201234567890', // Replace with your WhatsApp link
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
class Experience {
  final String title;
  final String description;
  final IconData icon;
  final List<Tool> tools;

  Experience({
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

class Skill {
  final String title;
  final String description;
  final IconData icon;

  Skill({required this.title, required this.description, required this.icon});
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

class EducationStep {
  final String title;
  final String description;
  final IconData icon;

  EducationStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class LanguageStep {
  final String title;
  final String description;
  final IconData icon;

  LanguageStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ExperienceBenefit {
  final String title;
  final String description;
  final IconData icon;

  ExperienceBenefit({
    required this.title,
    required this.description,
    required this.icon,
  });
}

// Widgets
class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isMobile;

  const _ExperienceCard({required this.experience, required this.isMobile});

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
            experience.icon,
            size: 40,
            color: Colors.teal,
          ),
          const SizedBox(height: 16),
          Text(
            experience.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            experience.description,
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
            children: experience.tools.map((tool) {
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

class _SkillCard extends StatelessWidget {
  final Skill skill;
  final bool isMobile;

  const _SkillCard({required this.skill, required this.isMobile});

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
            skill.icon,
            size: 40,
            color: Colors.teal,
          ),
          const SizedBox(height: 16),
          Text(
            skill.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            skill.description,
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
