import 'package:flutter/material.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';
import 'package:kendin_ye/data/models/food_item.dart';
import 'package:kendin_ye/data/models/user.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7700),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Text(
          '${AppLocalizations.of(context).translate("hello")}, ${widget.user.firstName}!',
          style: const TextStyle(
            fontFamily: 'SegoeUI',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: CircleAvatar(
              backgroundImage: AssetImage(widget.user.profileImage),
            ),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(widget.user.profileImage),
                    ),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context).translate("profile")),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    const Icon(Icons.settings, color: Colors.black54),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context).translate("settings")),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: Colors.black54),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context).translate("logout")),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 2) {
                Navigator.pushReplacementNamed(context, '/');
              }
              // You can add logic for Profile and Settings later
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryIcons(context),
            _buildSearchBar(),
            _buildBestDealsSection(),
            const SizedBox(height: 8),
            Expanded(child: _buildFoodList()),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcons(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'label': 'Burgers',
        'icon': 'assets/icons/burger_icon.png',
        'category': FoodCategory.Burger,
      },
      {
        'label': 'Chicken',
        'icon': 'assets/icons/chicken_icon.png',
        'category': FoodCategory.Chicken,
      },
      {
        'label': 'Fries',
        'icon': 'assets/icons/fries_icon.png',
        'category': FoodCategory.Fries,
      },
      {
        'label': 'Sandwich',
        'icon': 'assets/icons/sandwic_icon.png',
        'category': FoodCategory.Sandwich,
      },
      {
        'label': 'Soda',
        'icon': 'assets/icons/soda_icon.png',
        'category': FoodCategory.Soda,
      },
      {
        'label': 'Breakfast',
        'icon': 'assets/icons/breakfast_icon.png',
        'category': FoodCategory.Breakfast,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((cat) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/category',
                    arguments: cat['category'], // passing enum
                  );
                },
                child: Column(
                  children: [
                    Image.asset(cat['icon'], width: 30, height: 30),
                    const SizedBox(height: 4),
                    Text(
                      cat['label'],
                      style: const TextStyle(
                        fontFamily: 'SegoeUI',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffff7700),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.search),
            hintText: 'Search your menu',
            suffixIcon: Icon(Icons.tune),
          ),
        ),
      ),
    );
  }

  Widget _buildBestDealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            'Best Deals!',
            style: TextStyle(
              fontFamily: 'SegoeUI',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              final item = foodItems[index];
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {'item': item, 'multiple': '1'},
                        );
                      },
                      child: Hero(
                        tag: '${item.name}1',
                        child: Image.asset(
                          item.imageName,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.name.length > 15
                        ? "${item.name.substring(0, 12)}..."
                        : item.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    '\$. ${item.priceUSD.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xffff7700),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildFoodList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        final item = foodItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: {'item': item, 'multiple': '2'},
                    );
                  },
                  child: Hero(
                    tag: '${item.name}2',
                    child: Image.asset(
                      item.imageName,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontFamily: 'SegoeUI',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          '\$. ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffff7700),
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          item.priceUSD.toStringAsFixed(2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffff7700),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          item.rating.toString(),
                          style: const TextStyle(color: Color(0xffff7700)),
                        ),
                        const SizedBox(width: 4),
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              Icons.star,
                              size: 16,
                              color: i < item.rating.round()
                                  ? const Color(0xffffbb00)
                                  : Colors.grey.shade300,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.remove_circle_outline, color: Color(0xffff7700)),
              const SizedBox(width: 4),
              const Text('--'),
              const SizedBox(width: 4),
              const Icon(Icons.add_circle_outline, color: Color(0xffff7700)),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  item.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: item.isLiked ? Colors.red : Colors.black54,
                ),
                onPressed: () {
                  setState(() {
                    item.isLiked = !item.isLiked;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
