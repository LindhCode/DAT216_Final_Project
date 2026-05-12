import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/shopping_item.dart';

// Dina specifika importer
import 'package:imat_app/widgets/top_navbar.dart';
import 'history_page.dart';
import 'account_view.dart';
import 'checkout/checkout_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool _isCheckingOut = false;
  int _selectedIndex = 1; // Startar på "Handla" (index 1 i din TopNavbar)
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;
    var cart = iMat.getShoppingCart();

    // Om vi är i kassan, visa CheckoutView
    if (_isCheckingOut) {
      return const CheckoutView();
    }

    return Scaffold(
      // Vi använder din TopNavbar från top_navbar.dart
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: TopNavbar(
          searchController: _searchController,
          selectedIndex: _selectedIndex,
          onHomePressed: () => setState(() => _selectedIndex = 1),
          onShopPressed: () => setState(() => _selectedIndex = 1),
          onFavoritesPressed: () {
            // Implementera favoriter här om du har en fil för det
          },
          onHistoryPressed: () => setState(() => _selectedIndex = 2),
          onAccountPressed: () => setState(() => _selectedIndex = 3),
          onSearchChanged: (value) {
            // Här kan du lägga till sökfiltrering via iMat data handler
          },
        ),
      ),
      body: _buildCurrentPage(iMat, products, cart),
    );
  }

  // Logik för att visa rätt sida baserat på val i headern
  Widget _buildCurrentPage(iMat, products, cart) {
    switch (_selectedIndex) {
      case 2:
        return const HistoryPage(); // Från history_page.dart
      case 3:
        return const AccountView(); // Från account_view.dart
      case 1:
      default:
        return Row(
          children: [
            // 1. Kategorier
            Container(
              width: 250,
              color: AppTheme.sidebarBackground,
              child: const Center(child: Text("Kategorier (Inaktiverad)")),
            ),

            // 2. Produktnät
            Expanded(
              flex: 3,
              child: Container(
                color: AppTheme.backgroundLight,
                padding: const EdgeInsets.all(AppTheme.paddingMedium),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: AppTheme.paddingSmall,
                    crossAxisSpacing: AppTheme.paddingSmall,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index], iMat: iMat);
                  },
                ),
              ),
            ),

            // 3. Varukorgshögerpanel
            Container(
              width: 300,
              color: Colors.white,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Min varukorg",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text("${item.amount.toInt()} ${item.product.unit}"),
                          trailing: Text(
                              "${item.total.toStringAsFixed(2)} kr"),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: AppTheme.primaryGreen,
                      ),
                      onPressed: cart.items.isEmpty
                          ? null
                          : () => setState(() => _isCheckingOut = true),
                      child: const Text("Gå till kassan",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }
}

class ProductCard extends StatelessWidget {
  final dynamic product;
  final ImatDataHandler iMat;
  const ProductCard({required this.product, required this.iMat, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_basket,
              size: 40, color: AppTheme.primaryGreen),
          const SizedBox(height: 8),
          Text(product.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("${product.price} kr"),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              iMat.getShoppingCart().addItem(ShoppingItem(product));
              iMat.notifyListeners();
            },
            child: const Text("Köp"),
          ),
        ],
      ),
    );
  }
}