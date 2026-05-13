import 'package:flutter/material.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

class CartSidebar extends StatelessWidget {
  final VoidCallback onCheckout;

  const CartSidebar({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImatDataHandler>(
      builder: (context, iMat, child) {
        final items = iMat.getShoppingCart().items;

        return Container(
          width: 300,
          color: const Color(0xFFEEEEEE),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 30),
                    SizedBox(width: 10),
                    Text("Min varukorg", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: items.isEmpty
                    ? const Center(child: Text("Varukorgen är tom"))
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                                      Text("${item.product.price.toStringAsFixed(2)} kr", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline, color: Colors.black54),
                                      onPressed: () => iMat.shoppingCartUpdate(item, delta: -1.0),
                                    ),
                                    Text("${item.amount.toInt()}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline, color: Colors.black54),
                                      onPressed: () => iMat.shoppingCartUpdate(item, delta: 1.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Totalt:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("${iMat.shoppingCartTotal().toStringAsFixed(2)} kr", 
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: items.isEmpty ? null : () => iMat.shoppingCartClear(),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(double.infinity, 40)),
                      child: const Text("Töm varukorgen", style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: items.isEmpty ? null : onCheckout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E8B37),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Gå till kassan", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}