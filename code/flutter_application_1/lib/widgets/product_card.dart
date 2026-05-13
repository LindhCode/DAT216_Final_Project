// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat/product.dart';
// import 'package:imat_app/model/imat/shopping_item.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:provider/provider.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;

//   // Vi använder namngivna parametrar {required this.product} 
//   // för att matcha anropet i main_view.dart
//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     // Vi hämtar iMat-handlaren via Provider istället för att skicka den som argument
//     final iMat = context.watch<ImatDataHandler>();
//     bool isFav = iMat.isFavorite(product);

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${product.price.toStringAsFixed(2)} kr',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Text(product.unit, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                 ],
//               ),
//               IconButton(
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//                 icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
//                     color: isFav ? Colors.red : Colors.grey),
//                 onPressed: () => iMat.toggleFavorite(product),
//               ),
//             ],
//           ),
//           Expanded(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: iMat.getImage(product),
//               ),
//             ),
//           ),
//           Text(
//             product.name,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 8),
          
//           // KNAPP: LÄGG TILL
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2E8B37),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 elevation: 0,
//               ),
//               onPressed: () {
//                 // 1. Lägg till produkten i varukorgen
//                 final item = ShoppingItem(product, amount: 1.0);
//                 iMat.shoppingCartAdd(item);

//                 // 2. Visa feedback-rutan (SnackBar)
//                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Row(
//                       children: [
//                         const Icon(Icons.check_circle, color: Colors.white),
//                         const SizedBox(width: 10),
//                         Text('${product.name} lades till i varukorgen'),
//                       ],
//                     ),
//                     backgroundColor: Colors.green,
//                     duration: const Duration(milliseconds: 1500),
//                     behavior: SnackBarBehavior.floating,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     margin: const EdgeInsets.all(20),
//                   ),
//                 );
//               },
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.add_circle_outline, size: 18),
//                   SizedBox(width: 8),
//                   Text('Lägg till', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat/product.dart';
// import 'package:imat_app/model/imat/shopping_item.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:imat_app/app_theme.dart';
// import 'package:provider/provider.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final iMat = context.watch<ImatDataHandler>();
//     bool isFav = iMat.isFavorite(product);

//     return Container(
//       decoration: BoxDecoration(
//         color: AppTheme.cardBackground,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.grey.shade300, width: 1),
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(AppTheme.paddingMedium),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 1. PRIS & ENHET
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${product.price.toStringAsFixed(2).replaceFirst('.', ',')} kr',
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w900,
//                         color: AppTheme.textMain,
//                         fontFamily: 'Poppins',
//                         height: 1.0,
//                       ),
//                     ),
//                     Text(
//                       product.unit,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: AppTheme.textSecondary,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ],
//                 ),

//                 // 2. PRODUKTBILD (Tydlig och proportionell)
//                 Expanded(
//                   child: Center(
//                     child: SizedBox(
//                       height: 120, // Fast höjd för att kontrollera storleken
//                       child: iMat.getImage(product),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: AppTheme.paddingSmall),

//                 // 3. FLAGGA (Betydligt mindre) OCH NAMN
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "🇩🇪", 
//                       style: TextStyle(fontSize: 12), // Mycket mindre flagga
//                     ), 
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         product.name,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppTheme.textMain,
//                           fontFamily: 'Poppins',
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),

//                 // 4. EXTRA INFO (T.ex. vikt/klass)
//                 const Text(
//                   "ca 250g, Kravmärkt, klass 1",
//                   style: TextStyle(
//                     color: AppTheme.textSecondary,
//                     fontSize: 12,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),

//                 const SizedBox(height: AppTheme.paddingMedium),

//                 // 5. KNAPP: LÄGG I VARUKORG
//                 SizedBox(
//                   width: double.infinity,
//                   height: 46,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppTheme.primaryGreen,
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     onPressed: () {
//                       final item = ShoppingItem(product, amount: 1.0);
//                       iMat.shoppingCartAdd(item);
                      
//                       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('${product.name} lades till'),
//                           duration: const Duration(seconds: 1),
//                           behavior: SnackBarBehavior.floating,
//                           backgroundColor: AppTheme.primaryGreen,
//                         ),
//                       );
//                     },
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.add_box_outlined, size: 20),
//                         const SizedBox(width: 6),
//                         Text(
//                           'Lägg i varukorg',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // FAVORIT-HJÄRTA
//           Positioned(
//             top: 8,
//             right: 8,
//             child: IconButton(
//               icon: Icon(
//                 isFav ? Icons.favorite : Icons.favorite_border,
//                 color: isFav ? AppTheme.accentRed : AppTheme.textMain,
//                 size: 24,
//               ),
//               onPressed: () => iMat.toggleFavorite(product),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/app_theme.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();
    bool isFav = iMat.isFavorite(product);

    return Container(
      // Gör kortet lite mer avlångt och stilrent
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. PRIS (Tydligt uppe till vänster)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.price.toStringAsFixed(2).replaceFirst('.', ',')} kr',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textMain,
                        fontFamily: 'Poppins',
                        height: 1.0,
                      ),
                    ),
                    Text(
                      product.unit,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),

                // 2. PRODUKTBILD (Betydligt större yta)
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Hero(
                        tag: 'product_${product.name}',
                        child: Transform.scale(
                          scale: 1.2, // Gör bilden 20% större i containern
                          child: iMat.getImage(product),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // 3. FLAGGA & NAMN
                Row(
                  children: [
                    const Text("🇩🇪", style: TextStyle(fontSize: 10)), 
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textMain,
                          fontFamily: 'Poppins',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                // 4. INFO
                const Text(
                  "ca 250g, Kravmärkt, klass 1",
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 12),

                // 5. KNAPP (Mindre och mer proportionerlig)
                Center(
                  child: SizedBox(
                    width: 140, // Fast mindre bredd för att inte täcka hela botten
                    height: 38, // Något lägre höjd
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        final item = ShoppingItem(product, amount: 1.0);
                        iMat.shoppingCartAdd(item);
                        
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} tillagd'),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppTheme.primaryGreen,
                            width: 200,
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_shopping_cart, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Köp',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // FAVORIT-HJÄRTA
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? AppTheme.accentRed : AppTheme.textMain.withOpacity(0.5),
                size: 22,
              ),
              onPressed: () => iMat.toggleFavorite(product),
            ),
          ),
        ],
      ),
    );
  }
}
