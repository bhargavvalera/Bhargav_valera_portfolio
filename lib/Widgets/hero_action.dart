import 'package:flutter/material.dart';
import '../Constants/colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    // Image Container ko ek variable/widget mein define kiya taaki reuse kar sakein
    Widget profileImage() {
      return Container(
        width: isMobile ? 220 : 280, // Mobile pe thoda chhota
        height: isMobile ? 220 : 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColor.bgLight,
          border: Border.all(color: CustomColor.yellowPrimary, width: 4),
          boxShadow: [
            BoxShadow(
                color: CustomColor.yellowPrimary.withOpacity(0.2),
                blurRadius: 30,
                spreadRadius: 5
            ),
          ],
          image: const DecorationImage(
            image: AssetImage('assets/images/meee.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // Text Content ko bhi isolate kiya
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
            "Flutter Developer\n& API Integrator",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 32 : 50, // Mobile font thoda adjust kiya
              fontWeight: FontWeight.w900,
              color: CustomColor.whitePrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "I transform ideas into high-performance mobile apps.\nSpecialized in clean UI, REST APIs, and efficient state management.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: const TextStyle(fontSize: 16, color: CustomColor.whiteSecondary, height: 1.5),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
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
      constraints: BoxConstraints(minHeight: isMobile ? 700 : 500), // Mobile pe height badhayi content ke liye
      child: isMobile
      // MOBILE LAYOUT: Column (Image Top, Text Bottom)
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          profileImage(), // Image Pehle
          const SizedBox(height: 40),
          textContent(), // Text Baad mein
          const SizedBox(height: 30),
        ],
      )
      // DESKTOP LAYOUT: Row (Text Left, Image Right)
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: textContent()),
          const SizedBox(width: 40),
          Expanded(flex: 1, child: Center(child: profileImage())),
        ],
      ),
    );
  }
}