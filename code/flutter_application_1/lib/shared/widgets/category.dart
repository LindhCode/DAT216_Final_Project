import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat_data_handler.dart';

/// Svenska etiketter för [ProductCategory] (samma enum som backend/JSON).
String _categoryLabelSv(ProductCategory c) {
  switch (c) {
    case ProductCategory.POD:
      return 'Baljväxter';
    case ProductCategory.BREAD:
      return 'Bröd';
    case ProductCategory.BERRY:
      return 'Bär';
    case ProductCategory.CITRUS_FRUIT:
      return 'Citrusfrukt';
    case ProductCategory.HOT_DRINKS:
      return 'Varma drycker';
    case ProductCategory.COLD_DRINKS:
      return 'Kalla drycker';
    case ProductCategory.EXOTIC_FRUIT:
      return 'Exotisk frukt';
    case ProductCategory.FISH:
      return 'Fisk';
    case ProductCategory.VEGETABLE_FRUIT:
      return 'Grönsaksfrukt';
    case ProductCategory.CABBAGE:
      return 'Kål';
    case ProductCategory.MEAT:
      return 'Kött';
    case ProductCategory.DAIRIES:
      return 'Mejeri';
    case ProductCategory.MELONS:
      return 'Meloner';
    case ProductCategory.FLOUR_SUGAR_SALT:
      return 'Mjöl, socker & salt';
    case ProductCategory.NUTS_AND_SEEDS:
      return 'Nötter & frön';
    case ProductCategory.PASTA:
      return 'Pasta';
    case ProductCategory.POTATO_RICE:
      return 'Potatis & ris';
    case ProductCategory.ROOT_VEGETABLE:
      return 'Rotfrukter';
    case ProductCategory.FRUIT:
      return 'Frukt';
    case ProductCategory.SWEET:
      return 'Sött';
    case ProductCategory.HERB:
      return 'Örter & kryddor';
    case ProductCategory.UNDEFINED:
      return 'Övrigt';
  }
}

class _CategoryGroup {
  final String title;
  final List<ProductCategory> categories;

  const _CategoryGroup(this.title, this.categories);
}

const List<_CategoryGroup> _kGroups = [
  _CategoryGroup('Grönsaker', [
    ProductCategory.VEGETABLE_FRUIT,
    ProductCategory.CABBAGE,
    ProductCategory.ROOT_VEGETABLE,
    ProductCategory.HERB,
  ]),
  _CategoryGroup('Frukt och Bär', [
    ProductCategory.BERRY,
    ProductCategory.CITRUS_FRUIT,
    ProductCategory.EXOTIC_FRUIT,
    ProductCategory.FRUIT,
    ProductCategory.MELONS,
  ]),
  _CategoryGroup('Kött', [ProductCategory.MEAT, ProductCategory.FISH]),
  _CategoryGroup('Kolhydrater', [
    ProductCategory.BREAD,
    ProductCategory.PASTA,
    ProductCategory.POTATO_RICE,
    ProductCategory.FLOUR_SUGAR_SALT,
  ]),
  _CategoryGroup('Drycker', [
    ProductCategory.HOT_DRINKS,
    ProductCategory.COLD_DRINKS,
  ]),
  _CategoryGroup('Mejeri', [ProductCategory.DAIRIES]),
  _CategoryGroup('Övrigt', [
    ProductCategory.POD,
    ProductCategory.NUTS_AND_SEEDS,
    ProductCategory.SWEET,
    ProductCategory.UNDEFINED,
  ]),
];

bool _categoryHasProducts(ImatDataHandler iMat, ProductCategory c) {
  return iMat.products.any((p) => p.category == c);
}

bool _isLeafActive(ImatDataHandler iMat, ProductCategory cat) {
  final inCategory = iMat.findProductsByCategory(cat);
  if (inCategory.isEmpty || iMat.selectProducts.isEmpty) return false;
  if (iMat.selectProducts.length != inCategory.length) return false;
  final ids = iMat.selectProducts.map((p) => p.productId).toSet();
  return inCategory.every((p) => ids.contains(p.productId));
}

class CategorySidebar extends StatefulWidget {
  final ImatDataHandler iMat;

  const CategorySidebar({super.key, required this.iMat});

  @override
  State<CategorySidebar> createState() => _CategorySidebarState();
}

class _CategorySidebarState extends State<CategorySidebar> {
  static const double _sidebarWidth = 250;

  /// Namn på öppnad huvudgrupp (accordion).
  String? _expandedGroupTitle;

  @override
  void initState() {
    super.initState();
    for (final g in _kGroups) {
      if (g.categories.any((c) => _categoryHasProducts(widget.iMat, c))) {
        _expandedGroupTitle = g.title;
        break;
      }
    }
  }

  void _toggleGroup(String title) {
    setState(() {
      _expandedGroupTitle = _expandedGroupTitle == title ? null : title;
    });
  }

  void _onPickCategory(ProductCategory cat) {
    final iMat = widget.iMat;
    final label = _categoryLabelSv(cat);
    iMat.setSelectedCategory(label);
    iMat.selectSelection(iMat.findProductsByCategory(cat));
  }

  @override
  Widget build(BuildContext context) {
    final iMat = widget.iMat;

    final listChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(
          AppTheme.paddingMedium,
          AppTheme.paddingLarge,
          AppTheme.paddingMedium,
          AppTheme.paddingMedium,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.filter_list,
              color: AppTheme.textMain,
              size: 28,
            ),
            const SizedBox(width: AppTheme.paddingSmall),
            const Text(
              'Kategorier',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textMain,
              ),
            ),
          ],
        ),
      ),
      Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.withValues(alpha: 0.35),
      ),
    ];

    for (final group in _kGroups) {
      final present =
          group.categories.where((c) => _categoryHasProducts(iMat, c)).toList();
      if (present.isEmpty) continue;
      listChildren.add(_buildGroupColumn(context, iMat, group, present));
      listChildren.add(
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.withValues(alpha: 0.35),
        ),
      );
    }
    if (listChildren.length > 2 && listChildren.last is Divider) {
      listChildren.removeLast();
    }

    return Material(
      color: AppTheme.sidebarBackground,
      child: SizedBox(
        width: _sidebarWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(padding: EdgeInsets.zero, children: listChildren),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupColumn(
    BuildContext context,
    ImatDataHandler iMat,
    _CategoryGroup group,
    List<ProductCategory> present,
  ) {
    final expanded = _expandedGroupTitle == group.title;
    final anyChildSelected = present.any((c) => _isLeafActive(iMat, c));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => _toggleGroup(group.title),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.paddingMedium,
              vertical: AppTheme.paddingMediumSmall,
            ),
            child: Row(
              children: [
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: AppTheme.textMain,
                  size: AppTheme.paddingLarge,
                ),
                const SizedBox(width: AppTheme.paddingSmall),
                Expanded(
                  child: Text(
                    group.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          expanded || anyChildSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                      color: AppTheme.textMain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          ...present.map((cat) => _buildSubItem(context, iMat, cat)),
      ],
    );
  }

  Widget _buildSubItem(
    BuildContext context,
    ImatDataHandler iMat,
    ProductCategory cat,
  ) {
    final label = _categoryLabelSv(cat);
    final selected = _isLeafActive(iMat, cat);

    return InkWell(
      onTap: () => _onPickCategory(cat),
      child: Padding(
        padding: const EdgeInsets.only(
          // Justerat för att linjera snyggt under texten i huvudgruppen (Icon 24px + Spacing 8px)
          left: AppTheme.paddingLarge + AppTheme.paddingSmall,
          right: AppTheme.paddingMedium,
          top: AppTheme.paddingSmall,
          bottom: AppTheme.paddingSmall,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? AppTheme.textMain : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
