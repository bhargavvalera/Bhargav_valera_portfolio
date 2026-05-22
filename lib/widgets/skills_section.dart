
import 'package:flutter/material.dart';
import '../constants/colors.dart';

// 1. Skill Data Model created to hold custom icons
class SkillItem {
  final String name;
  final IconData icon;

  const SkillItem({required this.name, required this.icon});
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  // 2. Curated mapping with category-specific professional icons
  final List<SkillItem> skillsData = const [
    SkillItem(name: "Flutter (Cross-platform Development)", icon: Icons.phone_android_rounded),
    SkillItem(name: "Dart Programming", icon: Icons.code_rounded),
    SkillItem(name: "Firebase (Auth, Firestore, FCM, Storage)", icon: Icons.local_fire_department_rounded),
    SkillItem(name: "REST API Integration & JSON Handling", icon: Icons.cloud_sync_rounded),
    SkillItem(name: "State Management (Provider, GetX)", icon: Icons.layers_rounded),
    SkillItem(name: "Clean Architecture (MVC/MVVM)", icon: Icons.account_tree_rounded),
    SkillItem(name: "Responsive UI & Material Design", icon: Icons.crop_free_rounded),
    SkillItem(name: "Performance Optimization & Debugging", icon: Icons.speed_rounded),
    SkillItem(name: "Git & GitHub (Version Control)", icon: Icons.terminal_rounded),
    SkillItem(name: "CI/CD Basics", icon: Icons.loop_rounded),
    SkillItem(name: "Payment Integration (Razorpay)", icon: Icons.payment_rounded),
    SkillItem(name: "AI-assisted Development", icon: Icons.psychology_rounded),
  ];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return Center(
      child: Container(
        width: double.infinity,
        // FIXED: Hata diya 'someOtherAlignment' ko aur standard ternary setup use kiya
        alignment: isMobile ? Alignment.center : Alignment.centerLeft,
        child: Wrap(
          spacing: 14,
          runSpacing: 16,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: skillsData.map((skill) => HoverSkillChip(skill: skill)).toList(),
        ),
      ),
    );
  }}

// 3. SEPARATE STATEFUL WIDGET FOR SMOOTH PREMIUM INDIVIDUAL HOVER ANIMATIONS
class HoverSkillChip extends StatefulWidget {
  final SkillItem skill;
  const HoverSkillChip({super.key, required this.skill});

  @override
  State<HoverSkillChip> createState() => _HoverSkillChipState();
}

class _HoverSkillChipState extends State<HoverSkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        // Premium Micro-interaction: Translates 4 pixels upwards on hover
        transform: Matrix4.identity()..translate(0, _isHovered ? -5 : 0),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          // Smooth color swap logic
          color: _isHovered ? CustomColor.yellowPrimary : CustomColor.bgLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? CustomColor.yellowPrimary : Colors.white.withOpacity(0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? CustomColor.yellowPrimary.withOpacity(0.25)
                  : Colors.black.withOpacity(0.1),
              blurRadius: _isHovered ? 12 : 6,
              offset: _isHovered ? const Offset(0, 6) : const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.skill.icon,
              size: 20,
              color: _isHovered ? Colors.black87 : CustomColor.yellowPrimary,
            ),
            const SizedBox(width: 12),
            Text(
              widget.skill.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _isHovered ? Colors.black87 : CustomColor.whitePrimary,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}