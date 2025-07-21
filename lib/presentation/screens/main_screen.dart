import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';
import 'package:kendin_ye/data/globals.dart';
import 'package:kendin_ye/data/models/food_item.dart';
import 'package:kendin_ye/data/models/user.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late User currentUser;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late Future<List<FoodItem>> _futureItems;
  bool isSideMenuClosed = true;

  @override
  void initState() {
    currentUser = widget.user;

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

    _futureItems = loadFoodItems(context);
    super.initState();
  }

  Future<List<FoodItem>> loadFoodItems(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/data/food_items.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => FoodItem.fromJson(e)).toList();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /*String _imagePath(String original) {
    if (original.isEmpty) {
      return original;
    }
    if (AppLocalizations.of(context).isRealistic) {
      final segments = original.split('/');
      if (segments.length > 1 &&
          (segments.contains('buns') || segments.contains('burger_patty'))) {
        // insert 'realistic' folder before the file name
        segments.insert(segments.length - 1, 'realistic');
        return segments.join('/');
      }
    }
    return original;
  }*/

  //todo bottom navbar ekledikten sonra bu şekil
  /*Widget _buildContentByIndex(int index) {
    switch (index) {
      case 2:
        return SafeArea(
          child: Container(
            color: Theme.of(context).secondary, //white
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

  int _selectedIndex = 0;*/

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
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: FutureBuilder<List<FoodItem>>(
        future: _futureItems,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          globalFoodItems = snapshot.data!;
          return MediaQuery.removePadding(
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
                    ..rotateY(
                      animation.value - 30 * animation.value * pi / 180,
                    ),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.surface, //white
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
          );
        },
      ),
    );
  }

  Widget _buildMyAppBar(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        height: kToolbarHeight + 48, // similar to AppBar height
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppLocalizations.of(context).translate("hello")}, ${currentUser.firstName}!',
              style: TextStyle(
                fontFamily: 'SegoeUI',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Row(
              children: [
                // Cart Icon with badge
                _buildCartIcon(context),

                // Profile Popup
                PopupMenuButton<int>(
                  offset: const Offset(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: CircleAvatar(
                    backgroundImage:
                        currentUser.profileImage.startsWith('assets/')
                        ? AssetImage(currentUser.profileImage)
                        : FileImage(File(currentUser.profileImage)),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage:
                                currentUser.profileImage.startsWith('assets/')
                                ? AssetImage(currentUser.profileImage)
                                : FileImage(File(currentUser.profileImage)),
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
                          Icon(
                            Icons.settings,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
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
                          Icon(
                            Icons.logout,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context).translate("logout"),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 0) {
                      // Navigate and await updated user
                      final updated =
                          await Navigator.of(
                                context,
                              ).pushNamed('/profile', arguments: currentUser)
                              as User?;
                      if (updated != null) {
                        setState(() {
                          currentUser = updated;
                        });
                      }
                    } else if (value == 1) {
                      // Navigate and await updated user
                      final updated =
                          await Navigator.of(
                                context,
                              ).pushNamed('/settings', arguments: currentUser)
                              as User?;
                      if (updated != null) {
                        setState(() {
                          currentUser = updated;
                        });
                      }
                    } else if (value == 2) {
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
        'label': AppLocalizations.of(context).translate("burger"),
        'icon': 'assets/icons/burger_icon.png',
        'category': FoodCategory.burger,
      },
      {
        'label': AppLocalizations.of(context).translate("chicken"),
        'icon': 'assets/icons/chicken_icon.png',
        'category': FoodCategory.chicken,
      },
      {
        'label': AppLocalizations.of(context).translate("fries"),
        'icon': 'assets/icons/fries_icon.png',
        'category': FoodCategory.fries,
      },
      {
        'label': AppLocalizations.of(context).translate("sandwich"),
        'icon': 'assets/icons/sandwic_icon.png',
        'category': FoodCategory.sandwich,
      },
      {
        'label': AppLocalizations.of(context).translate("soda"),
        'icon': 'assets/icons/soda_icon.png',
        'category': FoodCategory.soda,
      },
      {
        'label': AppLocalizations.of(context).translate("breakfast"),

        'icon': 'assets/icons/breakfast_icon.png',
        'category': FoodCategory.breakfast,
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
                      Image.asset(
                        cat['icon'],
                        width: 30,
                        height: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cat['label'],
                        style: TextStyle(
                          fontFamily: 'SegoeUI',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
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
                      AppLocalizations.of(context).translate("pizza"),
                      style: TextStyle(
                        fontFamily: 'SegoeUI',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
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
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context).translate("burger"),
                      style: TextStyle(
                        fontFamily: 'SegoeUI',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
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
                  Navigator.pushNamed(context, '/sushi');
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/sushi_renkli.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context).translate("sushi"),
                      style: TextStyle(
                        fontFamily: 'SegoeUI',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
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
    final nonIngredientItems = globalFoodItems
        .where((f) => f.category != FoodCategory.ingredient)
        .toList();
    nonIngredientItems.sort(
      ((a, b) => (-1 * a.rating).compareTo((-1 * b.rating))),
    ); //en son burda kaldım
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            AppLocalizations.of(context).translate("best_deals"),
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
            itemCount: nonIngredientItems.length > 10
                ? 10
                : nonIngredientItems.length,
            itemBuilder: (context, index) {
              final item = nonIngredientItems[index];
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
                    AppLocalizations.of(context).isTurkish
                        ? (item.nameTr.length > 15
                              ? "${item.nameTr.substring(0, 12)}..."
                              : item.nameTr)
                        : (item.name.length > 15
                              ? "${item.name.substring(0, 12)}..."
                              : item.name),
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    AppLocalizations.of(context).isTurkish
                        ? '${item.priceTL.toStringAsFixed(2)} ₺'
                        : '\$ ${item.priceUSD.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
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
    final nonIngredientItems = globalFoodItems
        .where((f) => f.category != FoodCategory.ingredient)
        .toList();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: nonIngredientItems.length,
      itemBuilder: (context, index) {
        final item = nonIngredientItems[index];
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
                      AppLocalizations.of(context).isTurkish
                          ? item.nameTr
                          : item.name,
                      style: const TextStyle(
                        fontFamily: 'SegoeUI',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).isTurkish
                              ? '${item.priceTL.toStringAsFixed(2)} ₺'
                              : '\$ ${item.priceUSD.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          item.rating.toString(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
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
              /*const Icon(Icons.remove_circle_outline, color: Theme.of(context).primaryColor),
              const SizedBox(width: 4),
              const Text('--'),
              const SizedBox(width: 4),
              const Icon(Icons.add_circle_outline, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),*/
              ElevatedButton(
                onPressed: () {
                  item.isInCart = true;
                  //adet++ in cart
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(
                        "${AppLocalizations.of(context).isTurkish ? item.nameTr : item.name} ${AppLocalizations.of(context).translate("added_to_cart")}",
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text(
                  AppLocalizations.of(context).translate("add_to_cart"),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  item.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: item.isLiked
                      ? Colors.red
                      : Theme.of(context).colorScheme.onSurface,
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

    //todo bunu map e çevir <fooditem, int adet>
    final List<FoodItem> cartItems = globalFoodItems
        .where((item) => item.isInCart)
        .toList();

    return Container(
      width: 288,
      height: double.infinity,
      color: Theme.of(context).colorScheme.secondary, // Light peach background
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            // Toggle Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    AppLocalizations.of(context).translate("shopping_cart"),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context).translate("empty_cart"),
                      ),
                    )
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
                              final int originalIndex = globalFoodItems.indexOf(
                                item,
                              );
                              if (originalIndex != -1) {
                                globalFoodItems[originalIndex].isInCart = false;
                              }
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text(
                                  "${AppLocalizations.of(context).isTurkish ? item.nameTr : item.name} ${AppLocalizations.of(context).translate("removed_from_cart")}",
                                ),
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              item.imageName,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              AppLocalizations.of(context).isTurkish
                                  ? item.nameTr
                                  : item.name,
                            ),
                            subtitle: Text(
                              AppLocalizations.of(context).isTurkish
                                  ? "${item.priceTL.toStringAsFixed(2)} ₺"
                                  : "\$ ${item.priceUSD.toStringAsFixed(2)}",
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
                      Text(
                        '${AppLocalizations.of(context).translate("total")}:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).isTurkish
                            ? '${cartItems.fold(0.0, (sum, item) => sum + item.priceTL).toStringAsFixed(2)} ₺'
                            : '\$ ${cartItems.fold(0.0, (sum, item) => sum + item.priceUSD).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Add checkout logic here
                      },
                      child: Text(
                        AppLocalizations.of(context).translate("checkout"),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
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

  Widget _buildCartIcon(BuildContext context) {
    final cartCount = globalFoodItems.where((i) => i.isInCart).length;
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          color: Theme.of(context).colorScheme.onPrimary,
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
        if (cartCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$cartCount',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
