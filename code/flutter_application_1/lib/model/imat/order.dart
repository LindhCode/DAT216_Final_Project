import 'dart:convert';

import 'package:imat_app/model/imat/shopping_item.dart';

class Order {
  int orderNumber;
  DateTime date;
  List<ShoppingItem> items;

  Order(this.orderNumber, this.date, this.items);

  factory Order.fromJson(Map<String, dynamic> json) {
    int orderNumber = json[_orderNumber] as int;
    int timeStamp = json[_date] as int;
    var jsonItems = json[_items];

    List<ShoppingItem> items = [];

    // Handle null or missing items
    if (jsonItems != null && jsonItems is List) {
      for (int i = 0; i < jsonItems.length; i++) {
        try {
          ShoppingItem item = ShoppingItem.fromJson(jsonItems[i]);
          items.add(item);
        } catch (e) {
          print('Error parsing shopping item at index $i: $e');
        }
      }
    }
    return Order(
      orderNumber,
      DateTime.fromMillisecondsSinceEpoch(timeStamp),
      items,
    );
  }

  Map<String, dynamic> toJson() => {
    _orderNumber: orderNumber,
    _date: date.millisecondsSinceEpoch,
    _items: items.map((item) => item.toJson()).toList(),
  };

  double getTotal() {
    var total = 0.0;

    for (final item in items) {
      total = total + item.product.price * item.amount;
    }
    return total;
  }

  static const _orderNumber = 'orderNumber';
  static const _date = 'date';
  static const _items = 'items';
}
