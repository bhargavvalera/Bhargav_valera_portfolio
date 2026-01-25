import 'package:flutter/material.dart';
import '../Constants/new_items.dart';
import '../constants/colors.dart';

// class NavBar extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final Function(int) onNavClick;
//
//   const NavBar({super.key, required this.scaffoldKey, required this.onNavClick});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isDesktop = width >= 800;
//
//     return Container(
//       height: 70,
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: CustomColor.bgLight.withOpacity(0.9),
//         borderRadius: BorderRadius.circular(100),
//         border: Border.all(color: Colors.white12),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0,5)),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Logo
//           const Text(
//             'Bhargav Valera' ,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: CustomColor.yellowPrimary,
//               letterSpacing: 1.2,
//             ),
//           ),
//           if (isDesktop)
//             Row(
//               children: List.generate(navTitles.length, (index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 30),
//                   child: TextButton(
//                     onPressed: () {
//                       onNavClick(index); // <--- 3. Click hone par index bheja
//                     },
//                     child: Text(
//                       navTitles[index],
//                       style: const TextStyle(
//                         color: CustomColor.whitePrimary,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             )
//           else
//             IconButton(
//               icon: const Icon(Icons.menu, color: CustomColor.whitePrimary),
//               onPressed: () => scaffoldKey.currentState?.openDrawer(),
//             ),
//         ],
//       ),
//     );
//   }
// }
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
    final isDesktop = width >= 800;

    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: CustomColor.bgLight.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu, color: CustomColor.whitePrimary),
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),
          const SizedBox(width: 60,),
          const Text(
            'Bhargav Valera',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColor.yellowPrimary,
                letterSpacing: 1.2
            ),
          ),

          // --- CHANGE 2: DESKTOP LINKS (Right Side) ---
          if (isDesktop)
            Row(
              children: List.generate(navTitles.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TextButton(
                    onPressed: () => onNavClick(index),
                    child: Text(
                      navTitles[index],
                      style: const TextStyle(
                        color: CustomColor.whitePrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),

          // --- OPTIONAL: Empty Box for Mobile Balance ---
          // Agar mobile pe Logo ko Center mein rakhna hai, toh yeh uncomment karein:
          // if (!isDesktop) const SizedBox(width: 48),
        ],
      ),
    );
  }
}