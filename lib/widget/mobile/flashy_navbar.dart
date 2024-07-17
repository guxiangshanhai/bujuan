import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashyNavbar extends StatelessWidget {
  final int selectedIndex;
  final double height;

  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final Curve animationCurve;
  final List<BoxShadow> shadows;
  final EdgeInsetsGeometry? padding;

  final List<FlashyNavbarItem> items;
  final ValueChanged<int> onItemSelected;

  FlashyNavbar({
    Key? key,
    this.selectedIndex = 0,
    this.height = 55,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.linear,
    this.shadows = const [
      BoxShadow(color: Colors.transparent, blurRadius: 0),
    ],
    required this.items,
    required this.onItemSelected,
    this.padding,
  }) : super(key: key) {
    // assert(height >= 55 );
    assert(items.length >= 2 && items.length <= 5);
  }

  @override
  Widget build(BuildContext context) {
    final bg = (backgroundColor == null) ? Theme.of(context).bottomAppBarColor : backgroundColor;
    return Container(
      padding: padding,
      height: height,
      color: Colors.transparent,
      child: SizedBox(
        width: Get.width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item) {
            var index = items.indexOf(item);
            return Expanded(
              child: GestureDetector(
                onTap: () => onItemSelected(index),
                child: Obx(() => _FlashyNavbarItem(
                      item: item,
                      tabBarHeight: height,
                      iconSize: iconSize,
                      isSelected: index == Home.to.selectIndex.value,
                      backgroundColor: bg!,
                      color: backgroundColor!,
                      animationDuration: animationDuration,
                      animationCurve: animationCurve,
                    )),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FlashyNavbarItem {
  final Icon icon;

  // final Text title;

  Color activeColor;
  Color inactiveColor;

  FlashyNavbarItem({
    required this.icon,
    // required this.title,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
  });
}

class _FlashyNavbarItem extends StatelessWidget {
  final double tabBarHeight;
  final double iconSize;

  final FlashyNavbarItem item;
  final Color color;

  final bool isSelected;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const _FlashyNavbarItem(
      {Key? key,
      required this.item,
      required this.isSelected,
      required this.tabBarHeight,
      required this.backgroundColor,
      required this.animationDuration,
      required this.animationCurve,
      required this.iconSize,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedAlign(
              duration: animationDuration,
              alignment: Alignment.center,
              child: Home.to.landscape?IconTheme(
                data: IconThemeData(size: iconSize, color: (Theme.of(context).iconTheme.color??Colors.black).withOpacity(isSelected ? 1 : 0.6)),
                child: item.icon,
              ):Obx(() => IconTheme(
                data: IconThemeData(size: iconSize, color: Home.to.bodyColor.value.withOpacity(isSelected ? 1 : 0.6)),
                child: item.icon,
              )),
            ),
          ],
        ));
  }
}

class _CustomPath extends CustomPainter {
  final Color backgroundColor;

  _CustomPath(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, 0);
    path.lineTo(0, 2.0 * size.height);
    path.lineTo(1.0 * size.width, 2.0 * size.height);
    path.lineTo(1.0 * size.width, 1.0 * size.height);
    path.lineTo(0, 0);
    path.close();

    paint.color = backgroundColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
