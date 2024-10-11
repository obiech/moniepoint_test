part of '../pages/map_page.dart';

class _MapSearchWidget extends StatefulWidget {
  const _MapSearchWidget();

  @override
  State<_MapSearchWidget> createState() => __MapSearchWidgetState();
}

class __MapSearchWidgetState extends State<_MapSearchWidget> {
  final inputController = TextEditingController();

  @override
  void initState() {
    inputController.text = 'Saint Petersburg';
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationWidget(
      delay: 100,
      duration: 800,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              height: 45.h,
              width: 45.h,
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.search,
                color: Colors.black,
                width: 15.r,
                height: 15.r,
              ),
            ),
            Expanded(
              child: TextField(
                controller: inputController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  border: InputBorder.none,
                  isDense: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
