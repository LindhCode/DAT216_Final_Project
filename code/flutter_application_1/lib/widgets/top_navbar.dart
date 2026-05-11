// import 'package:flutter/material.dart';

// class TopNavbar extends StatelessWidget {
//   final TextEditingController searchController;
//   final VoidCallback onShopPressed;
//   final VoidCallback onFavoritesPressed;
//   final VoidCallback onHistoryPressed;
//   final ValueChanged<String>? onSearchChanged;

//   const TopNavbar({
//     super.key,
//     required this.searchController,
//     required this.onShopPressed,
//     required this.onFavoritesPressed,
//     required this.onHistoryPressed,
//     this.onSearchChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       color: Colors.black,
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Row(
//         children: [
//           // Vänster sida: Handla + Mina favoriter
//           TextButton(
//             onPressed: onShopPressed,
//             child: const Text(
//               'Handla',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//           const SizedBox(width: 12),
//           TextButton(
//             onPressed: onFavoritesPressed,
//             child: const Text(
//               'Mina favoriter',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),

//           const SizedBox(width: 32),

//           // Sökruta i mitten
//           Expanded(
//             child: Center(
//               child: SizedBox(
//                 height: 42,
//                 child: TextField(
//                   controller: searchController,
//                   onChanged: onSearchChanged,
//                   style: const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     hintText: 'Sök produkter...',
//                     prefixIcon: const Icon(Icons.search),
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(width: 32),

//           // Höger sida: Historik
//           TextButton(
//             onPressed: onHistoryPressed,
//             child: const Text(
//               'Min historik',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class TopNavbar extends StatelessWidget {
  final TextEditingController searchController;

  // Callback för klick på loggan (hemknapp)
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
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // iMat-logga längst till vänster
          InkWell(
            onTap: onHomePressed,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                'assets/images/imat_logo.png',
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Handla med kundvagnsikon
          TextButton.icon(
            onPressed: onShopPressed,
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Handla',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Mina favoriter med hjärta
          TextButton.icon(
            onPressed: onFavoritesPressed,
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Mina favoriter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(width: 32),

          // Sökruta i mitten
          Expanded(
            child: SizedBox(
              height: 42,
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Sök produkter...',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 32),

          // Min historik
          TextButton(
            onPressed: onHistoryPressed,
            child: const Text(
              'Min historik',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}