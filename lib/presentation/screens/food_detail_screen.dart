import 'package:flutter/material.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';
import 'package:kendin_ye/data/models/food_item.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem foodItem;
  final String multiple;

  const FoodDetailScreen({
    super.key,
    required this.foodItem,
    required this.multiple,
  });

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool isLiked = false;
  int likeCount = 123; // example static value

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final newPage = _pageController.page?.round();
      if (newPage != _currentPage && newPage != null) {
        setState(() => _currentPage = newPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context).translate;
    final isTurkish = AppLocalizations.of(context).isTurkish;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          isTurkish ? widget.foodItem.nameTr : widget.foodItem.name,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.foodItem.name + widget.multiple,
                    child: Image.asset(
                      widget.foodItem.imageName,
                      width: 350,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 10 : 8,
                    height: _currentPage == index ? 10 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),

              // PageView with 3 pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    // Page 1: Description, price, rank, like
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isTurkish
                                ? widget.foodItem.descriptionTr
                                : widget.foodItem.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            isTurkish
                                ? "${translate('price')}: ${widget.foodItem.priceTL.toStringAsFixed(2)} ₺"
                                : "${translate('price')}: \$ ${widget.foodItem.priceUSD.toStringAsFixed(2)}",
                          ),
                          Row(
                            children: [
                              Text(
                                "${translate('rating')}: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < widget.foodItem.rating.floor()
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 20,
                                    color: Colors.amber,
                                  );
                                }),
                              ),
                              Text(
                                "  ${widget.foodItem.rating.toStringAsFixed(1)} / 5",
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isLiked ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isLiked = !isLiked;
                                        likeCount += isLiked ? 1 : -1;
                                      });
                                    },
                                  ),
                                  Text('$likeCount ${translate('likes')}'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Page 2: Nutritional Information
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              translate("nutritional_information"),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.foodItem.calories} CAL.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(translate("calories")),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "32G",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "${translate('total_fat')} (39% DV)",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "42 G",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "${translate('total_carbs')} (16% DV)",
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "24 G",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text("Protein"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Page 3: Placeholder
                    Center(
                      child: Text(
                        translate('coming_soon'),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              // View Ingredients Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed('/ingredients', arguments: widget.foodItem);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('view_ingredients'),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
