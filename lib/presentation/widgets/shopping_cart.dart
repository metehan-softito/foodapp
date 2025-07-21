import 'package:flutter/material.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context).translate;
    final isTurkish = AppLocalizations.of(context).isTurkish;
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Theme.of(context).colorScheme.onPrimary,
        child: SafeArea(
          child: Column(
            children: <Widget>[Card(child: Text(translate('shopping_cart')))],
          ),
        ),
      ),
    );
  }
}
