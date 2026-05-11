import 'package:flutter/material.dart';
import 'package:imat_app/model/imat_data_handler.dart';

class CartSidebar extends StatelessWidget {
  final ImatDataHandler iMat;

  const CartSidebar({super.key, required this.iMat});

  @override
  Widget build(BuildContext context) {
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
                Text(
                  "Min varukorg",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(),
          
          // Här kommer listan på varor i framtiden
          const Expanded(
            child: Center(
              child: Text("Här visas dina varor"),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text("Töm varukorgen", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E8B37),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Gå till kassan",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}