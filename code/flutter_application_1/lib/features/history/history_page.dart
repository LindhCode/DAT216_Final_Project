import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/model/imat/order.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataHandler = context.watch<ImatDataHandler>();
    final orders = [...dataHandler.orders]..sort((a, b) => b.date.compareTo(a.date));

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: AppTheme.contentWidthNarrow,
          margin: const EdgeInsets.symmetric(vertical: AppTheme.paddingInset),
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mina Tidigare köp',
                style: AppTheme.pageHeadline,
              ),
              const SizedBox(height: AppTheme.paddingLarge),

              if (orders.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: AppTheme.paddingWide),
                    child: Text('Du har inte gjort några köp än.'),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(context, orders[index], dataHandler);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    Order order,
    ImatDataHandler dataHandler,
  ) {
    String dateStr =
        "${order.date.year}-${order.date.month.toString().padLeft(2, '0')}-${order.date.day.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadowBlack05,
            blurRadius: AppTheme.shadowBlurLarge,
            offset: AppTheme.shadowOffsetCard,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.orderNumber}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  dateStr,
                  style: const TextStyle(color: AppTheme.grey600),
                ),
              ],
            ),
            Text(
              '${order.getTotal().toStringAsFixed(2)} kr',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.colorBlack,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.paddingLarge),
            child: Column(
              children:
                  order.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.paddingTiny,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${item.amount.toInt()}x ${item.product.name}'),
                          Text(
                            '${(item.product.price * item.amount).toStringAsFixed(2)} kr',
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: AppTheme.paddingLarge,
              bottom: AppTheme.paddingMedium,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  for (var item in order.items) {
                    dataHandler.shoppingCartAdd(
                      ShoppingItem(item.product, amount: item.amount),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Order #${order.orderNumber} tillagd i varukorgen!',
                      ),
                      backgroundColor: AppTheme.primaryGreen,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: AppTheme.colorWhite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.paddingLarge,
                    vertical: AppTheme.paddingSmall,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  ),
                ),
                icon: const Icon(
                  Icons.refresh,
                  color: AppTheme.colorWhite,
                ),
                label: const Text(
                  'Lägg i varukorg',
                  style: TextStyle(color: AppTheme.colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
