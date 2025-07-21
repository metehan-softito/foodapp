import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';
import 'package:kendin_ye/data/globals.dart';
import 'package:kendin_ye/data/models/food_item.dart';
import 'package:kendin_ye/main.dart';

class IngredientSelector extends StatefulWidget {
  const IngredientSelector({super.key});

  @override
  State<IngredientSelector> createState() => _IngredientSelectorState();
}

class _IngredientSelectorState extends State<IngredientSelector> {
  List<FoodItem> listem = globalFoodItems
      .where((i) => i.category == FoodCategory.ingredient)
      .toList();

  final int _currentPage = 0;
  late PageController _pageController;
  double _totalPrice = 0;
  int _totalCalories = 0;
  String _selectedCategory = 'all';
  final List<String> _categories = [
    'all',
    'burger_patty',
    'sauces',
    'toppings',
  ];

  late bool _isRealistic;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.55,
    );
    _isRealistic = appKey.currentState?.themeMode == ThemeMode.dark;

    _imageList = [
      "assets/images/ingredients/buns/bottom_bun.png",
      "assets/images/ingredients/buns/top_bun.png",
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  List<String> _imageList = [];
  void _addImage(String img) {
    setState(() {
      _imageList.insert(_imageList.length - 1, img);
    });
  }

  String _imagePath(String original) {
    if (original.isEmpty) {
      return original;
    }
    if (Theme.of(context).brightness == Brightness.dark) {
      final segments = original.split('/');
      if (segments.length > 1 &&
          (segments.contains('buns') || segments.contains('burger_patty'))) {
        // insert 'realistic' folder before the file name
        segments.insert(segments.length - 1, 'realistic');
        return segments.join('/');
      }
    }
    return original;
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context).translate;
    final isTurkish = AppLocalizations.of(context).isTurkish;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Stack(
          children: [
            Positioned(
              top: 36,
              left: 0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    translate('select_burger_ingredient'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 28,
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 0.7,
                  child: PageView.builder(
                    itemCount: listem.length,
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return carouselView(index);
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        left: 30,
                        bottom: -97,
                        child: Image.asset(
                          'assets/images/ingredients/burger_tray.png',
                          width: 350,
                          height: 350,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: 90,
                        left: 140,
                        child: Image.asset(
                          'assets/images/ingredients/pack_of_fries.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: 75,
                        left: 155,
                        child: Image.asset(
                          'assets/images/ingredients/pack_of_fries.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: 60,
                        left: 170,
                        child: Image.asset(
                          'assets/images/ingredients/pack_of_fries.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: 40,
                        left: 205,
                        child: Image.asset(
                          'assets/images/ingredients/temp/mayonnaise.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: 60,
                        left: -20,
                        child: Image.asset(
                          'assets/images/ingredients/soda_cup.png',
                          width: 140,
                          height: 140,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: 60,
                        left: -20,
                        child: Image.asset(
                          'assets/images/ingredients/soda_cup.png',
                          width: 140,
                          height: 140,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: 30,
                        left: -5,
                        child: Image.asset(
                          'assets/images/ingredients/soda_cup.png',
                          width: 140,
                          height: 140,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,

              child: Padding(
                padding: const EdgeInsets.only(top: 420.0, left: 25),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        translate("total_price"),
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        isTurkish
                            ? "${_totalPrice.toStringAsFixed(2)}₺"
                            : "\$${_totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,

              child: Padding(
                padding: const EdgeInsets.only(top: 420.0, right: 20),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        translate("total_calories"),
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            size: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$_totalCalories kcal',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Category dropdown
                    DropdownButton<String>(
                      value: _selectedCategory,
                      underline: const SizedBox(), // remove default underline
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                      items: _categories.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(translate(cat)),
                        );
                      }).toList(),
                      onChanged: (newCat) {
                        if (newCat == null) return;
                        setState(() => _selectedCategory = newCat);
                        if (newCat == 'all') {
                          listem = globalFoodItems
                              .where(
                                (i) => i.category == FoodCategory.ingredient,
                              )
                              .toList();
                        } else {
                          listem = globalFoodItems
                              .where(
                                (i) =>
                                    i.category == FoodCategory.ingredient &&
                                    i.imageName.contains(newCat),
                              )
                              .toList();
                        }
                      },
                    ),

                    // Theme switch (Realistic <-> Cartoon)
                    Row(
                      children: [
                        Icon(
                          _isRealistic
                              ? Icons.nightlight_round
                              : Icons.wb_sunny,
                          color: Theme.of(context).primaryColor,
                        ),
                        Switch(
                          value: _isRealistic,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (v) {
                            setState(() => _isRealistic = v);
                            appKey.currentState?.setThemeMode(
                              v ? ThemeMode.dark : ThemeMode.light,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: i * 15.0,
                        //burayı daha sonra sos eklendiyse daha az, köfte eklendiyse daha çok yapıcam / ya da her görsele yükseklik belirlenebilir
                        child: Image.asset(
                          _imagePath(_imageList[i]),
                          width: 120,
                          height: 120,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            /*Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: double.infinity,
                width: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (int i = 0; i < _imageList.length; i++)
                      Positioned(
                        bottom: _imageList[i].contains('tray') ? -15:(_imageList[i].contains('fries')?50:0),
                        left: _imageList[i].contains('tray') ? width/2-150:(_imageList[i].contains('fries')?50:0),
                        //burayı daha sonra sos eklendiyse daha az, köfte eklendiyse daha çok yapıcam / ya da her görsele yükseklik belirlenebilir
                        child: Image.asset(
                          'assets/images/ingredients/trays/burger_tray.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                  ],
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }

  Widget carouselView(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        double scale = 0.7;

        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.035).clamp(-1, 1);

          final pageOffset =
              _pageController.page ?? _pageController.initialPage.toDouble();
          final difference = (pageOffset - index).abs();
          scale = (1 - (difference * 0.5)).clamp(
            0.6,
            1.0,
          ); // Scale down side items
        }
        return Transform.scale(
          scale: scale,
          child: Transform.rotate(
            angle: pi * value,
            child: carouselCard(index),
          ),
        );
      },
    );
  }

  Widget carouselCard(int index) {
    final item = listem[index];
    final isTurkish = AppLocalizations.of(context).isTurkish;
    final name = isTurkish ? item.nameTr : item.name;
    final description = isTurkish ? item.descriptionTr : item.description;
    final calories = item.calories;
    final nutrients = isTurkish ? item.nutrientsTr : item.nutrients;
    final price = isTurkish
        ? '${item.priceTL.toStringAsFixed(2)} ₺'
        : '\$${item.priceUSD.toStringAsFixed(2)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with top‐corner radius
        ClipRRect(
          //borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.asset(
            _imagePath(item.imageName),
            height: 200,
            width: double.infinity,
            //fit: BoxFit.cover,
          ),
        ),

        // Padding around text content
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),

              // Description
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),

              // Nutritional info / calories
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$calories kcal',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.health_and_safety,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      nutrients,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Price and add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addImage(item.imageName);
                      _totalPrice += isTurkish ? item.priceTL : item.priceUSD;
                      _totalCalories += item.calories;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(32, 32),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(Icons.add, size: 20, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
