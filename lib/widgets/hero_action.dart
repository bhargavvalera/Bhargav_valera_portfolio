import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this package
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add this package
import '../constants/colors.dart';

class HeroSection extends StatefulWidget {
  final Function(int) onNavClick;
  const HeroSection({super.key, required this.onNavClick});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    // Gentle floating loop animation (3 seconds duration)
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.03), // Subtle 3% upward movement
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Helper method to open links
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    // Updated Image Widget: Circular boundary removed for the seamless look
    Widget profileImage() {
      return SlideTransition(
        position: _floatingAnimation,
        child: SizedBox(
          width: isMobile ? 260 : 380, // Dynamic sizes to suit transparent PNGs
          height: isMobile ? 300 : 450,
          child: Image.asset(
            'assets/images/pii.png', // Ensure this is a background-removed PNG
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    // Text Content with subtle refinements
    Widget textContent() {
      return Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Hi, I'm Bhargav",
            style: TextStyle(fontSize: 20, color: CustomColor.yellowPrimary, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Flutter Developer building AI-powered Mobile Products",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 32 : 50,
              fontWeight: FontWeight.w900,
              color: CustomColor.whitePrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'I build high-performance Flutter applications with clean architecture and seamless animations. From custom e-commerce shops to AI-powered products, I transform ideas into scalable, production-ready mobile apps.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: const TextStyle(fontSize: 16, color: CustomColor.whiteSecondary, height: 1.5),
          ),
          const SizedBox(height: 30),

          // --- UPDATED CALL TO ACTION AREA ---
          Wrap(
            spacing: 16, // Horizontal space between items
            runSpacing: 16, // Vertical space if they wrap on mobile
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // 1. GET IN TOUCH BUTTON (Primary)
              ElevatedButton(
                onPressed: () {
                  widget.onNavClick(3); // Scroll to Contact
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.yellowPrimary,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Get in Touch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),

              // 2. DOWNLOAD RESUME BUTTON (Secondary/Outline)
              OutlinedButton.icon(
                onPressed: () => _launchURL(
                    'https://drive.google.com/file/d/1jdfjcXRfUqXkc1ka-Fr1CNz7R2RtMPzP/view?usp=sharing'
      ), // ),
                icon: const Icon(Icons.download_rounded, size: 18, color: CustomColor.whitePrimary),
                label: const Text(
                  "Resume",
                  style: TextStyle(color: CustomColor.whitePrimary, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),

              // 3. GITHUB ICON
              InkWell(
                onTap: () => _launchURL('https://github.com/bhargavvalera'), // Add GitHub URL
                borderRadius: BorderRadius.circular(50),
                hoverColor: CustomColor.yellowPrimary.withOpacity(0.1),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                    color: Colors.transparent, // Ensures no white background
                  ),
                  child: const FaIcon(FontAwesomeIcons.github, color: CustomColor.whiteSecondary, size: 20),
                ),
              ),

              // 4. LINKEDIN ICON
              InkWell(
                onTap: () => _launchURL('https://www.linkedin.com/in/bhargav-valera-780738229/'), // Add LinkedIn URL
                borderRadius: BorderRadius.circular(50),
                hoverColor: CustomColor.yellowPrimary.withOpacity(0.1),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                    color: Colors.blue, // Ensures no white background
                  ),
                  child: const FaIcon(FontAwesomeIcons.linkedinIn, color: CustomColor.whiteSecondary, size: 20),
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Main Layout Logic
    return Container(
      constraints: BoxConstraints(minHeight: isMobile ? 650 : 550),
      child: isMobile
      // MOBILE LAYOUT
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          profileImage(),
          const SizedBox(height: 30),
          textContent(),
          const SizedBox(height: 30),
        ],
      )
      // DESKTOP LAYOUT
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end, // Aligns image perfectly flat at the bottom edge
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0), // Padding to keep text centered vertically
              child: textContent(),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: profileImage(),
            ),
          ),
        ],
      ),
    );
  }
}