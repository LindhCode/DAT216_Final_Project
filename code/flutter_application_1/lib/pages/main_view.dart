import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/shopping_item.dart'; // Viktig import för addItem

// Importera kassavyn
import 'checkout/checkout_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool _isCheckingOut = false;

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;
    var cart = iMat.getShoppingCart();

    if (_isCheckingOut) {
      // Om CheckoutView i din kod inte har onBack, 
      // kan du behöva ta bort onBack-parametern här.
      return const CheckoutView();
    }

    return Scaffold(
      body: Column(
        children: [
          const TopNavbar(),
          Expanded(
            child: Row(
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
                        child: Text("Min varukorg", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cart.items.length,
                          itemBuilder: (context, index) {
                            final item = cart.items[index];
                            return ListTile(
                              title: Text(item.product.name),
                              trailing: Text("${item.total.toStringAsFixed(2)} kr"),
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
                          onPressed: cart.items.isEmpty ? null : () => setState(() => _isCheckingOut = true),
                          child: const Text("Gå till kassan", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopNavbar extends StatelessWidget {
  const TopNavbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: const Color(0xFF1B1B1B),
      child: const Center(child: Text("iMat Header", style: TextStyle(color: Colors.white, fontSize: 20))),
    );
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
          const Icon(Icons.shopping_basket, size: 40, color: AppTheme.primaryGreen),
          const SizedBox(height: 8),
          Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("${product.price} kr"),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // HÄR VAR FELET: Vi skapar ett ShoppingItem med produkten
              iMat.getShoppingCart().addItem(ShoppingItem(product));
              // Vi anropar notifyListeners via iMat om addItem inte gör det själv
              iMat.notifyListeners(); 
            },
            child: const Text("Köp"),
          ),
        ],
      ),
    );
  }
  }