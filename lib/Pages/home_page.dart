import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Widgets/contact_section.dart';
import '../Widgets/hero_action.dart';
import '../Widgets/nav_item.dart'; // Ensure this exists or use the NavBar code I gave earlier
import '../Widgets/skills_section.dart';

// --- MODELS ---
class Project {
  final String title;
  final String description;
  final String techStack;
  final String? imagePath;
  Project({required this.title, required this.description, this.imagePath,required this.techStack});
}

// --- DATA ---
List<Project> myProjects = [

  Project(
    title: "Sukhadiya Cateres",
    description: "A comprehensive catering management system for tracking live orders, managing event schedules, and automating client billing and notifications.",
    techStack: "Flutter, Provider, Dart, Rest APIS",
    imagePath: 'assets/images/sukhadiya_p.jpeg'

  ),


  Project(
    title: "SkySnap",
    description: "A minimalist, real-time weather application featuring dynamic animations, location-based 7-day forecasts, and detailed atmospheric data visualization.",
    techStack: "Flutter, OpenWeatherMap API, Geolocator, Lottie",
    imagePath: 'assets/images/skysnap_p.jpeg'
  ),
  Project(title: "ATPT",
      imagePath: 'assets/images/atpt_p.jpeg',
      description: "ATPT (Any Time Party Time) is a fast and convenient food-ordering app designed for party and event catering. It allows users to browse menus, place customized bulk orders, and track inquiries in real time. Built with Flutter, it streamlines the entire party-food ordering workflow for both customers and vendors.",
      techStack: "Flutter,Firebase,API Integration"),

  Project(title: "DreamFirst",
      imagePath: 'assets/images/user_home.jpeg',
      description: "DreamFirst is a Flutter-based mobile news app that delivers real-time news articles and videos with a clean, user-friendly interface.It supports role-based workflows for admins, reporters, and users, enabling efficient content creation, moderation, and publishing.Powered by Firebase, it includes authentication, Firestore database, and push notifications for a secure and scalable experience.",
      techStack: "Flutter, Dart, Firebase (Auth, Firestore, Cloud Functions, FCM), Provider, REST APIs, Netlify, Git/GitHub, AdMob"),
];


List<String> navTitles = ["Home", "Skills", "Projects", "Contact"];

// --- HOME PAGE ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


    final List<GlobalKey> sectionKeys = List.generate(4, (index) => GlobalKey());

    // 2. Scroll Function
    void scrollToSection(int index) {
      if (index < sectionKeys.length && sectionKeys[index].currentContext != null) {
        Scrollable.ensureVisible(
          sectionKeys[index].currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColor.scaffoldBg,
      drawer: MobileDrawer(onNavClick: scrollToSection),
      appBar: AppBar(
        elevation: 0, // ✅ shadow remove
        toolbarHeight: 80,
        backgroundColor: CustomColor.scaffoldBg,
        automaticallyImplyLeading: false,
        titleSpacing: 0,

        title: NavBar(
          scaffoldKey: scaffoldKey,
          onNavClick: scrollToSection,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // 3. Pass keys down to BodySection so it can assign them to widgets
                BodySection(onNavClick:scrollToSection,sectionKeys: sectionKeys),
                const FooterSection(),
              ],
            ),
          ),
          // Floating Navbar
        ],
      ),
    );
  }
}

// --- BODY SECTION ---
class BodySection extends StatelessWidget {
  // Accept keys from parent
  final List<GlobalKey> sectionKeys;
  final Function(int) onNavClick;


  const BodySection({super.key, required this.sectionKeys,required this.onNavClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assign Key 0 -> Home/Hero
              Container(
                  key: sectionKeys[0],
                  child:  HeroSection(
                    onNavClick:onNavClick
                  )
              ),

              const SizedBox(height: 80),

              Container(
                key: sectionKeys[1],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SectionTitle(title: "My Skills"),
                    SizedBox(height: 50),
                    SkillsSection(),
                  ],
                ),
              ),

              const SizedBox(height: 80),

              // Assign Key 2 -> Projects
              Container(
                key: sectionKeys[2],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SectionTitle(title: "Featured Projects"),
                    SizedBox(height: 20),
                    ProjectsSection(),
                  ],
                ),
              ),

              const SizedBox(height: 80),

              // Assign Key 3 -> Contact
              Container(
                  key: sectionKeys[3],
                  child: const ContactSection()
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

// --- HELPERS & SECTIONS ---

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: CustomColor.whitePrimary);
    final textPainter=TextPainter(
      text: TextSpan(text: title, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    final textwidth = textPainter.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: CustomColor.whitePrimary)),
        Container(
            width: textwidth, height: 3,
            margin: const EdgeInsets.only(top: 5),
            color: CustomColor.yellowPrimary
        )
      ],
    );
  }
}


class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int hoveredIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 950; // Adjusted breakdown for vertical image balance

    if (!isDesktop) {
      return buildMobileLayout();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT SIDE: Interactive Project List (Takes 55% space)
        Expanded(
          flex: 11,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(myProjects.length, (index) {
              final project = myProjects[index];
              final isHovered = hoveredIndex == index;

              return MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
                    ),
                    color: isHovered ? Colors.white.withOpacity(0.02) : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "0${index + 1}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isHovered ? CustomColor.yellowPrimary : Colors.white24,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: isHovered ? CustomColor.yellowPrimary : CustomColor.whitePrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              project.description,
                              style: const TextStyle(fontSize: 14, color: CustomColor.whiteSecondary, height: 1.4),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: project.techStack.split(',').map((tag) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  tag.trim(),
                                  style: const TextStyle(fontSize: 12, color: CustomColor.whiteSecondary),
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_outward_rounded,
                        color: isHovered ? CustomColor.yellowPrimary : Colors.white38,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(width: 40),

        // RIGHT SIDE: Fixed Frame for Mobile Portrait Screenshots (Takes 45% space)
        Expanded(
          flex: 9,
          child: Center(
            child: Container(
              height: 500, // Thoda extra vertical height taaki phone UI clear dikhe
              width: double.infinity,
              padding: const EdgeInsets.all(16), // Padding inside container to prevent edge bleeding
              decoration: BoxDecoration(
                color: Colors.black45, // Neutral background overlay for premium phone look
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: Tween<double>(begin: 0.97, end: 1.0).animate(animation), child: child),
                  );
                },
                key: ValueKey<int>(hoveredIndex),
                // FIXED CONTAINER RATIO: BoxFit.contain keeps the aspect ratio of screenshot absolutely crisp
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    myProjects[hoveredIndex].imagePath ?? '',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // MOBILE LAYOUT: Side-by-side or controlled layout for small screens
  Widget buildMobileLayout() {
    return Column(
      children: myProjects.map((project) => Container(
        margin: const EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
          color: CustomColor.bgLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed container height for preview inside mobile card
            Container(
              height: 280, // Portrait image ke liye standard height framework
              width: double.infinity,
              color: Colors.black26,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Image.asset(
                project.imagePath ?? '',
                fit: BoxFit.contain, // Stretches fixed, rendering actual phone UI nicely
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      project.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CustomColor.whitePrimary)
                  ),
                  const SizedBox(height: 8),
                  Text(
                      project.description,
                      style: const TextStyle(fontSize: 14, color: CustomColor.whiteSecondary, height: 1.4)
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.techStack.split(',').map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: CustomColor.yellowPrimary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag.trim(),
                        style: const TextStyle(fontSize: 11, color: CustomColor.yellowSecondary, fontWeight: FontWeight.w600),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      )).toList(),
    );
  }
}
class MobileDrawer extends StatelessWidget {
  final Function(int) onNavClick; // Added callback
  const MobileDrawer({super.key, required this.onNavClick});


  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: CustomColor.scaffoldBg,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: List.generate(navTitles.length, (index) {
          return ListTile(
            title: Text(navTitles[index], style: const TextStyle(color: Colors.white, fontSize: 18)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              onNavClick(index); // Scroll to section
            },
          );
        }),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: CustomColor.bgLight,
      width: double.infinity,
      child: Center(
          child: Text(
            "© $year Bhargav Valera · Built with Flutter",
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          )      ),
    );
  }
}