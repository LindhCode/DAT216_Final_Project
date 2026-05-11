import 'package:flutter/material.dart';
import 'package:imat_app/widgets/top_navbar.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/model/imat/order.dart';
import 'package:imat_app/widgets/top_navbar.dart'; // Justera sökvägen om behövs
 // För snyggare datumformatering

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Vi lyssnar på ImatDataHandler för att få tillgång till order-listan
    final dataHandler = context.watch<ImatDataHandler>();
    final orders = dataHandler.orders;

    return Scaffold(
      body: Column(
        children: [
          // Din Navbar integrerad högst upp
    // Din Navbar integrerad högst upp i HistoryPage
      TopNavbar(
        searchController: _searchController,
        
        // Gå tillbaka och visa alla produkter
        onHomePressed: () {
          dataHandler.selectAllProducts();
          Navigator.pushNamed(context, '/');
        },
        
        // Gå tillbaka och visa shoppen (alla produkter)
        onShopPressed: () {
          dataHandler.selectAllProducts();
          Navigator.pushNamed(context, '/');
        },
        
        // Gå tillbaka och visa endast favoriter
        onFavoritesPressed: () {
          dataHandler.selectFavorites();
          Navigator.pushNamed(context, '/');
        },
        
        onHistoryPressed: () { 
          /* Vi är redan här, så vi gör ingenting */ 
        },
        
        // Sökning från historiksidan: filtrera och hoppa till startsidan för att se resultatet
        onSearchChanged: (value) {
          if (value.trim().isEmpty) {
            dataHandler.selectAllProducts();
          } else {
            dataHandler.selectSelection(dataHandler.findProducts(value));
          }
          // Hoppa till startsidan så användaren ser sökresultatet i GridView:n
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
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Om listan är tom, visa ett meddelande
                  if (orders.isEmpty)
                    const Center(
                      child: Text('Du har inte gjort några köp än.'),
                    )
                  else
                    // Lista alla ordrar
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
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    // Formatera datumet från din Order-modell
    String formattedDate = "${order.date.year}-${order.date.month.toString().padLeft(2, '0')}-${order.date.day.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.orderNumber}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            Text(
              '${order.getTotal().toStringAsFixed(2)} kr',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF689451), // primaryGreen från ditt AppTheme
              ),
            ),
          ],
        ),
        children: [
          // Här visas innehållet i ordern när man klickar på den
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
                // Här kan du lägga till logik för att "Köp igen"
                // genom att loopa igenom order.items och köra dataHandler.shoppingCartAdd
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Lägg till hela ordern i varukorg'),
            ),
          )
        ],
      ),
    );
  }
}