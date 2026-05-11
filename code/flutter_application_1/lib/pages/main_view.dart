// import 'package:flutter/material.dart';
// import 'package:imat_app/app_theme.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:imat_app/widgets/product_card.dart';
// import 'package:provider/provider.dart';

// class MainView extends StatelessWidget {
//   const MainView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var iMat = context.watch<ImatDataHandler>();
//     var products = iMat.selectProducts;

//     // Det finns en version utan gridDelegate nedan.
//     // Den kan vara enklare att förstå.
//     // Denna version har fördelen att kort skapas on-demand.
//     return Scaffold(
//       appBar: AppBar(title: const Text('iMats produkter')),
//       body: Padding(
//         padding: const EdgeInsets.all(AppTheme.paddingSmall),
//         child: GridView.builder(
//           itemCount: products.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4, // 4 kolumner
//             crossAxisSpacing: AppTheme.paddingSmall,
//             mainAxisSpacing: AppTheme.paddingSmall,
//             childAspectRatio: 4 / 3,
//           ),
//           itemBuilder: (context, index) {
//             final product = products[index];

//             return ProductCard(product, iMat);
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:imat_app/widgets/top_navbar.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;

    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            searchController: _searchController,

            // Klick på loggan -> tillbaka till startsidan
            onHomePressed: () {
              _searchController.clear();
              iMat.selectAllProducts();
            },

            // Handla
            onShopPressed: () {
              _searchController.clear();
              iMat.selectAllProducts();
            },

            // Mina favoriter
            onFavoritesPressed: () {
              _searchController.clear();
              iMat.selectFavorites();
            },

            // Min historik
            onHistoryPressed: () {
              print('Visa orderhistorik');
            },

            // Sökning
            onSearchChanged: (value) {
              if (value.trim().isEmpty) {
                iMat.selectAllProducts();
              } else {
                iMat.selectSelection(
                  iMat.findProducts(value),
                );
              }
            },
          ),

          // Produktgrid
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.all(AppTheme.paddingSmall),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing:
                      AppTheme.paddingSmall,
                  mainAxisSpacing:
                      AppTheme.paddingSmall,
                  childAspectRatio: 4 / 3,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(product, iMat);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}