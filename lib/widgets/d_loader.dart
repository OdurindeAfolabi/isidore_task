import 'package:flutter/material.dart';

import 'logo.dart';

class DLoader extends StatefulWidget {
  final double? size;
  const DLoader({
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  State<DLoader> createState() => _DLoaderState();
}

class _DLoaderState extends State<DLoader> with TickerProviderStateMixin {
  late AnimationController animationController;
  var tween = Tween<double>(begin: 0, end: 1)
    ..chain(CurveTween(curve: Curves.ease));

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animationController.drive(tween),
      child: Center(
        child: Logo(
          size: widget.size ?? 70,
          useHero: false,
        ),
      ),
    );
  }
}
