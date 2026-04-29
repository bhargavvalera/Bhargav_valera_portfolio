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
  Project({required this.title, required this.description, required this.techStack});
}

// --- DATA ---
List<Project> myProjects = [
  Project(
    title: "Shree Hari Cateres",
    description: "Operational dashboard for managing kitchen inventory, tracking raw material procurement, and coordinating staff logistics for large-scale weddings.",
    techStack: "Flutter, Provider, Dart, Rest APIS",
  ),
  Project(
    title: "Sukhadiya Cateres",
    description: "A comprehensive catering management system for tracking live orders, managing event schedules, and automating client billing and notifications.",
    techStack: "Flutter, Provider, Dart, Rest APIS",
  ),
  Project(
    title: "Amonkar Cateres",
    description: "Digital menu catalogue and booking application allowing clients to customize food packages, estimate costs, and schedule services for events.",
    techStack: "Flutter, Provider, Dart, Rest APIS",
  ),
  Project(title: "Just Wedding Software",
      description: "About This is a Wedding Food Ordering and Management app developed using Flutter. Users can place food orders, track real-time order status, and view order history. The Captain app is designed to manage orders only, with statuses like New, In Progress, and Delivered. It ensures smooth and organized food order handling during wedding events.",
      techStack: "Flutter,GetX,RestAPI,Dart",),

  Project(
    title: "SkySnap",
    description: "A minimalist, real-time weather application featuring dynamic animations, location-based 7-day forecasts, and detailed atmospheric data visualization.",
    techStack: "Flutter, OpenWeatherMap API, Geolocator, Lottie",
  ),
  Project(title: "ATPT",
      description: "ATPT (Any Time Party Time) is a fast and convenient food-ordering app designed for party and event catering. It allows users to browse menus, place customized bulk orders, and track inquiries in real time. Built with Flutter, it streamlines the entire party-food ordering workflow for both customers and vendors.",
      techStack: "Flutter,Firebase,API Integration"),

  Project(title: "DreamFirst",
      description: "DreamFirst is a Flutter-based mobile news app that delivers real-time news articles and videos with a clean, user-friendly interface.It supports role-based workflows for admins, reporters, and users, enabling efficient content creation, moderation, and publishing.Powered by Firebase, it includes authentication, Firestore database, and push notifications for a secure and scalable experience.",
      techStack: "Flutter, Dart, Firebase (Auth, Firestore, Cloud Functions, FCM), Provider, REST APIs, Netlify, Git/GitHub, AdMob"),
];

List<String> mySkills = [
  "Flutter (Cross-platform Development)",
  "Dart Programming",
  "Firebase (Auth, Firestore, FCM, Storage)",
  "REST API Integration & JSON Handling",
  "State Management (Provider, GetX)",
  "Clean Architecture (MVC/MVVM)",
  "Responsive UI & Material Design",
  "Performance Optimization & Debugging",
  "Git & GitHub (Version Control)",
  "CI/CD Basics",
  "Payment Integration (Razorpay)",
  "AI-assisted Development",
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

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth > 800 ? 320 : constraints.maxWidth;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: myProjects.map((project) => Container(
            width: cardWidth,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: CustomColor.bgLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.smartphone_rounded, color: CustomColor.yellowPrimary),
                ),
                const SizedBox(height: 15),
                Text(
                  project.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CustomColor.whitePrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: const TextStyle(fontSize: 14, color: CustomColor.whiteSecondary, height: 1.4),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.techStack.split(',').map((tag) => Text(
                      "#${tag.trim()}",
                      style: const TextStyle(fontSize: 12, color: CustomColor.yellowSecondary, fontWeight: FontWeight.w600)
                  )).toList(),
                ),
              ],
            ),
          )).toList(),
        );
      },
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