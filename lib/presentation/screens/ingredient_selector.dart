import 'dart:math';

import 'package:flutter/material.dart';

class IngredientSelector extends StatefulWidget {
  const IngredientSelector({super.key});

  @override
  State<IngredientSelector> createState() => _IngredientSelectorState();
}

class _IngredientSelectorState extends State<IngredientSelector> {
  List<String> listem = [
    "Cheese-Stuffed_Beef_Patty.png",
    "Chicken_Katsu.png",
    "Chorizo_Patty_spicy.png",
    "Crispy_Fried_Chicken_Fillet.png",
    "Salmon_Steak.png",
    "Soft_Shell_Crab.png",
  ];

  int _currentPage = 0;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.55,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                "Burger Köftesi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 30,
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.6,
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
          value = (value * 0.03).clamp(-1, 1);

          final pageOffset =
              _pageController.page ?? _pageController.initialPage.toDouble();
          final difference = (pageOffset - index).abs();
          scale = (1 - (difference * 0.3)).clamp(
            0.7,
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
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/${listem[index]}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text("deneme 1"),
        ),
        Padding(padding: const EdgeInsets.all(10), child: Text("deneme 2")),
      ],
    );
  }
}
