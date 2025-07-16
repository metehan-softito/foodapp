import 'package:flutter/material.dart';
import 'package:kendin_ye/data/models/food_item.dart';
import 'package:kendin_ye/presentation/widgets/food_card.dart';
//import '../../core/localization/app_localizations.dart';

class CategoryScreen extends StatelessWidget {
  final FoodCategory category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    //final t = AppLocalizations.of(context).translate;
    final filteredItems = foodItems
        .where((item) => item.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7700),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          category.name,
          style: const TextStyle(
            fontFamily: 'SegoeUI',
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
}
