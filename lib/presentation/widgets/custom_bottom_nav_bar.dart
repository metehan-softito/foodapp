import 'package:flutter/material.dart';
import 'package:kendin_ye/data/models/user.dart';
import 'package:kendin_ye/presentation/screens/main_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  final User user;
  const CustomBottomNavBar({super.key, required this.user});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List<String> _iconPaths = [
    'assets/icons/burger.png',
    'assets/icons/pizza.png',
    'assets/icons/home.png',
    'assets/icons/sushi.png',
    'assets/icons/cart.png',
  ];
  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreen(user: widget.user),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Color(0x77FFC58B),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                _iconPaths.length,
                (index) => GestureDetector(
                  onTap: () {
                    selectedIndex = index;
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: Duration(microseconds: 200),
                        margin: EdgeInsets.only(bottom: 2),
                        height: 4,
                        width: selectedIndex == index ? 20 : 0,
                        decoration: BoxDecoration(
                          color: Color(0xffff7700),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: selectedIndex == index ? 1 : 0.5,
                          child: Image.asset(
                            _iconPaths[index],
                            fit: BoxFit.fill,
                            width: selectedIndex == index ? 30 : 26,
                            height: selectedIndex == index ? 30 : 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            /*List.generate(_iconPaths.length, (index) {
              final isActive = widget.currentIndex == index;
              return InkWell(
                onTap: () => widget.onTap(index),
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFFF7700).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    _iconPaths[index],
                    fit: BoxFit.fill,
                    width: isActive ? 30 : 26,
                    height: isActive ? 30 : 26,
                  ),
                ),
              );
            }),*/
          ),
        ),
      ),
    );
  }
}
