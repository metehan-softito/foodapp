import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';
import 'package:kendin_ye/data/models/food_item.dart';
import 'package:kendin_ye/data/models/user.dart';
import 'package:kendin_ye/presentation/screens/burger_screen.dart';
import 'package:kendin_ye/presentation/screens/pizza_screen.dart';
import 'package:kendin_ye/presentation/screens/sushi_screen.dart';
import 'package:kendin_ye/presentation/widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  bool isSideMenuClosed = true;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildContentByIndex(int index) {
    switch (index) {
      case 2:
        return SafeArea(
          child: Container(
            color: Color(0xFFFFFAF0), //white
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMyAppBar(context),
                _buildCategoryIcons(context),
                _buildSearchBar(),
                _buildBestDealsSection(),
                const SizedBox(height: 8),
                Expanded(child: _buildFoodList()),
              ],
            ),
          ),
        );
      case 0:
        return BurgerScreen();
      case 1:
        return PizzaScreen();
      case 3:
        return SushiScreen();
      default:
        return Container();
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            if (index == 4) {
              if (isSideMenuClosed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isSideMenuClosed = !isSideMenuClosed;
              });
            } else {
              _selectedIndex = index;
            }
          });
        },
      ),*/
      backgroundColor: const Color(0xFFFFC58B),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(microseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: isSideMenuClosed ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: _buildShoppingCart(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      isSideMenuClosed ? 0 : 24,
                    ),
                    child: SafeArea(
                      child: Container(
                        color: Color(0xFFFFFAF0), //white
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMyAppBar(context),
                            _buildCategoryIcons(context),
                            _buildSearchBar(),
                            _buildBestDealsSection(),
                            const SizedBox(height: 8),
                            Expanded(child: _buildFoodList()),
                          ],
                        ),
                      ),
                    ),
                    //_buildContentByIndex(_selectedIndex),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyAppBar(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      color: const Color(0xFFFF7700),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        height: kToolbarHeight + 28, // similar to AppBar height
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppLocalizations.of(context).translate("hello")}, ${widget.user.firstName}!',
              style: const TextStyle(
                fontFamily: 'SegoeUI',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                // Cart Icon with badge
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      color: Colors.white,
                      onPressed: () {
                        if (isSideMenuClosed) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                        setState(() {
                          isSideMenuClosed = !isSideMenuClosed;
                        });
                      },
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),

                // Profile Popup
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
                            backgroundImage: AssetImage(
                              widget.user.profileImage,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context).translate("profile"),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          const Icon(Icons.settings, color: Colors.black54),
                          const SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context).translate("settings"),
                          ),
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
                          Text(
                            AppLocalizations.of(context).translate("logout"),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 2) {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                ),
              ],
            ),
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
          children: [
            ...categories.map((cat) {
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
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pizza');
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/pizza_renkli.png",
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Pizza",
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/burger');
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/burger_renkli.png",
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Burger",
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
            ),
          ],
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

  Widget _buildShoppingCart() {
    // Filter the cart items
    final List<FoodItem> cartItems = foodItems
        .where((item) => item.isInCart)
        .toList();

    return Container(
      width: 288,
      height: double.infinity,
      color: const Color(0xFFFFC58B), // Light peach background
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            // Toggle Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Shopping Cart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3D00),
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    if (isSideMenuClosed) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                    setState(() {
                      isSideMenuClosed = !isSideMenuClosed;
                    });
                  },
                ),
              ],
            ),

            const Divider(),

            // Cart List
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(child: Text("Your cart is empty"))
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Dismissible(
                          key: Key(item.name),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              // Set isInCart = false in the original list
                              final int originalIndex = foodItems.indexOf(item);
                              if (originalIndex != -1) {
                                foodItems[originalIndex].isInCart = false;
                              }
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${item.name} removed from cart"),
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              item.imageName,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.name),
                            subtitle: Text(
                              "₺${item.priceTL.toStringAsFixed(2)}",
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(thickness: 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5C3D00),
                        ),
                      ),
                      Text(
                        '₺${cartItems.fold(0.0, (sum, item) => sum + item.priceTL).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5C3D00),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffff7700),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Add checkout logic here
                      },
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
