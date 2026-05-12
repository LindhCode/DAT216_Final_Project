import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/model/imat/order.dart';
import 'package:imat_app/model/imat/shopping_item.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataHandler = context.watch<ImatDataHandler>();
    final orders = dataHandler.orders;

    // VIKTIGT: Ingen Scaffold, ingen TopNavbar och ingen Column runt allt här.
    // Vi returnerar bara scroll-vyn eftersom MainView sköter resten.
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mina tidigare köp',
            style: TextStyle(
              fontSize: 32, 
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          
          if (orders.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text('Du har inte gjort några köp än.'),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(context, orders[index], dataHandler);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order, ImatDataHandler dataHandler) {
    String dateStr = "${order.date.year}-${order.date.month.toString().padLeft(2, '0')}-${order.date.day.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
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
            Text(
              '${order.getTotal().toStringAsFixed(2)} kr', 
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF689451)),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: order.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item.amount.toInt()}x ${item.product.name}'),
                      Text('${(item.product.price * item.amount).toStringAsFixed(2)} kr'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextButton.icon(
              onPressed: () {
                for (var item in order.items) {
                  dataHandler.shoppingCartAdd(ShoppingItem(item.product, amount: item.amount));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order #${order.orderNumber} tillagd i varukorgen!'),
                    backgroundColor: const Color(0xFF689451),
                  )
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