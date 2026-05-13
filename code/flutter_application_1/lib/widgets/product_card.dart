import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart'; // Viktigt!

class ProductCard extends StatelessWidget {
  final Product product;

  // Vi tar bara emot produkten. Enkelt och tydligt.
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Vi hämtar iMat här inne istället för att skicka med den som argument
    final iMat = context.read<ImatDataHandler>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.paddingSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bilden
            Expanded(
              child: iMat.getImage(product),
            ),
            const SizedBox(height: 8),
            // Namn
            Text(
              product.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Pris
            Text(
              '${product.price.toStringAsFixed(2)} ${product.unit}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}