import 'package:flutter/material.dart';
import '../Constants/new_items.dart';
import '../constants/colors.dart';

class NavBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(int) onNavClick;

  const NavBar({
    super.key,
    required this.scaffoldKey,
    required this.onNavClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1024;
    final bool isDesktop = width >= 1024;

    // 🔹 Responsive values
    final double titleFontSize =
    isMobile ? 22 : isTablet ? 20 : 35;

    final double menuFontSize =
    isMobile ? 20 : isTablet ? 15 : 16;

    final MainAxisAlignment rowAlignment =
    isTablet ? MainAxisAlignment.center : MainAxisAlignment.start;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: rowAlignment,
        children: [
          // ☰ Drawer icon (mobile & tablet)
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu, color: CustomColor.whitePrimary),
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),

          Text(
            'Bhargav Valera',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: CustomColor.yellowPrimary,
              letterSpacing: 1.2,
            ),
          ),

          if (!isTablet) const Spacer(),

          // 🖥 Desktop menu
          if (isDesktop)
            Row(
              children: List.generate(navTitles.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: TextButton(
                    onPressed: () => onNavClick(index),
                    child: Text(
                      navTitles[index],
                      style: TextStyle(
                        fontSize: menuFontSize,
                        color: CustomColor.whitePrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}
