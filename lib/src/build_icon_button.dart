import 'package:flutter/material.dart';

import 'icon_clipper.dart';

class BuildIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final AnimationController controller;
  final IconData selectedIcon;
  final IconData unslectedIcon;
  final int seletedIndex;
  final int index;
  final Color color;
  final double iconSize;
  final Color inactiveColor;
  final Color barColor;
  final double bottomPadding;
  final double barHeight;
  final double myWidth;

  double _bottomIconScale() => seletedIndex == index
      ? Tween<double>(begin: 1.0, end: 0.7)
          .animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.55, 1.0),
            ),
          )
          .value
      : 1.0;

  double _topIconScale() => Tween<double>(begin: 0.7, end: 1.0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.55, 1.0),
        ),
      )
      .value;

  double _clipRadius() => Tween<double>(begin: 0, end: 30)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.60, 1.0),
        ),
      )
      .value;

  const BuildIconButton({
    required this.onPressed,
    required this.controller,
    required this.selectedIcon,
    required this.unslectedIcon,
    required this.index,
    required this.seletedIndex,
    required this.color,
    required this.iconSize,
    required this.inactiveColor,
    required this.barColor,
    required this.bottomPadding,
    required this.barHeight,
    required this.myWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxElementWidth = myWidth / 5;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: maxElementWidth,
        height: barHeight,
        color: barColor,
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Stack(
          // fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Transform.scale(
              scale: _bottomIconScale(),
              child: Opacity(
                  opacity: controller.value > 0.8 && seletedIndex == index ? 0.0 : 1.0,
                  child: Icon(
                    unslectedIcon,
                    size: iconSize,
                    color: inactiveColor,
                  )),
            ),
            Transform.scale(
              scale: _topIconScale(),
              child: ClipOval(
                clipper: IconClipper(
                  radius: _clipRadius(),
                ),
                child: Opacity(
                  opacity: controller.value > 0.6 && seletedIndex == index ? 1.0 : 0.0,
                  child: Icon(
                    selectedIcon,
                    size: iconSize,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
