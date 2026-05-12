import 'package:flutter/material.dart';
import 'package:imat_app/widgets/top_navbar.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/model/imat/order.dart';
import 'package:imat_app/model/imat/shopping_item.dart'; // Lade till denna import!
import 'package:imat_app/app_theme.dart';

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
          TopNavbar(
            searchController: _searchController,
            onHomePressed: () {
              dataHandler.selectAllProducts();
              Navigator.pushNamed(context, '/');
            },
            onShopPressed: () {
              dataHandler.selectAllProducts();
              Navigator.pushNamed(context, '/');
            },
            onFavoritesPressed: () {
              dataHandler.selectFavorites();
              Navigator.pushNamed(context, '/');
            },
            onHistoryPressed: () {}, 
            onSearchChanged: (value) {
              if (value.trim().isEmpty) {
                dataHandler.selectAllProducts();
              } else {
                dataHandler.selectSelection(dataHandler.findProducts(value));
              }
              Navigator.pushNamed(context, '/');
            },
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mina tidigare köp',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  
                  if (orders.isEmpty)
                    const Center(child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text('Du har inte gjort några köp än.'),
                    ))
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return _buildOrderCard(orders[index], dataHandler);
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order, ImatDataHandler dataHandler) {
    // FIX 1: Manuell formatering av datum för att slippa 'DateFormat' felmeddelandet
    String dateStr = "${order.date.year}-${order.date.month.toString().padLeft(2, '0')}-${order.date.day.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order #${order.orderNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(dateStr, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            Text('${order.getTotal().toStringAsFixed(2)} kr', 
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF689451))),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: order.items.map((item) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${item.amount.toInt()}x ${item.product.name}'),
                    Text('${(item.product.price * item.amount).toStringAsFixed(2)} kr'),
                  ],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextButton.icon(
              onPressed: () {
                // FIX 2: Skapa ett ShoppingItem istället för att bara skicka Product
                for (var item in order.items) {
                  // Vi skapar ett nytt objekt som din backend förstår
                  dataHandler.shoppingCartAdd(ShoppingItem(item.product, amount: item.amount));
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order #${order.orderNumber} tillagd i varukorgen!'), backgroundColor: const Color(0xFF689451))
                );
              },
              icon: const Icon(Icons.refresh, color: Color(0xFF689451)),
              label: const Text('Köp igen', style: TextStyle(color: Color(0xFF689451))),
            ),
          )
        ],
      ),
    );
  }
}