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
import 'package:my_web_app/core/extensions/assetss_widgets.dart';
import 'package:my_web_app/core/utilities/app_color.dart';
import 'package:my_web_app/core/utilities/app_strings.dart';
import 'package:my_web_app/core/utilities/const_data.dart';
import 'package:my_web_app/core/utilities/widget/main_button.dart';
import 'package:my_web_app/core/utilities/widget/main_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      appBar: _buildAppBar(context, isMobile),
      drawer: isMobile ? _buildDrawer(context) : null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueGrey],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
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
  AppBar _buildAppBar(BuildContext context, bool isMobile) {
    return AppBar(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      title: const Text('Abdallah Hammad'),
      actions: isMobile
          ? []
          : [
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
    );
  }

  // Drawer
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Text(
              'عبدالله حماد\nمهندس برمجيات',
              style: TextStyle(color: Colors.white, fontSize: 24),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            title: const Text('الرئيسية', textDirection: TextDirection.rtl),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            title: const Text('نبذة عني', textDirection: TextDirection.rtl),
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          ListTile(
            title: const Text('أعمالي', textDirection: TextDirection.rtl),
            onTap: () => Navigator.pushNamed(context, '/projects'),
          ),
          ListTile(
            title: const Text('الخدمات', textDirection: TextDirection.rtl),
            onTap: () => Navigator.pushNamed(context, '/services'),
          ),
          ListTile(
            title: const Text('آراء العملاء', textDirection: TextDirection.rtl),
            onTap: () => Navigator.pushNamed(context, '/testimonials'),
          ),
          ListTile(
            title: const Text('تواصل معي', textDirection: TextDirection.rtl),
            onTap: () => Navigator.pushNamed(context, '/contact'),
          ),
        ],
      ),
    );
  }

  // Hero Section
  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      height: isMobile ? 600 : 800,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1516321310762-4794377e6a87?auto=format&fit=crop&w=1920&q=80'),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZoomIn(
              duration: const Duration(milliseconds: 1000),
              child: Text(
                'مرحبًا بكم في عالمي الرقمي',
                style: TextStyle(
                  fontSize: isMobile ? 36 : 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: Text(
                'عبدالله حماد - مطور Flutter محترف يحول أفكارك إلى تطبيقات مذهلة',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 24,
                  color: Colors.white70,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 1400),
              child: MainButton(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                verticalPadding: 16,
                horizontalPadding: 32,
                child: const MainText.title(
                  'ابدأ مشروعك الآن',
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
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
        child: CachedNetworkImage(
          imageUrl:
              'https://images.unsplash.com/photo-1507238691744-903d9b463188?auto=format&fit=crop&w=800&q=80',
          height: isMobile ? 200 : 300,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context, bool isMobile) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
        children: [
          Text(
            'من أنا؟',
            style: TextStyle(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Text(
            'أنا عبدالله حماد، مطور Flutter بخبرة تزيد عن 3 سنوات. أتخصص في بناء تطبيقات موبايل وويب متجاوبة باستخدام أحدث التقنيات. هدفي هو تقديم حلول رقمية مبتكرة تلبي احتياجات العملاء بتصاميم أنيقة وأداء عالي.',
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
      Skill(name: 'Flutter', percent: 0.9, icon: 'https://img.icons8.com/color/48/000000/flutter.png'),
      Skill(name: 'Dart', percent: 0.85, icon: 'https://img.icons8.com/color/48/000000/dart.png'),
      Skill(name: 'Firebase', percent: 0.75, icon: 'https://img.icons8.com/color/48/000000/firebase.png'),
      Skill(name: 'UI/UX Design', percent: 0.8, icon: 'https://img.icons8.com/color/48/000000/figma.png'),
      Skill(name: 'REST API', percent: 0.7, icon: 'https://img.icons8.com/color/48/000000/api.png'),
      Skill(name: 'Git', percent: 0.85, icon: 'https://img.icons8.com/color/48/000000/git.png'),
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
      videoUrl: 'https://www.youtube.com/watch?v=1ukSR1GRtMU',
      description:
          'اكتشف لماذا يعتبر Flutter الخيار الأمثل لتطوير تطبيقات موبايل وويب متجاوبة بسرعة وكفاءة:\n- أداء عالي\n- واجهات مستخدم جذابة\n- دعم متعدد المنصات.',
    );
  }

  // Video Section 2 (Technical Video)
  Widget _buildVideoSection2(BuildContext context, bool isMobile) {
    return _buildVideoSection(
      context: context,
      isMobile: isMobile,
      title: 'بناء API مع Flutter',
      videoUrl: 'https://www.youtube.com/watch?v=1ukSR1GRtMU',
      description:
          'تعلم كيفية إنشاء ودمج واجهات برمجة التطبيقات (API) في تطبيقات Flutter لتحسين الأداء:\n- تصميم API فعال\n- التكامل مع Backend\n- تحسين الأداء.',
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
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: [
                _buildVideoContent(context, controller, isMobile, videoUrl),
                const SizedBox(height: 24),
                _buildTextContent(context, title, description, isMobile),
              ],
            )
          : Row(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildVideoContent(context, controller, isMobile, videoUrl),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 4,
                  child: _buildTextContent(context, title, description, isMobile),
                ),
              ],
            ),
    );
  }

  // Video Content (InAppWebView for Web, Player for Mobile)
  Widget _buildVideoContent(
      BuildContext context, YoutubePlayerController? controller, bool isMobile, String videoUrl) {
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
                  : _buildPlayerContent(context, controller!, isMobile, videoUrl),
            ),
          ),
          if (!kIsWeb) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (controller!.value.isReady) {
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  // Web Content using InAppWebView
  Widget _buildWebContent(BuildContext context, String videoUrl, bool isMobile) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
    final embedUrl = 'https://www.youtube.com/embed/$videoId?controls=1&autoplay=0&rel=0&showinfo=0&fs=1';

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
        _launchUrl(videoUrl); // Fallback to browser if loading fails
      },
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint('WebView console: ${consoleMessage.message}');
      },
    );
  }

  // Player Content for Mobile
  Widget _buildPlayerContent(
      BuildContext context, YoutubePlayerController controller, bool isMobile, String videoUrl) {
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
                    imageUrl:
                        YoutubePlayer.getThumbnail(videoId: YoutubePlayer.convertUrlToId(videoUrl) ?? ''),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: isMobile ? 200 : 300,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
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

  // Text Content (Title and Description)
  Widget _buildTextContent(
      BuildContext context, String title, String description, bool isMobile) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
        title: 'تطبيق التجارة الإلكترونية',
        description: 'تطبيق موبايل متكامل للتسوق عبر الإنترنت مع دفع آمن.',
        image: 'https://images.unsplash.com/photo-1556740738-6bf2b8b9e7b9?auto=format&fit=crop&w=800&q=80',
        url: 'https://example.com/project1',
        category: 'Mobile',
      ),
      Project(
        title: 'لوحة تحكم إدارية',
        description: 'نظام ويب لإدارة الأعمال بسهولة وكفاءة.',
        image: 'https://images.unsplash.com/photo-1516321310762-4794377e6a87?auto=format&fit=crop&w=800&q=80',
        url: 'https://example.com/project2',
        category: 'Web',
      ),
      Project(
        title: 'تطبيق اللياقة',
        description: 'تطبيق موبايل لتتبع التمارين الرياضية وخطط التغذية.',
        image: 'https://images.unsplash.com/photo-1517832207067-4db24a2ae47c?auto=format&fit=crop&w=800&q=80',
        url: 'https://example.com/project3',
        category: 'Mobile',
      ),
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
              textDirection: TextDirection.rtl,
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
              onPressed: () => Navigator.pushNamed(context, '/projects'),
              verticalPadding: 16,
              horizontalPadding: 32,
              child: const MainText.title(
                'استعرض جميع الأعمال',
                color: AppColors.white,
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
      Stat(label: 'مشاريع مكتملة', value: 25),
      Stat(label: 'سنوات الخبرة', value: 3),
      Stat(label: 'عملاء سعداء', value: 15),
      Stat(label: 'أكواب قهوة', value: 999),
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1516321310762-4794377e6a87?auto=format&fit=crop&w=1920&q=80'),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
        comment: 'عبدالله مطور رائع! أنجز مشروعي بسرعة واحترافية.',
        image: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
      ),
      Testimonial(
        name: 'سارة أحمد',
        comment: 'التطبيق اللي صممه عبدالله فاق توقعاتي، تجربة مستخدم ممتازة!',
        image: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
      ),
      Testimonial(
        name: 'خالد محمود',
        comment: 'تعاملت مع عبدالله في مشروع ويب، وكان التنفيذ مثالي.',
        image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 24),
          CarouselSlider(
            options: CarouselOptions(
              height: isMobile ? 300 : 350,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: isMobile ? 0.9 : 0.4,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            items: testimonials.map((testimonial) {
              return FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: _TestimonialCard(testimonial: testimonial, isMobile: isMobile),
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
        description: 'بناء تطبيقات ويب ديناميكية بأداء عالي.',
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
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
              onPressed: () => Navigator.pushNamed(context, '/services'),
              verticalPadding: 16,
              horizontalPadding: 32,
              child: const MainText.title(
                'استعرض جميع الخدمات',
                color: AppColors.white,
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
        title: 'كيفية بناء تطبيق Flutter متجاوب',
        excerpt: 'تعلم أفضل الممارسات لتطوير تطبيقات Flutter تدعم جميع الأجهزة.',
        image: 'https://images.unsplash.com/photo-1516321310762-4794377e6a87?auto=format&fit=crop&w=800&q=80',
        url: 'https://example.com/blog1',
      ),
      Blog(
        title: 'مقدمة عن Firebase للمبتدئين',
        excerpt: 'اكتشف كيف يمكن لـ Firebase تسريع تطوير تطبيقاتك.',
        image: 'https://images.unsplash.com/photo-1517832207067-4db24a2ae47c?auto=format&fit=crop&w=800&q=80',
        url: 'https://example.com/blog2',
      ),
      Blog(
        title: 'أفضل أدوات تصميم UI/UX لعام 2025',
        excerpt: 'استعراض لأحدث أدوات تصميم واجهات المستخدم.',
        image: 'https://images.unsplash.com/photo-1556740738-6bf2b8b9e7b9?auto=format&fit=crop&w=800&q=80',
        url: 'https://example.com/blog3',
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
        answer: 'تعتمد المدة على تعقيد التطبيق، لكن متوسط التطبيقات يستغرق من 2 إلى 6 أشهر.',
      ),
      Faq(
        question: 'هل تقدم دعمًا بعد التطوير؟',
        answer: 'نعم، أقدم دعمًا فنيًا وصيانة لمدة 3-6 أشهر بعد إطلاق التطبيق.',
      ),
      Faq(
        question: 'هل يمكنني تخصيص تصميم التطبيق؟',
        answer: 'بالتأكيد! أعمل معك لتصميم واجهات مستخدم تلبي رؤيتك.',
      ),
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
                    ),
                  ),
                  collapsed: const SizedBox.shrink(),
                  expanded: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      faq.answer,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
            );
          }),
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
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
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
            decoration: InputDecoration(
              labelText: 'الاسم',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'رسالتك',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            maxLines: 4,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),
          MainButton(
            onPressed: () {
              // Implement form submission logic
            },
            verticalPadding: 16,
            horizontalPadding: 32,
            child: const MainText.title(
              'إرسال الرسالة',
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
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
        child: CachedNetworkImage(
          imageUrl:
              'https://images.unsplash.com/photo-1516321310762-4794377e6a87?auto=format&fit=crop&w=800&q=80',
          height: isMobile ? 200 : 300,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
                child: const Text('الرئيسية', style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                child: const Text('نبذة عني', style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/projects'),
                child: const Text('أعمالي', style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/services'),
                child: const Text('الخدمات', style: TextStyle(color: Colors.white70)),
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

  Blog({required this.title, required this.excerpt, required this.image, required this.url});
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
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: widget.project.image,
                  height: 150,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'التصنيف: ${widget.project.category}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textDirection: TextDirection.rtl,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
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
            textDirection: TextDirection.rtl,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
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
            ),
            textDirection: TextDirection.rtl,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: blog.image,
              height: 150,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Text(
                  blog.excerpt,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
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

// Social Icon Widget
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