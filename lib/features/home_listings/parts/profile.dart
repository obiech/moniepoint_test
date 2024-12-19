part of '../pages/home_listings_tab.dart';

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 300,
      duration: 800,
      curve: Curves.easeOutCubic,
      child: Container(
        height: 48,
        width: 48,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage(AppImages.profile)),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
