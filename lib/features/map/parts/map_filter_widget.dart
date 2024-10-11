part of '../pages/map_page.dart';

class _MapFilterWidget extends StatelessWidget {
  const _MapFilterWidget();

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 100,
      duration: 800,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Image.asset(
          AppImages.filter,
          color: Colors.black,
          width: 16,
          height: 16,
        ),
      ),
    );
  }
}
