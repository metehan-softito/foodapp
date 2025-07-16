import 'package:flutter/material.dart';

class BegumDeneme extends StatefulWidget {
  const BegumDeneme({super.key});

  @override
  State<BegumDeneme> createState() => _BegumDenemeState();
}

class _BegumDenemeState extends State<BegumDeneme> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Row(
            children: [
              // Container 1: Blue (only visible when not expanded)
              if (!expanded)
                Container(width: width / 2, height: 150, color: Colors.blue),

              // Container 2: Animated
              GestureDetector(
                onTap: () => setState(() => expanded = !expanded),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: expanded ? width : width / 2,
                  height: 150,
                  color: Colors.orange,
                  alignment: Alignment.center,
                  child: Text(
                    expanded ? 'Full Width' : 'Tap Me',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
