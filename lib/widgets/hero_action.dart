import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    // Updated Image Widget: Circular boundary removed for the seamless look
    Widget profileImage() {
      return SlideTransition(
        position: _floatingAnimation,
        child: Container(
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
            'I build high-performance Flutter applications with clean architecture and seamless animations. From custom e-commerce shops to AI-powered products, I transform ideas into scalable, production-ready mobile apps.'
                '',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: const TextStyle(fontSize: 16, color: CustomColor.whiteSecondary, height: 1.5),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              widget.onNavClick(3); // Scroll to Contact
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.yellowPrimary,
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text("Get in Touch", style: TextStyle(fontWeight: FontWeight.bold)),
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