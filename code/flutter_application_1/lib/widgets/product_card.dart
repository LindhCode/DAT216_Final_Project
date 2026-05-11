import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat/shopping_item.dart'; // Viktig import
import 'package:imat_app/model/imat_data_handler.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ImatDataHandler iMat;

  const ProductCard(this.product, this.iMat, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isFav = iMat.isFavorite(product);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.price.toStringAsFixed(2)} kr',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(product.unit, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey),
                onPressed: () => iMat.toggleFavorite(product),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: iMat.getImage(product),
              ),
            ),
          ),
          Text(
            product.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          
          // KNAPP: LÄGG TILL
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E8B37), // Din gröna färg
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              onPressed: () {
                // 1. Lägg till produkten i varukorgen
                final item = ShoppingItem(product, amount: 1.0);
                iMat.shoppingCartAdd(item);

                // 2. Visa feedback-rutan (SnackBar)
                ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Tar bort ev. tidigare ruta direkt
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white),
                        const SizedBox(width: 10),
                        Text('${product.name} lades till i varukorgen'),
                      ],
                    ),
                    backgroundColor: Colors.green, // Gör rutan grön
                    duration: const Duration(milliseconds: 1500), // Hur länge den syns (1.5 sek)
                    behavior: SnackBarBehavior.floating, // Gör att den ser ut som en "svävande ruta"
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(20), // Luft runt rutan så den inte nuddar kanterna
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 18),
                  SizedBox(width: 8),
                  Text('Lägg till', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}