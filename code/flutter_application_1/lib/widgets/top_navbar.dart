
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TopNavbar extends StatefulWidget {
//   final TextEditingController searchController;
//   final VoidCallback onHomePressed;
//   final VoidCallback onShopPressed;
//   final VoidCallback onFavoritesPressed;
//   final VoidCallback onHistoryPressed;
//   final ValueChanged<String>? onSearchChanged;

//   const TopNavbar({
//     super.key,
//     required this.searchController,
//     required this.onHomePressed,
//     required this.onShopPressed,
//     required this.onFavoritesPressed,
//     required this.onHistoryPressed,
//     this.onSearchChanged,
//   });

//   @override
//   State<TopNavbar> createState() => _TopNavbarState();
// }

// class _TopNavbarState extends State<TopNavbar> {
//   int hoveredIndex = -1;

//   final textStyle = const TextStyle(
//     color: Colors.white,
//     fontSize: 16,
//     fontWeight: FontWeight.w600,
//   );

//   Widget navItem({
//     required int index,
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     final isHovered = hoveredIndex == index;

//     return MouseRegion(
//       onEnter: (_) => setState(() => hoveredIndex = index),
//       onExit: (_) => setState(() => hoveredIndex = -1),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         decoration: BoxDecoration(
//           color: isHovered ? Colors.white24 : Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: TextButton.icon(
//           style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//           ),
//           onPressed: onTap,
//           icon: Icon(icon, color: Colors.white, size: 24),
//           label: Text(label, style: textStyle),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 65,
//       color: Colors.grey[900], // 🧠 mörkgrå navbar
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           // 🏠 LOGGA
//           InkWell(
//             onTap: widget.onHomePressed,
//             child: Image.asset(
//               'assets/images/imat_logo.png',
//               height: 45,
//             ),
//           ),

//           const SizedBox(width: 12),

//           // 📦 NAV
//           navItem(
//             index: 0,
//             icon: Icons.shopping_cart_outlined,
//             label: "Handla",
//             onTap: widget.onShopPressed,
//           ),

//           const SizedBox(width: 6),

//           navItem(
//             index: 1,
//             icon: Icons.favorite_border,
//             label: "Favoriter",
//             onTap: widget.onFavoritesPressed,
//           ),

//           const SizedBox(width: 10),

//           // 🔍 SÖK (ikon flyttad till höger)
//           Expanded(
//             child: Center(
//               child: SizedBox(
//                 width: 500,
//                 height: 42,
//                 child: TextField(
//                   controller: widget.searchController,
//                   onChanged: widget.onSearchChanged,
//                   decoration: InputDecoration(
//                     hintText: "Sök produkter...",
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),

//                     // 🔍 ikon till HÖGER
//                     suffixIcon: const Icon(Icons.search),

//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(width: 10),

//           // 📜 HISTORIK
//           navItem(
//             index: 2,
//             icon: Icons.history,
//             label: "Historik",
//             onTap: widget.onHistoryPressed,
//           ),

//           const SizedBox(width: 10),

//           // 👤 MITT KONTO
//           navItem(
//             index: 3,
//             icon: Icons.person,
//             label: "Mitt konto",
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class TopNavbar extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onHomePressed;
  final VoidCallback onShopPressed;
  final VoidCallback onFavoritesPressed;
  final VoidCallback onHistoryPressed;
  final ValueChanged<String>? onSearchChanged;

  const TopNavbar({
    super.key,
    required this.searchController,
    required this.onHomePressed,
    required this.onShopPressed,
    required this.onFavoritesPressed,
    required this.onHistoryPressed,
    this.onSearchChanged,
  });

  @override
  State<TopNavbar> createState() => _TopNavbarState();
}

class _TopNavbarState extends State<TopNavbar> {
  int hoveredIndex = -1;
  int selectedIndex = 0; // 📍 aktiv sida

  void setSelected(int index) {
    setState(() => selectedIndex = index);
  }

  Widget navItem({
    required int index,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isHovered = hoveredIndex == index;
    final isSelected = selectedIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: InkWell(
        onTap: () {
          setSelected(index);
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isHovered ? Colors.white12 : Colors.transparent,
            border: isSelected
                ? const Border(
                    bottom: BorderSide(color: Colors.white, width: 2),
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 🏷️ STÖRRE LOGGA (utan att påverka navbarens storlek)
          InkWell(
            onTap: widget.onHomePressed,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.asset(
                'assets/images/imat_logo.png',
                height: 55, // 🔼 större logo
              ),
            ),
          ),

          // 📦 NAV ITEMS
          navItem(
            index: 0,
            icon: Icons.shopping_cart_outlined,
            label: "Handla",
            onTap: widget.onShopPressed,
          ),

          const SizedBox(width: 8),

          navItem(
            index: 1,
            icon: Icons.favorite_border,
            label: "Favoriter",
            onTap: widget.onFavoritesPressed,
          ),

          const SizedBox(width: 10),

          // 🔍 SÖK
          Expanded(
            child: Center(
              child: SizedBox(
                width: 500,
                height: 42,
                child: TextField(
                  controller: widget.searchController,
                  onChanged: widget.onSearchChanged,
                  decoration: InputDecoration(
                    hintText: "Sök produkter...",
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          navItem(
            index: 2,
            icon: Icons.history,
            label: "Historik",
            onTap: widget.onHistoryPressed,
          ),

          const SizedBox(width: 10),

          navItem(
            index: 3,
            icon: Icons.person,
            label: "Mitt konto",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}