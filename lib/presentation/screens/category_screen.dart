import 'package:flutter/material.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';
import 'package:kendin_ye/data/globals.dart';
import 'package:kendin_ye/data/models/food_item.dart';
import 'package:kendin_ye/presentation/widgets/food_card.dart';

class CategoryScreen extends StatelessWidget {
  final FoodCategory category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var filteredItems = globalFoodItems
        .where((item) => item.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        title: Text(
          _translateCategoryName(
            category,
            AppLocalizations.of(context).isTurkish,
          ),
          style: TextStyle(
            fontFamily: 'SegoeUI',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GridView.builder(
          itemCount: filteredItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (context, index) => FoodCard(item: filteredItems[index]),
        ),
      ),
    );
  }

  String _translateCategoryName(FoodCategory category, bool isTurkish) {
    switch (category) {
      case FoodCategory.burger:
        return isTurkish ? 'Burgerler' : 'Burgers';
      case FoodCategory.chicken:
        return isTurkish ? 'Tavuklar' : 'Chickens';
      case FoodCategory.fries:
        return isTurkish ? 'Kızartmalar' : 'Fries';
      case FoodCategory.sandwich:
        return isTurkish ? 'Sandviçler' : 'Sandwiches';
      case FoodCategory.soda:
        return isTurkish ? 'Gazlı İçecekler' : 'Sodas';
      case FoodCategory.breakfast:
        return isTurkish ? 'Kahvaltılar' : 'Breakfasts';
      case FoodCategory.ingredient:
        return isTurkish ? 'İçerikler' : 'Ingredients';
      case FoodCategory.sushi:
        return isTurkish ? 'Suşi' : 'Sushi';
    }
  }
}
