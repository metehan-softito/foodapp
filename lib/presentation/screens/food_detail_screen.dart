import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0x88ff7700),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.foodItem.name,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: const Color(0x88ff7700),
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
                          ? Color(0xffff7700)
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
                            widget.foodItem.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Price: \$${widget.foodItem.priceUSD.toStringAsFixed(2)}",
                          ),
                          Row(
                            children: [
                              Text(
                                "Rating: ",
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
                                  Text('$likeCount likes'),
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
                            child: const Text(
                              "Nutritional Information",
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
                                children: const [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "550 CAL.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text("Calories"),
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
                                      Text("Total Fat (39% DV)"),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
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
                                      Text("Total Carbs (16% DV)"),
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
                    const Center(
                      child: Text(
                        "Coming Soon...",
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
                    backgroundColor: const Color(0xFFFF7700),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "View Ingredients",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
