import 'package:flutter/material.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImatDataHandler>(
      builder: (context, iMat, child) {
        List<String> crumbs = ["Startsida", "Handla"];

        if (iMat.isShowingFavorites) {
          crumbs.add("Mina favoriter");
        } else if (iMat.selectedCategory.isNotEmpty) {
          crumbs.add(iMat.selectedCategory);
        }

        return Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
          child: Row(
            children: crumbs.asMap().entries.map((entry) {
              int idx = entry.key;
              String label = entry.value;
              bool isLast = idx == crumbs.length - 1;

              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (label == "Startsida" || label == "Handla") {
                        iMat.setShowingFavorites(false);
                        iMat.setSelectedCategory("");
                      }
                    },
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        color: isLast ? Colors.black : Colors.grey[600],
                        fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(">", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}