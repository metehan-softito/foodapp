import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreenAnimated extends StatefulWidget {
  const LoginScreenAnimated({super.key});

  @override
  State<LoginScreenAnimated> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenAnimated> {
  final double _offsetToArmed = 220;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 1)),
        offsetToArmed: _offsetToArmed,

        builder: (context, child, controller) => AnimatedBuilder(
          animation: controller,
          child: child,
          builder: (context, child) {
            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: _offsetToArmed * controller.value,
                  child: const RiveAnimation.asset(
                    "assets/3d_raster_test.riv",
                    fit: BoxFit.cover,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, _offsetToArmed * controller.value),
                  child: controller.isLoading ? loadingList() : child,
                ),
              ],
            );
          },
        ),

        child: ListView.separated(
          itemBuilder: (contex, index) => Container(
            height: 300,
            margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            child: Center(
              child: Text(
                "${index + 1}asd",
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          separatorBuilder: (a, b) {
            return Container();
          },
          itemCount: 50,
        ),
      ),
    );
  }

  dynamic loadingList() => ListView.separated(
    itemBuilder: (contex, index) => Container(
      height: 300,
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Center(),
    ),
    separatorBuilder: (a, b) {
      return Container();
    },
    itemCount: 50,
  );
}
/*CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Your Title Here"),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(120),
                  ),
                ),
              ),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text("Item #$index")),
              childCount: 50,
            ),
          ),
        ],
      ),
    */