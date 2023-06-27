import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isidore_task/Utils/color_manager.dart';

class Logo extends StatelessWidget {
  final double? size;
  final bool useHero;
  final IconData? ratherIcon;
  final Color? color;
  const Logo({
    Key? key,
    this.size,
    this.useHero = true,
    this.ratherIcon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: useHero,
      child: Hero(
        tag: "logo",
        child: SizedBox(
          width: size,
          height: size,
          child: FittedBox(
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: (color ?? ColorManager.secondary).withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration:  BoxDecoration(
                  color: color ?? ColorManager.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  ratherIcon ?? CupertinoIcons.wand_stars_inverse,
                  size: 120,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
