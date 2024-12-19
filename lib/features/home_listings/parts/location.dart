part of '../pages/home_listings_tab.dart';

class _Location extends StatefulWidget {
  const _Location();

  @override
  State<_Location> createState() => __LocationState();
}

class __LocationState extends State<_Location>
    with SingleTickerProviderStateMixin {
  bool animateSize = false;
  bool animateOpacity = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(kDuration300Mil);
      if (!mounted) return;
      setState(() => animateSize = true);
      await Future.delayed(kDuration800Mil);
      if (!mounted) return;
      setState(() => animateOpacity = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 48,
      curve: Curves.easeOutQuad,
      duration: kDuration2Sec,
      constraints: BoxConstraints(maxWidth: animateSize ? 0.5.sw : 0),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: AnimatedOpacity(
        opacity: animateOpacity ? 1 : 0,
        duration: kDuration500Mil,
        curve: Curves.easeInOutCubic,
        child: TextField(
          controller: TextEditingController(text: 'Saint Petersburg'),
          style: const TextStyle(
            fontSize: 17,
            color: AppColor.grey,
            overflow: TextOverflow.ellipsis,
          ),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.location_on_rounded,
              size: 16,
              color: AppColor.grey,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
