import 'package:flutter/material.dart';
import '../Pages/home_page.dart';
import '../constants/colors.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: mySkills.map((skill) => Chip(
          backgroundColor: CustomColor.bgLight,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          side: const BorderSide(color: Colors.white12),
          label: Text(skill, style: const TextStyle(color: CustomColor.whiteSecondary)),
          avatar: const Icon(Icons.code, color: CustomColor.yellowPrimary, size: 18),
        )).toList(),
      ),
    );
  }
}


