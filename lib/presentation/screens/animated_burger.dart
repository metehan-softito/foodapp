import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimatedBurger extends StatefulWidget {
  final ThemeMode themeMode;
  const AnimatedBurger({super.key, required this.themeMode});

  @override
  State<AnimatedBurger> createState() => _AnimatedBurgerState();
}

class _AnimatedBurgerState extends State<AnimatedBurger> {
  Artboard? _artboard;
  SMIBool? _tapInput;

  @override
  void initState() {
    super.initState();
    _loadRiveArtboard(); // Initial load
  }

  @override
  void didUpdateWidget(covariant AnimatedBurger oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If theme mode changed, reload the correct Rive file
    if (widget.themeMode != oldWidget.themeMode) {
      _loadRiveArtboard();
    }
  }

  void _loadRiveArtboard() async {
    final path = widget.themeMode == ThemeMode.light
        ? 'assets/rive/burgasm_interactive_design.riv'
        : 'assets/rive/burgasm_interactive_design_realistic.riv';

    final data = await rootBundle.load(path);
    final file = RiveFile.import(data);
    final newArtboard = file.mainArtboard;

    final controller = StateMachineController.fromArtboard(
      newArtboard,
      'State Machine 1',
    );

    SMIBool? newTapInput;

    if (controller != null) {
      newArtboard.addController(controller);
      final input = controller.findInput<bool>('tap');
      if (input is SMIBool) {
        newTapInput = input;
      }
    }

    // Swap only after everything is ready
    setState(() {
      _artboard = newArtboard;
      _tapInput = newTapInput;
    });
  }

  void _onTap() {
    if (_tapInput != null) {
      _tapInput!.value = !_tapInput!.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: SizedBox(
        width: 200,
        height: 200,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _artboard == null
              ? const Center(
                  key: ValueKey('loading'),
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  key: ValueKey(_artboard), // <--- give key to wrapper
                  width: 200,
                  height: 200,
                  child: Rive(artboard: _artboard!),
                ),
        ),
      ),
    );
  }
}
