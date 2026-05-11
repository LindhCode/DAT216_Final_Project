import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/model/imat/order.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/widgets/top_navbar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataHandler = context.watch<ImatDataHandler>();
    final orders = dataHandler.orders;

    return Scaffold(
      body: Column(
        children: [
          // Navbaren högst upp
          TopNavbar(
            searchController: _searchController,
            // Gå tillbaka till startsidan
            onHomePressed: () => Navigator.pushNamed(context, '/'),
            onShopPressed: () => Navigator.pushNamed(context, '/'),
            onFavoritesPressed: () {
              dataHandler.selectFavorites();
              Navigator.pushNamed(context, '/');
            },
            onHistoryPressed: () {}, // Vi är redan här
            onSearchChanged: (value) {
              if (value.isEmpty) {
                dataHandler.selectAllProducts();
              } else {
                dataHandler.selectSelection(dataHandler.findProducts(value));
              }
              Navigator.pushNamed(context, '/');
            },
          ),
          
          // Innehållet under navbaren
          Expanded(
            child: SingleChildScrollView(
              // Använder padding från ditt AppTheme för att undvika "hopp"
              padding: const EdgeInsets.all(AppTheme.paddingLarge),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800), // Håller listan centrerad och snygg
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mina tidigare köp',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      if (orders.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Center(child: Text('Här var det tomt! Du har inte gjort några beställningar än.')),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];
                            return _buildOrderCard(order);
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    // Formaterar datum manuellt: YYYY-MM-DD
    String dateStr = "${order.date.year}-${order.date.month.toString().padLeft(2, '0')}-${order.date.day.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ExpansionTile(
        title: Text(
          'Order #${order.orderNumber} - $dateStr',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Totalt: ${order.getTotal().toStringAsFixed(2)} kr'),
        trailing: const Icon(Icons.keyboard_arrow_down, color: AppTheme.primaryGreen),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: order.items.map((item) {
                return ListTile(
                  leading: const Icon(Icons.shopping_basket_outlined, size: 20),
                  title: Text(item.product.name),
                  trailing: Text('${item.amount.toInt()} ${item.product.unit}'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}