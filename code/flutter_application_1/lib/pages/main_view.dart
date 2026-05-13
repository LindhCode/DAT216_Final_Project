// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:imat_app/widgets/top_navbar.dart';
// import 'package:imat_app/widgets/shoppingcart.dart';
// import 'package:imat_app/pages/account_view.dart';
// import 'package:imat_app/pages/history_page.dart';
// import 'package:imat_app/pages/checkout/checkout_view.dart';
// import 'package:imat_app/widgets/product_card.dart';
// import 'package:provider/provider.dart';

// class MainView extends StatefulWidget {
//   const MainView({super.key});

//   @override
//   State<MainView> createState() => _MainViewState();
// }

// class _MainViewState extends State<MainView> {
//   final TextEditingController _searchController = TextEditingController();
//   int selectedIndex = 0; // 0=Hem, 1=Favoriter, 2=Historik, 3=Konto, 4=Kassa

//   void _resetToHome(ImatDataHandler iMat) {
//     setState(() {
//       selectedIndex = 0;
//       _searchController.clear();
//     });
//     iMat.selectAllProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final iMat = context.watch<ImatDataHandler>();
    
//     Widget body;
    
//     switch (selectedIndex) {
//       case 1: // FAVORITER
//         // Vi använder iMat.selectProducts eftersom onFavoritesPressed kör iMat.selectFavorites()
//         final products = iMat.selectProducts; 
        
//         body = products.isEmpty 
//           ? const Center(child: Text("Inga favoriter hittades.", style: TextStyle(fontSize: 18)))
//           : GridView.builder(
//               padding: const EdgeInsets.all(24),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20,
//               ),
//               itemCount: products.length,
//               itemBuilder: (context, index) => ProductCard(product: products[index]),
//             );
//         break;
        
//       case 2:
//         body = const HistoryPage();
//         break;
        
//       case 3:
//         body = const AccountView();
//         break;
        
//       case 4:
//         body = const CheckoutView();
//         break;
        
//       default: // HEM (SelectedIndex 0)
//         body = GridView.builder(
//           padding: const EdgeInsets.all(24),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4,
//             childAspectRatio: 0.75,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//           ),
//           itemCount: iMat.selectProducts.length,
//           itemBuilder: (context, index) => ProductCard(product: iMat.selectProducts[index]),
//         );
//     }

//     return Scaffold(
//       body: Column(
//         children: [
//           TopNavbar(
//             searchController: _searchController,
//             selectedIndex: selectedIndex,
//             onHomePressed: () => _resetToHome(iMat),
//             onShopPressed: () => _resetToHome(iMat),
//             onFavoritesPressed: () {
//               setState(() => selectedIndex = 1);
//               _searchController.clear();
//               iMat.selectFavorites(); // Uppdaterar listan i datahandlern till favoriter
//             },
//             onHistoryPressed: () => setState(() => selectedIndex = 2),
//             onAccountPressed: () => setState(() => selectedIndex = 3),
//             onSearchChanged: (value) {
//               if (selectedIndex != 0) setState(() => selectedIndex = 0);
//               if (value.trim().isEmpty) {
//                 iMat.selectAllProducts();
//               } else {
//                 iMat.selectSelection(iMat.findProducts(value));
//               }
//             },
//           ),
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(child: body),
//                 if (selectedIndex != 4) // Visa bara varukorgen om vi inte är i kassan
//                   CartSidebar(
//                     onCheckout: () => setState(() => selectedIndex = 4),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:imat_app/widgets/top_navbar.dart';
// import 'package:imat_app/widgets/shoppingcart.dart';
// import 'package:imat_app/pages/account_view.dart';
// import 'package:imat_app/pages/history_page.dart';
// import 'package:imat_app/pages/checkout/checkout_view.dart';
// import 'package:imat_app/widgets/product_card.dart';
// import 'package:provider/provider.dart';

// class MainView extends StatefulWidget {
//   const MainView({super.key});

//   @override
//   State<MainView> createState() => _MainViewState();
// }

// class _MainViewState extends State<MainView> {
//   final TextEditingController _searchController = TextEditingController();

//   /// 0 = Handla
//   /// 1 = Favoriter
//   /// 2 = Historik
//   /// 3 = Mitt konto
//   /// 4 = Kassa
//   int selectedIndex = 0;

//   void _resetToHome(ImatDataHandler iMat) {
//     setState(() {
//       selectedIndex = 0;
//       _searchController.clear();
//     });
//     iMat.selectAllProducts();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final iMat = context.watch<ImatDataHandler>();

//     Widget body;

//     switch (selectedIndex) {
//       // ========================
//       // FAVORITER
//       // ========================
//       case 1:
//         final products = iMat.selectProducts;

//         body = products.isEmpty
//             ? const Center(
//                 child: Text(
//                   "Inga favoriter hittades.",
//                   style: TextStyle(fontSize: 18),
//                 ),
//               )
//             : GridView.builder(
//                 padding: const EdgeInsets.all(24),
//                 gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   childAspectRatio: 0.75,
//                   crossAxisSpacing: 20,
//                   mainAxisSpacing: 20,
//                 ),
//                 itemCount: products.length,
//                 itemBuilder: (context, index) =>
//                     ProductCard(product: products[index]),
//               );
//         break;

//       // ========================
//       // HISTORIK
//       // ========================
//       case 2:
//         body = const HistoryPage();
//         break;

//       // ========================
//       // MITT KONTO
//       // ========================
//       case 3:
//         body = const AccountView();
//         break;

//       // ========================
//       // KASSA
//       // ========================
//       case 4:
//         body = const CheckoutView();
//         break;

//       // ========================
//       // HANDLA (default)
//       // ========================
//       default:
//         body = GridView.builder(
//           padding: const EdgeInsets.all(24),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4,
//             childAspectRatio: 0.75,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//           ),
//           itemCount: iMat.selectProducts.length,
//           itemBuilder: (context, index) =>
//               ProductCard(product: iMat.selectProducts[index]),
//         );
//     }

//     return Scaffold(
//       body: Column(
//         children: [
//           // ========================
//           // NAVBAR
//           // ========================
//           TopNavbar(
//             searchController: _searchController,
//             selectedIndex: selectedIndex,

//             onHomePressed: () => _resetToHome(iMat),

//             onShopPressed: () => _resetToHome(iMat),

//             onFavoritesPressed: () {
//               setState(() => selectedIndex = 1);
//               _searchController.clear();
//               iMat.selectFavorites();
//             },

//             onHistoryPressed: () {
//               setState(() => selectedIndex = 2);
//             },

//             onAccountPressed: () {
//               setState(() => selectedIndex = 3);
//             },

//             onSearchChanged: (value) {
//               // Om man söker från en annan sida, gå till Handla
//               if (selectedIndex != 0) {
//                 setState(() => selectedIndex = 0);
//               }

//               if (value.trim().isEmpty) {
//                 iMat.selectAllProducts();
//               } else {
//                 iMat.selectSelection(iMat.findProducts(value));
//               }
//             },
//           ),

//           // ========================
//           // HUVUDLAYOUT
//           // ========================
//           Expanded(
//             child: Row(
//               children: [
//                 // Sidans innehåll
//                 Expanded(
//                   child: body,
//                 ),

//                 // Visa varukorgen ENDAST på Handla- och Favoriter-sidorna
//                 if (selectedIndex == 0 || selectedIndex == 1)
//                   CartSidebar(
//                     onCheckout: () {
//                       setState(() => selectedIndex = 4);
//                     },
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/top_navbar.dart';
import 'package:imat_app/widgets/shoppingcart.dart';
import 'package:imat_app/pages/account_view.dart';
import 'package:imat_app/pages/history_page.dart';
import 'package:imat_app/pages/checkout/checkout_view.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _searchController = TextEditingController();

  /// 0 = Handla
  /// 1 = Favoriter
  /// 2 = Historik
  /// 3 = Mitt konto
  /// 4 = Kassa
  int selectedIndex = 0;

  void _resetToHome(ImatDataHandler iMat) {
    setState(() {
      selectedIndex = 0;
      _searchController.clear();
    });
    iMat.selectAllProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();

    Widget body;

    switch (selectedIndex) {
      case 1:
        final products = iMat.selectProducts;
        body = products.isEmpty
            ? const Center(
                child: Text("Inga favoriter hittades.", style: TextStyle(fontSize: 18)),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) => ProductCard(product: products[index]),
              );
        break;

      case 2:
        body = const HistoryPage();
        break;

      case 3:
        body = AccountView(onBack: () => _resetToHome(iMat));
        break;

      case 4:
        body = const CheckoutView();
        break;

      default:
        body = GridView.builder(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.75,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: iMat.selectProducts.length,
          itemBuilder: (context, index) => ProductCard(product: iMat.selectProducts[index]),
        );
    }

    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            searchController: _searchController,
            selectedIndex: selectedIndex,
            onHomePressed: () => _resetToHome(iMat),
            onShopPressed: () => _resetToHome(iMat),
            onFavoritesPressed: () {
              setState(() => selectedIndex = 1);
              _searchController.clear();
              iMat.selectFavorites();
            },
            onHistoryPressed: () {
              setState(() => selectedIndex = 2);
            },
            onAccountPressed: () {
              setState(() => selectedIndex = 3);
            },
            onSearchChanged: (value) {
              if (selectedIndex != 0) {
                setState(() => selectedIndex = 0);
              }
              if (value.trim().isEmpty) {
                iMat.selectAllProducts();
              } else {
                iMat.selectSelection(iMat.findProducts(value));
              }
            },
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: body),
                if (selectedIndex == 0 || selectedIndex == 1)
                  CartSidebar(
                    onCheckout: () {
                      setState(() => selectedIndex = 4);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}