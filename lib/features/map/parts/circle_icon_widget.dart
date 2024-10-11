part of '../pages/map_page.dart';

class _CircleIconWidget extends StatelessWidget {
  const _CircleIconWidget({required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 100,
      duration: 800,
      child: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.25),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          icon,
          color: Colors.white,
          width: 15,
          height: 15,
        ),
      ),
    );
  }
}
