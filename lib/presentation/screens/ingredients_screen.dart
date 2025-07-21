import 'package:flutter/material.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';
import 'package:kendin_ye/data/models/food_item.dart';

class IngredientsScreen extends StatelessWidget {
  final FoodItem food;

  const IngredientsScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context).translate;
    final isTurkish = AppLocalizations.of(context).isTurkish;
    final List<FoodItem> ingredients = [
      FoodItem(
        imageName: 'assets/images/ingredients/temp/artisan_bun.png',
        name: 'Artisan Bun',
        nameTr: 'Burger Ekmeği',
        description: 'Grilled bun with susams.',
        descriptionTr: 'Kızarmış susamlı ekmek.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        nutrientsTr: 'Protein, Karbonhidrat, Yağ',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.ingredient,
        isInCart: false,
      ),
      FoodItem(
        imageName: 'assets/images/ingredients/temp/buttermilk.png',
        name: 'Buttermilk Crispy Chicken Fillet',
        nameTr: 'Çıtır Tavuk Parçaları',
        description: 'Perfectly cooked chicken fillets.',
        descriptionTr: 'Mükkemmel pişmiş fileto tavuk.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        nutrientsTr: 'Protein, Karbonhidrat, Yağ',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.ingredient,
        isInCart: false,
      ),
      FoodItem(
        imageName: 'assets/images/ingredients/temp/lettuce.png',
        name: 'Shredded Lettuce',
        nameTr: 'Kıvırcık Marul',
        description: 'Just healthy.',
        descriptionTr: 'Sadece sağlıklı.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        nutrientsTr: 'Protein, Karbonhidrat, Yağ',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.ingredient,
        isInCart: false,
      ),
      FoodItem(
        imageName: 'assets/images/ingredients/temp/tomato.png',
        name: 'Italian Tomato',
        nameTr: 'Domates',
        description: 'Very healty.',
        descriptionTr: 'Çok sağlıklı',
        calories: 450,
        nutrientsTr: 'Protein, Karbonhidrat, Yağ',
        nutrients: 'Protein, Carbs, Fat',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.ingredient,
        isInCart: false,
      ),
      FoodItem(
        imageName: 'assets/images/ingredients/temp/mayonnaise.png',
        name: 'Mayonnaise',
        nameTr: 'Mayonez',
        description: 'Goes perfcet with some fries.',
        descriptionTr: 'Patateslerin vazgeçilmezi.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        nutrientsTr: 'Protein, Karbonhidrat, Yağ',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.ingredient,
        isInCart: false,
      ),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          isTurkish ? food.nameTr : food.name,
          style: TextStyle(
            //color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Center(
              child: Column(
                children: [
                  Image.asset(food.imageName, width: 220, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  Text(
                    translate('ingredients'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      //color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemCount: ingredients.length + 1,
                itemBuilder: (context, index) {
                  if (index < ingredients.length) {
                    final item = ingredients[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {'item': item, 'multiple': '3'},
                        );
                      },
                      child: Hero(
                        tag: '${item.name}3',
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(item.imageName, width: 80),
                              const SizedBox(height: 8),
                              Text(
                                isTurkish ? item.nameTr : item.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontSize: 14,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to nutrition summary
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translate('view_nutrition_summary'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: 10),
                              Icon(
                                Icons.arrow_forward,
                                size: 32,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
