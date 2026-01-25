import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class ProfessionalContactSection extends StatelessWidget {
  const ProfessionalContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Contact Info
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Get in touch", style: TextStyle(color: CustomColor.yellowPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Let's build something\namazing together", style: TextStyle(color: CustomColor.whitePrimary, fontSize: 32, fontWeight: FontWeight.w900)),
                const SizedBox(height: 20),
                const Text("Whether you have a question, a project proposal, or just want to say hi, feel free to reach out.", style: TextStyle(color: CustomColor.whiteSecondary, height: 1.5)),
                const SizedBox(height: 30),
                _contactRow(Icons.email, "bhargav.dev@email.com"),
                const SizedBox(height: 15),
                _contactRow(Icons.location_on, "Ahmedabad, Gujarat, India"),
                const SizedBox(height: 15),
                _contactRow(Icons.phone, "+91 98765 43210"),
              ],
            ),
          ),

          if(!isDesktop) const SizedBox(height: 40),
          if(isDesktop) const SizedBox(width: 60),

          // Right Side: Form
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: CustomColor.bgLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Send a Message", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _customTextField("Your Name"),
                  const SizedBox(height: 15),
                  _customTextField("Email Address"),
                  const SizedBox(height: 15),
                  _customTextField("Message", maxLines: 4),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.yellowPrimary,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      child: const Text("Send Message", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: CustomColor.bgLight, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: CustomColor.yellowPrimary, size: 20),
        ),
        const SizedBox(width: 15),
        Text(text, style: const TextStyle(color: CustomColor.whitePrimary, fontSize: 16)),
      ],
    );
  }

  Widget _customTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
        filled: true,
        fillColor: CustomColor.scaffoldBg,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}