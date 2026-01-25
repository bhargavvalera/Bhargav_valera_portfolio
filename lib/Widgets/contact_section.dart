import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [CustomColor.bgLight, CustomColor.scaffoldBg],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          const Text("Interested in working together?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          const Text("I am available for freelance projects in Ahmedabad or remote.", style: TextStyle(color: Colors.white60)),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            onPressed: () {
            },
            icon: const Icon(Icons.email_outlined),
            label: const Text("Contact Me via Email"),
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.yellowPrimary,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          )
        ],
      ),
    );
  }
}
