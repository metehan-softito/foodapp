import 'package:flutter/material.dart';
import 'package:kendin_ye/data/models/food_item.dart';

class IngredientsScreen extends StatelessWidget {
  final FoodItem food;

  const IngredientsScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final List<FoodItem> ingredients = [
      FoodItem(
        imageName: 'assets/images/ingredients/temp/artisan_bun.png',
        name: 'Artisan Bun',
        description: 'Grilled bun with susams.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.Ingredient,
      ),
      FoodItem(
        imageName: 'assets/images/ingredients/temp/buttermilk.png',
        name: 'Buttermilk Crispy Chicken Fillet',
        description: 'Perfectly cooked chicken fillets.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.Ingredient,
      ),
      FoodItem(
        imageName: 'assets/images/ingredients/temp/lettuce.png',
        name: 'Shredded Lettuce',
        description: 'Just healthy.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.Ingredient,
      ),
      FoodItem(
        imageName: 'assets/images/ingredients/temp/tomato.png',
        name: 'Italian Tomato',
        description: 'Very healty.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.Ingredient,
      ),
      FoodItem(
        imageName: 'assets/images/ingredients/temp/mayonnaise.png',
        name: 'Mayonnaise',
        description: 'Goes perfcet with some fries.',
        calories: 450,
        nutrients: 'Protein, Carbs, Fat',
        rating: 4.2,
        isLiked: true,
        priceTL: 110.0,
        priceUSD: 3.95,
        category: FoodCategory.Ingredient,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xaaff7700),
        elevation: 0,
        centerTitle: true,
        title: Text(
          food.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        color: Color(0xaaff7700),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Center(
              child: Column(
                children: [
                  Image.asset(food.imageName, width: 220, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  const Text(
                    "INGREDIENTS",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                            color: const Color(0xccff7700),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
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
                                item.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
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
                          color: const Color(0xccff7700),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
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
                            children: const [
                              Text(
                                "VIEW\nNUTRITION\nSUMMARY",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: 10),
                              Icon(
                                Icons.arrow_forward,
                                size: 32,
                                color: Colors.white,
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
