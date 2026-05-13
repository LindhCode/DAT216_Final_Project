import 'package:flutter/material.dart';
import 'package:imat_app/model/imat_data_handler.dart';

class CategorySidebar extends StatelessWidget {
  final ImatDataHandler iMat;

  const CategorySidebar({super.key, required this.iMat});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFFE0E0E0),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Kategorier",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          _sidebarItem(Icons.keyboard_arrow_down, "Grönsaker", isSelected: true),
          _sidebarSubItem("Tyska gurkor", isSelected: true),
          _sidebarSubItem("Franska bär"),
          _sidebarItem(Icons.keyboard_arrow_right, "Frukt och Bär"),
          _sidebarItem(Icons.keyboard_arrow_right, "Kött"),
          _sidebarItem(Icons.keyboard_arrow_right, "Kolhydrater"),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String title, {bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      ),
      onTap: () {},
    );
  }

  Widget _sidebarSubItem(String title, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}