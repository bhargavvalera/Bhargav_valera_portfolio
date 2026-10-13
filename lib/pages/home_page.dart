import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/contact_section.dart';
import '../widgets/hero_action.dart';
import '../widgets/nav_item.dart'; // Ensure this exists or use the NavBar code I gave earlier
import '../widgets/skills_section.dart';

// --- MODELS ---
class Project {
  final String title;
  final String description;
  final String techStack;
  final String? imagePath;
  final String issue;
  final String solution;
  final String impact;
  Project({required this.impact,required this.issue,required this.solution,required this.title, required this.description, this.imagePath,required this.techStack});
}

// --- DATA ---
List<Project> myProjects = [

  Project(
      title: "Sukhadiya Caterers",
      description: "A comprehensive catering management system for tracking live orders, managing event schedules, and automating client billing and notifications.",
      techStack: "Flutter, Provider, Dart, Rest APIS",
      imagePath: 'assets/images/sukhadiya_p.jpeg',
      issue: "Managing rapid state changes for live order tracking caused the app to rebuild the entire screen unnecessarily, leading to performance drops and battery drain on budget devices.",
      solution: "I optimized the state management using Provider, isolating UI rebuilds to only the specific widgets that needed updates while caching the rest of the layout.",
      impact: "Reduced unnecessary screen rebuilds by over 90%, improving battery efficiency and resulting in 100% client retention for the next phase of development."
  ),
  Project(
      title: "DreamFirst",
      imagePath: 'assets/images/user_home.jpeg',
      description: "DreamFirst is a Firebase-powered Flutter news app featuring real-time updates and role-based content management. It integrates a unique gamified reward system where users engage with ads to earn virtual coins, redeemable for fully sponsored spiritual trips to places like Ayodhya, Ajmer Sharif, and Khatu Shyam, ensuring a highly engaging and scalable experience.",      techStack: "Flutter, Dart, Razor Pay, Google Ads, Firebase (Auth, Firestore, Cloud Functions, FCM), Provider, REST APIs, Netlify, Git/GitHub",
      issue: "Handling role-based access control securely without exposing restricted content or causing UI lag when querying the database for user permissions.",
      solution: "I implemented Firebase Custom Claims paired with Provider to manage user sessions, instantly locking or unlocking specific UI routes locally based on the verified role.",
      impact: "Reduced permission-check latency by 99% (from multiple database reads down to instantaneous local checks), cutting Firebase read costs and handling high user traffic effortlessly."
  ),

  Project(
    title: "MR4U",
    imagePath: 'assets/images/mr4u.jpeg',
    description: "Medicine Reminder 4 U is a Flutter-based medication management app that allows users to add medicines and schedule morning, afternoon, and evening reminders. It uses SQLite for local data storage and custom notifications to deliver alarm-like reminders, helping users take their medicines on time, even without an internet connection.",
    techStack: "Flutter, Dart, SQLite, Local Notifications, Custom Alarm Reminders",
    issue: "Managing medicine schedules and delivering timely reminders while maintaining reliable local data storage and notification functionality.",
    solution: "I implemented SQLite for persistent local storage and custom notification scheduling to manage medicine details and trigger reminders at user-defined times.",
    impact: "Enabled users to manage medication schedules offline, receive timely reminders, and access their saved medicine details without requiring a backend server.",
  ),
  Project(
      title: "ATPT",
      imagePath: 'assets/images/atpt_p.jpeg',
      description: "ATPT (Any Time Party Time) is a fast and convenient food-ordering app designed for party and event catering. It allows users to browse menus, place customized bulk orders, and track inquiries in real time. Built with Flutter, it streamlines the entire party-food ordering workflow for both customers and vendors.",
      techStack: "Flutter, Firebase, API Integration",
      issue: "Users placing massive, highly customized bulk orders experienced slow load times and occasional timeouts when pushing heavy cart data to the backend.",
      solution: "I structured the Firebase Firestore database to handle batch writes and used local state management to hold the complex order configurations before executing a single, optimized API call.",
      impact: "Cut database write latency by 80% and reduced API calls, which directly contributed to a 35% increase in successful bulk order inquiries for the vendor."
  ),
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
    const textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColor.whitePrimary);
    final textPainter=TextPainter(
      text: TextSpan(text: title, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    final textwidth = textPainter.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColor.whitePrimary)),
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
      // Agar buildMobileLayout context parameter nahi leta, toh usko add kar lena
      return buildMobileLayout(context);
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

                            const SizedBox(height: 20), // ADDED SPACING

                            // --- NEW: VIEW CASE STUDY BUTTON (DESKTOP) ---
                            OutlinedButton.icon(
                              onPressed: () => _showCaseStudy(context, project),
                              icon: Icon(
                                  Icons.analytics_outlined,
                                  size: 18,
                                  color: isHovered ? CustomColor.yellowPrimary : CustomColor.whiteSecondary
                              ),
                              label: Text(
                                "View Case Study",
                                style: TextStyle(
                                    color: isHovered ? CustomColor.yellowPrimary : CustomColor.whiteSecondary
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: isHovered ? CustomColor.yellowPrimary : Colors.white24
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ),
                              ),
                            ),
                            // ----------------------------------------------

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
              height: 500,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black45,
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

// MOBILE LAYOUT: Updated to accept BuildContext for the Dialog
  Widget buildMobileLayout(BuildContext context) {
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
            Container(
              height: 280,
              width: double.infinity,
              color: Colors.black26,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Image.asset(
                project.imagePath ?? '',
                fit: BoxFit.contain,
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

                  const SizedBox(height: 20), // ADDED SPACING

                  // --- NEW: VIEW CASE STUDY BUTTON (MOBILE) ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showCaseStudy(context, project),
                      icon: const Icon(Icons.analytics_outlined, size: 18, color: Colors.black87),
                      label: const Text(
                        "View Case Study",
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.yellowPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  // ---------------------------------------------

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

void _showCaseStudy(BuildContext context, Project project) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: CustomColor.scaffoldBg, // Apka background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600), // Desktop ke liye max width
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${project.title} - Case Study",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white54),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                const SizedBox(height: 24),

                // ISSUE SECTION
                _buildCaseStudySection(
                  icon: Icons.warning_amber_rounded,
                  color: Colors.redAccent,
                  title: "The Challenge",
                  content: project.issue,
                ),
                const SizedBox(height: 20),

                // SOLUTION SECTION
                _buildCaseStudySection(
                  icon: Icons.lightbulb_outline,
                  color: Colors.blueAccent,
                  title: "My Solution",
                  content: project.solution,
                ),
                const SizedBox(height: 20),

                // IMPACT SECTION (Highlighted)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CustomColor.yellowPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: CustomColor.yellowPrimary.withOpacity(0.3)),
                  ),
                  child: _buildCaseStudySection(
                    icon: Icons.trending_up_rounded,
                    color: CustomColor.yellowPrimary,
                    title: "The Impact",
                    content: project.impact,
                    isImpact: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// Helper widget for Dialog sections
Widget _buildCaseStudySection({
  required IconData icon,
  required Color color,
  required String title,
  required String content,
  bool isImpact = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isImpact ? CustomColor.yellowPrimary : CustomColor.whitePrimary,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.only(left: 34),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            color: CustomColor.whiteSecondary,
            height: 1.5,
          ),
        ),
      ),
    ],
  );
}