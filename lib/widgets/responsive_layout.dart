import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile Breakpoint: < 600
        if (constraints.maxWidth < 600) {
          return mobileBody;
        }
        // Tablet Breakpoint: 600 - 1100
        else if (constraints.maxWidth < 1100) {
          return tabletBody;
        }
        // Desktop Breakpoint: > 1100
        else {
          return desktopBody;
        }
      },
    );
  }
}