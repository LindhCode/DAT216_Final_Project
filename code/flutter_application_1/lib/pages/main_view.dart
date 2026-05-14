import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Modeller och Data
import 'package:imat_app/model/imat_data_handler.dart';

// Views / Features
import 'package:imat_app/features/account/account_view.dart';
import 'package:imat_app/features/checkout/checkout_view.dart';
import 'package:imat_app/features/history/history_page.dart';

// Widgets
import 'package:imat_app/shared/widgets/category.dart';
import 'package:imat_app/shared/widgets/product_card.dart'; 
import 'package:imat_app/shared/widgets/shoppingcart.dart';
import 'package:imat_app/shared/widgets/top_navbar.dart';
import 'package:imat_app/shared/widgets/breadcrumbs.dart'; // Säkerställ att filen finns

// Core / Tema
import 'package:imat_app/core/theme/app_theme.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _searchController = TextEditingController();
  int selectedIndex = 0; 

  void _resetToHome(BuildContext context) {
    setState(() {
      selectedIndex = 0;
      _searchController.clear();
    });
    context.read<ImatDataHandler>().selectAllProducts();
  }

  Widget _buildBody(ImatDataHandler iMat) {
    switch (selectedIndex) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BREADCRUMBS & SORTERING
            const Breadcrumbs(), 
            
            // 2. PRODUKT-GRID
            Expanded(
              child: ProductsBody(iMat: iMat),
            ),
          ],
        );
      case 2:
        return const HistoryPage();
      case 3:
        return const AccountView();
      case 4:
        return CheckoutView(
          onNavigateToHistory: (index) => setState(() => selectedIndex = index),
        );
      default:
        return const Center(child: Text("Sidan hittades inte"));
    }
  }

  @override
  Widget build(BuildContext context) {
    // VIKTIGT: watch gör att hela MainView ritas om när notifyListeners() körs i din handler
    final iMat = context.watch<ImatDataHandler>();

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          // NAVBAR
          TopNavbar(
            searchController: _searchController,
            selectedIndex: selectedIndex,
            onHomePressed: () => _resetToHome(context),
            onShopPressed: () => setState(() => selectedIndex = 0),
            onFavoritesPressed: () {
              setState(() => selectedIndex = 0);
              iMat.selectFavorites();
            },
            onHistoryPressed: () => setState(() => selectedIndex = 2),
            onAccountPressed: () => setState(() => selectedIndex = 3),
            onSearchChanged: (value) {
              if (selectedIndex != 0) setState(() => selectedIndex = 0);
              iMat.selectSelection(iMat.findProducts(value));
            },
          ),
          
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // SIDEBAR KATEGORIER (syns bara på hem-vyn)
                if (selectedIndex == 0) 
                  CategorySidebar(iMat: iMat),
                
                // MITTEN: Breadcrumbs + Produkter / Eller andra sidor
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: _buildBody(iMat),
                  ),
                ),
                
                // SIDEBAR VARUKORG (syns ej i kassan)
                if (selectedIndex != 4)
                  CartSidebar(
                    onCheckout: () => setState(() => selectedIndex = 4),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}