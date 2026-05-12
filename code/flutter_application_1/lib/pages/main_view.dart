import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:imat_app/widgets/top_navbar.dart';
import 'package:imat_app/pages/account_view.dart';
import 'package:imat_app/pages/history_page.dart'; // Din snygga historiksida
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _searchController = TextEditingController();
  int selectedIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Hjälpmetod för att nollställa sökning och visa allt
  void _resetToHome(ImatDataHandler iMat) {
    setState(() {
      selectedIndex = 0;
      _searchController.clear();
    });
    iMat.selectAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();
    final products = iMat.selectProducts;
    final spacing = AppTheme.paddingSmall;

    // Här bestämmer vi vad som ska visas i mitten av skärmen
    Widget body;
    switch (selectedIndex) {
      case 0: // SHOP / HANDLA
        body = products.isEmpty 
          ? const Center(child: Text("Inga produkter hittades."))
          : GridView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 4 / 3,
              ),
              itemBuilder: (context, index) {
                return ProductCard(products[index], iMat);
              },
            );
        break;

      case 1: // FAVORITER
        // Vi återanvänder samma GridView men förutsätter att iMat.selectFavorites() har körts
        body = products.isEmpty 
          ? const Center(child: Text("Du har inga favoriter än."))
          : GridView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 4 / 3,
              ),
              itemBuilder: (context, index) {
                return ProductCard(products[index], iMat);
              },
            );
        break;

      case 2: // HISTORIK
        // VIKTIGT: Här anropas din riktiga HistoryPage-klass
        body = const HistoryPage(); 
        break;

      case 3: // MITT KONTO
        body = const AccountView();
        break;

      default:
        body = const Center(child: Text("Sidan kunde inte hittas."));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50], // Ljus bakgrund för att lyfta fram korten
      body: Column(
        children: [
          // Din Navbar som alltid ligger kvar högst upp
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
              // Hoppa automatiskt till "Handla"-vyn när användaren söker
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

          // Här renderas den valda vyn
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}