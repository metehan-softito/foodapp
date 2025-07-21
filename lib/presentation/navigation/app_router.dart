import 'package:flutter/material.dart';
import 'package:kendin_ye/data/models/food_item.dart';
import 'package:kendin_ye/data/models/user.dart';
import 'package:kendin_ye/presentation/screens/category_screen.dart';
import 'package:kendin_ye/presentation/screens/food_detail_screen.dart';
import 'package:kendin_ye/presentation/screens/ingredient_selector.dart';
import 'package:kendin_ye/presentation/screens/ingredients_screen.dart';
import 'package:kendin_ye/presentation/screens/main_screen.dart';
import 'package:kendin_ye/presentation/screens/pizza_screen.dart';
import 'package:kendin_ye/presentation/screens/profile_screen.dart';
import 'package:kendin_ye/presentation/screens/settings_screen.dart';
import 'package:kendin_ye/presentation/screens/sushi_screen.dart';
import '../screens/burger_login_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/register_confirmation_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => BurgerLoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/confirmation':
        return MaterialPageRoute(
          builder: (_) => const RegisterConfirmationScreen(),
        );
      case '/main':
        final user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => MainScreen(user: user));
      case '/profile':
        final user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => ProfileScreen(user: user));
      case '/settings':
        final user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => SettingsScreen(user: user));
      case '/pizza':
        return MaterialPageRoute(builder: (_) => PizzaScreen());
      case '/burger':
        return MaterialPageRoute(builder: (_) => IngredientSelector());
      case '/sushi':
        return MaterialPageRoute(builder: (_) => SushiScreen());
      case '/category':
        final category = settings.arguments as FoodCategory;
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(category: category),
        );
      case '/detail':
        final args = settings.arguments as Map<String, dynamic>;
        final foodItem = args['item'] as FoodItem;
        final multiple = args['multiple'] as String;

        return MaterialPageRoute(
          builder: (_) =>
              FoodDetailScreen(foodItem: foodItem, multiple: multiple),
        );
      case '/ingredients':
        final item = settings.arguments as FoodItem;
        return MaterialPageRoute(builder: (_) => IngredientsScreen(food: item));
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
