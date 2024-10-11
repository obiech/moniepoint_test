part of '../pages/dashboard_page.dart';

class NavigationTabIcon extends StatelessWidget {
  const NavigationTabIcon({
    super.key,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
    this.size,
  });

  final String icon;
  final double? size;
  final Color color;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 54,
        height: 54,
        child: Stack(
          alignment: Alignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: AnimatedSize(
                duration: kDuration500Mil,
                clipBehavior: Clip.none,
                child: SizedBox.square(dimension: selected ? 54 : 38),
              ),
            ),
            Image.asset(
              icon,
              color: Colors.white,
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
