import 'dart:math';

import 'package:flutter/material.dart';

class PizzaScreen extends StatefulWidget {
  const PizzaScreen({super.key});

  @override
  State<PizzaScreen> createState() => _PizzaScreenState();
}

class _PizzaScreenState extends State<PizzaScreen> {
  int pizzaCount = 0;
  double price = 0;
  List<Map<String, dynamic>> selectedToppings = [];
  final GlobalKey _pizzaKey = GlobalKey();

  Widget _toppingIcon(String asset) {
    return GestureDetector(
      onTap: () {
        final RenderBox box =
            _pizzaKey.currentContext?.findRenderObject() as RenderBox;
        final Size pizzaSize = box.size;

        final double radius = pizzaSize.width / 2 - 30; // leave some padding
        final double centerX = pizzaSize.width / 2 - 20;
        final double centerY = pizzaSize.height / 2 - 20;

        final double angle = Random().nextDouble() * pi;
        final double distance =
            (Random().nextInt(90) + 10).toDouble() / 100 * radius;
        for (int i = 1; i <= pizzaCount; i++) {
          final double rotation = Random().nextDouble() * pi;
          final double x1 =
              centerX + distance * cos(angle + 2 * pi * i / pizzaCount);
          final double y1 =
              centerY + distance * sin(angle + 2 * pi * i / pizzaCount);
          /*final double x2 = centerX + distance * cos(angle + 2 * pi);
          final double y2 = centerY + distance * sin(angle + 2 * pi);
          final double x3 = centerX + distance * cos(angle + 4 * pi / 3);
          final double y3 = centerY + distance * sin(angle + 4 * pi / 3);
          final double x4 = centerX + distance * cos(angle + 3 * pi / 2);
          final double y4 = centerY + distance * sin(angle + 3 * pi / 2);*/
          setState(() {
            price += 0.05;
            final int randomIndex = Random().nextInt(
              selectedToppings.length + 1,
            );
            selectedToppings.insert(randomIndex, {
              'image': asset,
              'top': y1,
              'left': x1,
              'angle': rotation,
            });
            /*selectedToppings.add({
              'image': asset,
              'top': y2,
              'left': x2,
              'angle': angle2,
            });
            selectedToppings.add({
              'image': asset,
              'top': y3,
              'left': x3,
              'angle': angle3,
            });
            selectedToppings.add({
              'image': asset,
              'top': y4,
              'left': x4,
              'angle': angle4,
            });*/
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),

        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Image.asset(asset, fit: BoxFit.fill)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          SizedBox(height: 60),
          // Header with image
          Stack(
            children: [
              SizedBox(
                height: 300,
                child: Container(
                  key: _pizzaKey,
                  child: Image.asset('images/pizza_base.png'),
                ),
              ),
              ...selectedToppings.map((topping) {
                return Positioned(
                  top: topping['top'],
                  left: topping['left'],
                  child: Transform.rotate(
                    angle: topping['angle'],
                    child: Image.asset(topping['image'], width: 50, height: 50),
                  ),
                );
              }),
              Positioned(
                top: 40,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 0),

          // Counter
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFB14D28),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (pizzaCount != 0) {
                        pizzaCount--;
                      }
                    });
                  },
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Text(
                  (pizzaCount < 10) ? "0$pizzaCount" : "$pizzaCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      pizzaCount++;
                    });
                  },
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pepperoni Pizza",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(Icons.alarm, size: 18, color: Colors.grey),
                            SizedBox(width: 6),
                            Text(
                              "8-16 Min",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.whatshot, size: 18, color: Colors.grey),
                            SizedBox(width: 6),
                            Text(
                              "Medium",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(width: 16),
                            Icon(
                              Icons.local_fire_department,
                              size: 18,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "250 Kcal",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Baked to perfection on a crispy golden crust, this pizza delivers the perfect balance of bold flavors and cheesy goodness...",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Toppings
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Toppings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        _toppingIcon('images/mushroom.png'),
                        _toppingIcon('images/onion.png'),
                        _toppingIcon('images/pepperoni.png'),
                        _toppingIcon('images/feslegen.png'),
                        _toppingIcon('images/pineapple.png'),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Price and Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Price",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "\$${(price).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFB14D28),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Add to Bag",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
