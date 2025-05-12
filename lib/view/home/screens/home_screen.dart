import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:countup/countup.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // لعرض IFrame على الويب
import 'package:my_web_app/core/utilities/app_color.dart';
import 'package:my_web_app/core/utilities/app_strings.dart';
import 'package:my_web_app/core/utilities/widget/main_button.dart';
import 'package:my_web_app/core/utilities/widget/main_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              _buildAboutSection(context, isMobile),
              _buildSkillsSection(context, isMobile),
              _buildVideoSection1(context, isMobile),
              _buildProjectsSection(context, isMobile),
              _buildStatsSection(context, isMobile),
              _buildTestimonialsSection(context, isMobile),
              _buildVideoSection2(context, isMobile),
              _buildServicesSection(context, isMobile),
              _buildBlogSection(context, isMobile),
              _buildFaqSection(context, isMobile),
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
    final isHomePage = currentRoute == '/home';
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
                if (isHomePage) {
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
          // Parallax Effect
          AnimatedBuilder(
            animation: _scrollController,
            builder: (context, child) {
              double offset = _scrollController.hasClients
                  ? _scrollController.offset * 0.3
                  : 0.0;
              return Transform.translate(
                offset: Offset(0, offset),
                child: child,
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppStrings.hero),
                  fit: BoxFit.cover,
                ),
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
                  'حول أفكارك إلى واقع رقمي مذهل!',
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
                  'مع عبدالله حماد، صمم تطبيقات احترافية تلبي طموحاتك',
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
                    Navigator.pushNamed(context, '/contact');
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
                    'ابدأ مشروعك الآن',
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

  // About Section
  Widget _buildAboutSection(BuildContext context, bool isMobile) {
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
                _buildAboutImage(isMobile),
                const SizedBox(height: 24),
                _buildAboutContent(context, isMobile),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Flexible(flex: 4, child: _buildAboutImage(isMobile)),
                const SizedBox(width: 32),
                Flexible(flex: 6, child: _buildAboutContent(context, isMobile)),
              ],
            ),
    );
  }

  Widget _buildAboutImage(bool isMobile) {
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

  Widget _buildAboutContent(BuildContext context, bool isMobile) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            'من أنا؟',
            style: TextStyle(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isMobile
                ? 'أنا عبدالله حماد، مهندس برمجيات متخصص في تطوير البرمجيات باستخدام Flutter. لدي خبرة واسعة في تنفيذ وإطلاق مشاريع متكاملة منشورة على Google Play , App Store'
                : 'أنا عبدالله حماد، مهندس برمجيات متخصص في تطوير البرمجيات باستخدام Flutter. لدي خبرة واسعة في تنفيذ وإطلاق مشاريع متكاملة منشورة على Google Play , App Store أتمتع بالقدرة على إدارة دورة حياة المشروع كاملة، بدءًا من الفكرة ووصولًا إلى منتج نهائي متكامل يحقق الأهداف المرجوة ويقدّم حلًا فعّالًا',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.black87,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),
          MainButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            verticalPadding: 12,
            horizontalPadding: 24,
            child: const MainText.title(
              'تعرف عليّ أكثر',
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Skills Section
  Widget _buildSkillsSection(BuildContext context, bool isMobile) {
    final skills = [
      Skill(
          name: 'Flutter',
          percent: 0.9,
          icon: 'https://img.icons8.com/color/48/000000/flutter.png'),
      Skill(
          name: 'Dart',
          percent: 0.9,
          icon: 'https://img.icons8.com/color/48/000000/dart.png'),
      Skill(
          name: 'REST API',
          percent: 0.75,
          icon: 'https://img.icons8.com/color/48/000000/api.png'),
      Skill(
          name: 'Project Management',
          percent: 0.85,
          icon:
              'https://img.icons8.com/color/48/000000/project-management.png'),
      Skill(
          name: 'Git',
          percent: 0.9,
          icon: 'https://img.icons8.com/color/48/000000/git.png'),
      Skill(
          name: 'Problem Solving',
          percent: 0.75,
          icon: 'https://img.icons8.com/color/48/000000/puzzle.png'),
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
              'مهاراتي التقنية',
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

  // Video Section 1 (Why Choose Flutter)
  Widget _buildVideoSection1(BuildContext context, bool isMobile) {
    return _buildVideoSection(
      context: context,
      isMobile: isMobile,
      title: 'لماذا تختار Flutter؟',
      videoUrl: 'https://www.youtube.com/watch?v=5F-6n_2XWR8',
      description:
          'اكتشف لماذا يعتبر Flutter الخيار الأمثل لتطوير تطبيقات موبايل متجاوبة بسرعة وكفاءة :\n- أداء عالي\n- واجهات مستخدم جذابة\n- دعم متعدد المنصات android , ios \n- سهولة التكامل مع الخدمات الخارجية ',
    );
  }

  // Video Section 2 (Technical Video)
  Widget _buildVideoSection2(BuildContext context, bool isMobile) {
    return _buildVideoSection(
      context: context,
      isMobile: isMobile,
      title: 'أفضل الممارسات لإدارة المشاريع التقنية بكفاءة',
      videoUrl: 'https://www.youtube.com/watch?v=9LSnINglkQA',
      description:
          'تعلم كيف تدير مشاريعك التقنية باحترافية من خلال أفضل الممارسات :\n- التخطيط الفعال للمشروع\n- استخدام أدوات إدارة المشاريع\n- التعامل مع التحديات الشائعة.',
    );
  }

  // Generic Video Section Builder
  Widget _buildVideoSection({
    required BuildContext context,
    required bool isMobile,
    required String title,
    required String videoUrl,
    required String description,
  }) {
    final controller = kIsWeb
        ? null
        : YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              enableCaption: true,
              showLiveFullscreenButton: false,
              forceHD: false,
              useHybridComposition: true,
              loop: false,
            ),
          );

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVideoContent(context, controller, isMobile, videoUrl),
                const SizedBox(height: 24),
                _buildTextContent(context, title, description, isMobile),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildVideoContent(
                      context, controller, isMobile, videoUrl),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 4,
                  child:
                      _buildTextContent(context, title, description, isMobile),
                ),
              ],
            ),
    );
  }

  Widget _buildVideoContent(BuildContext context,
      YoutubePlayerController? controller, bool isMobile, String videoUrl) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              height: isMobile ? 200 : 300,
              child: kIsWeb
                  ? _buildWebContent(context, videoUrl, isMobile)
                  : _buildPlayerContent(
                      context, controller!, isMobile, videoUrl),
            ),
          ),
          if (!kIsWeb) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (controller.value.isReady) {
                  if (controller.value.isPlaying) {
                    controller.pause();
                    debugPrint('Video Paused');
                  } else {
                    controller.play();
                    debugPrint('Video Playing');
                  }
                } else {
                  debugPrint('Controller not ready, opening video in browser');
                  _launchUrl(videoUrl);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                controller!.value.isPlaying ? 'إيقاف' : 'تشغيل',
                style: const TextStyle(fontSize: 16),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWebContent(
      BuildContext context, String videoUrl, bool isMobile) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
    final embedUrl =
        'https://www.youtube.com/embed/$videoId?controls=1&autoplay=0&rel=0&showinfo=0&fs=1';

    debugPrint('Loading YouTube video for Web: $embedUrl');

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(embedUrl)),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        useWideViewPort: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone; fullscreen",
        iframeAllowFullscreen: true,
      ),
      onLoadStart: (controller, url) {
        debugPrint('WebView started loading: $url');
      },
      onLoadStop: (controller, url) {
        debugPrint('WebView finished loading: $url');
      },
      onLoadError: (controller, url, code, message) {
        debugPrint('WebView load error: $code, $message');
        _launchUrl(videoUrl);
      },
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint('WebView console: ${consoleMessage.message}');
      },
    );
  }

  Widget _buildPlayerContent(BuildContext context,
      YoutubePlayerController controller, bool isMobile, String videoUrl) {
    debugPrint('Using YouTube player for mobile: $videoUrl');
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.teal,
        progressColors: const ProgressBarColors(
          playedColor: Colors.teal,
          handleColor: Colors.tealAccent,
        ),
        onReady: () {
          debugPrint('YouTube Player Ready: $videoUrl');
          controller.addListener(() {
            debugPrint(
                'Player State: ${controller.value.playerState}, IsReady: ${controller.value.isReady}, Error: ${controller.value.errorCode}');
          });
        },
        onEnded: (metaData) {
          debugPrint('Video Ended: ${metaData.title}');
        },
      ),
      builder: (context, player) => Stack(
        alignment: Alignment.center,
        children: [
          player,
          if (!controller.value.isReady)
            GestureDetector(
              onTap: () {
                debugPrint('Opening video in browser: $videoUrl');
                _launchUrl(videoUrl);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: YoutubePlayer.getThumbnail(
                        videoId: YoutubePlayer.convertUrlToId(videoUrl) ?? ''),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: isMobile ? 200 : 300,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextContent(
      BuildContext context, String title, String description, bool isMobile) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.black87,
              height: 1.5,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  // Projects Section
  Widget _buildProjectsSection(BuildContext context, bool isMobile) {
    final projects = [
      Project(
        title: 'DIEAYA | دعاية',
        description: 'تطبيق تجارة إلكترونية لبيع مستلزمات الديكور والتصاميم.',
        image: AppStrings.dIEAYA_1,
        url:
            'https://play.google.com/store/apps/details?id=com.digiplus.printing',
        category: 'Mobile',
      ),
      Project(
        title: 'Osool | أصول',
        description:
            'تطبيق للعقارات حيث يمكنك شراء العقارات والتحدث للبائع من خلال التطبيق مباشرا.',
        image: AppStrings.osool_1,
        url: 'https://github.com/AbdallahHammad22',
        category: 'Mobile',
      ),
      Project(
        title: 'Admin Panel | لوحة التحكم',
        description:
            'لوحة تحكم مميزة تجمع بين الحداثة في المظهر والميزات الكثيرة.',
        image: AppStrings.adminPanel,
        url: 'https://github.com/AbdallahHammad22',
        category: 'Web',
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
              'أعمالي المميزة',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          StaggeredGrid.count(
            crossAxisCount: isMobile ? 1 : 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: projects.asMap().entries.map((entry) {
              final index = entry.key;
              final project = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: _ProjectCard(
                  project: project,
                  onTap: () => _launchUrl(project.url),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: MainButton(
              color: AppColors.white,
              onPressed: () => Navigator.pushNamed(context, '/projects'),
              verticalPadding: 16,
              horizontalPadding: 32,
              child: const MainText.title(
                'استعرض جميع الأعمال',
                color: AppColors.main,
              ),
            ),
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
      Stat(label: 'عملاء سعداء', value: 9),
      Stat(label: 'دول', value: 5),
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
              'ماذا يقول العملاء؟',
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
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

  // Services Section
  Widget _buildServicesSection(BuildContext context, bool isMobile) {
    final services = [
      Service(
        title: 'تطوير تطبيقات الموبايل',
        description: 'تصميم وتطوير تطبيقات موبايل متجاوبة باستخدام Flutter.',
        icon: Icons.phone_android,
      ),
      Service(
        title: 'تطوير تطبيقات الويب',
        description: 'بناء تطبيقات ويب  بأداء عالي بستخدام Angular,React',
        icon: Icons.web,
      ),
      Service(
        title: 'تصميم UI/UX',
        description: 'تصميم واجهات مستخدم جذابة وسهلة الاستخدام.',
        icon: Icons.design_services,
      ),
      Service(
        title: 'استشارات تقنية',
        description: 'تقديم حلول تقنية مخصصة لتلبية احتياجات عملك.',
        icon: Icons.lightbulb_outline,
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
              'خدماتي المميزة',
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
          const SizedBox(height: 32),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: MainButton(
              color: AppColors.white,
              onPressed: () => Navigator.pushNamed(context, '/services'),
              verticalPadding: 16,
              horizontalPadding: 32,
              child: const MainText.title(
                'استعرض جميع الخدمات',
                color: AppColors.main,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Blog Section
  Widget _buildBlogSection(BuildContext context, bool isMobile) {
    final blogs = [
      Blog(
        title: 'هل مشروعك البرمجي جاهز للنمو أم أنه سيواجه التحديات قريبًا؟',
        excerpt:
            'اكتشف كيف تتأكد من جاهزية مشروعك للتوسع وتجنب التحديات المستقبلية.',
        image: AppStrings.articl_1,
        url: 'https://www.facebook.com/share/p/1AfoT99V5K/',
      ),
      Blog(
        title: 'كيف تصيغ متطلبات مشروعك البرمجي بشكل صحيح لضمان تنفيذ دقيق؟',
        excerpt: 'تعلم كيفية كتابة متطلبات واضحة تضمن نجاح تنفيذ مشروعك.',
        image: AppStrings.articl_2,
        url: 'https://www.facebook.com/share/p/19Fyr4UMKQ/',
      ),
      Blog(
        title: 'التطبيقات: أداة أساسية لتوسيع نشاطك وزيادة مبيعاتك!',
        excerpt: 'اعرف كيف تساعد التطبيقات في تنمية أعمالك وتعزيز مبيعاتك.',
        image: AppStrings.articl_3,
        url: 'https://www.facebook.com/share/p/19ttR26v8v/',
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
              'آخر المقالات التقنية',
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
            children: blogs.asMap().entries.map((entry) {
              final index = entry.key;
              final blog = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: _BlogCard(blog: blog, onTap: () => _launchUrl(blog.url)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // FAQ Section
  Widget _buildFaqSection(BuildContext context, bool isMobile) {
    final faqs = [
      Faq(
        question: 'ما هي مدة تطوير تطبيق موبايل؟',
        answer:
            'تعتمد المدة على تعقيد التطبيق ومتطلبات المشروع ، لكن متوسط التطبيقات يستغرق من 2 إلى 6 أشهر.',
      ),
      Faq(
        question: 'هل تقدم دعمًا بعد التطوير؟',
        answer: 'نعم، أقدم دعمًا فنيًا وصيانة لمدة 1-2 أشهر بعد إطلاق التطبيق.',
      ),
      Faq(
        question: 'هل يمكنني تخصيص تصميم التطبيق ؟',
        answer: 'بالتأكيد! أعمل معك لتصميم واجهات مستخدم تلبي رؤيتك.',
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Text(
                'الأسئلة الشائعة',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 24),
            ...faqs.asMap().entries.map((entry) {
              final index = entry.key;
              final faq = entry.value;
              return FadeInUp(
                duration: Duration(milliseconds: 800 + index * 200),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                      tapBodyToExpand: true,
                      hasIcon: true,
                      iconColor: Colors.teal,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        faq.question,
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    collapsed: const SizedBox.shrink(),
                    expanded: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            faq.answer,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.black87,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
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
            'هل لديك فكرة مشروع؟ أرسل رسالتك وسأتواصل معك في أقرب وقت!',
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
class Skill {
  final String name;
  final double percent;
  final String icon;

  Skill({required this.name, required this.percent, required this.icon});
}

class Project {
  final String title;
  final String description;
  final String image;
  final String url;
  final String category;

  Project({
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.category,
  });
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

class Service {
  final String title;
  final String description;
  final IconData icon;

  Service({required this.title, required this.description, required this.icon});
}

class Blog {
  final String title;
  final String excerpt;
  final String image;
  final String url;

  Blog(
      {required this.title,
      required this.excerpt,
      required this.image,
      required this.url});
}

class Faq {
  final String question;
  final String answer;

  Faq({required this.question, required this.answer});
}

// Widgets
class _SkillCard extends StatelessWidget {
  final Skill skill;
  final bool isMobile;

  const _SkillCard({required this.skill, required this.isMobile});

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
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          CachedNetworkImage(
            imageUrl: skill.icon,
            width: 40,
            height: 40,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  skill.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                LinearPercentIndicator(
                  percent: skill.percent,
                  lineHeight: 8,
                  progressColor: Colors.teal,
                  backgroundColor: Colors.grey.shade200,
                  barRadius: const Radius.circular(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback onTap;

  const _ProjectCard({required this.project, required this.onTap});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isHovered ? 0.2 : 0.1),
                blurRadius: isHovered ? 12 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: widget.project.image,
                  height: 150,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'التصنيف: ${widget.project.category}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          ),
        ],
      ),
    );
  }
}

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
          ),
          const SizedBox(height: 8),
          Text(
            service.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;

  const _BlogCard({required this.blog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: blog.image,
              height: 150,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  blog.excerpt,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 16),
                MainButton(
                  onPressed: onTap,
                  verticalPadding: 8,
                  horizontalPadding: 16,
                  child: const MainText.title(
                    'اقرأ المزيد',
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
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
