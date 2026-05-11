import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat_data_handler.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ImatDataHandler iMat;

  const ProductCard(this.product, this.iMat, {super.key});

  @override
  Widget build(BuildContext context) {
    // Kollar favoritstatus via din handler
    bool isFav = iMat.isFavorite(product);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // En mjuk skugga gör att kortet poppar mer nu när knappen är borta
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      padding: const EdgeInsets.all(AppTheme.paddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Översta raden: Pris och Favorithjärta
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.price.toStringAsFixed(2)} kr',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textMain,
                    ),
                  ),
                  Text(
                    product.unit,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              
              // HJÄRTAT - Använder din toggleFavorite
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? AppTheme.accentRed : AppTheme.textMain,
                  size: 26, // Lite större ikon nu när det finns plats
                ),
                onPressed: () {
                  iMat.toggleFavorite(product);
                },
              ),
            ],
          ),

          // Produktbilden (Centrerad och tar upp platsen i mitten)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: iMat.getImage(product),
              ),
            ),
          ),

          const SizedBox(height: AppTheme.paddingTiny),

          // Produktens namn
          Text(
            product.name,
            maxLines: 2, // Tillåt två rader om namnet är långt
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textMain,
            ),
          ),
          
          // Extra info (t.ex. ursprung eller vikt)
          const Text(
            'Kravmärkt, klass 1',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 12,
            ),
          ),
          
          // Vi lägger till lite luft i botten för balans
          const SizedBox(height: AppTheme.paddingSmall),
        ],
      ),
    );
  }
}