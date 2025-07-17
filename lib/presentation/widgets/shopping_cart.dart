import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xccff7700),
        child: SafeArea(
          child: Column(
            children: <Widget>[Card(child: Text("Shoppping Cart"))],
          ),
        ),
      ),
    );
  }
}
