import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/core/styles/app_color.dart';
import 'package:moniepoint/core/utils/app_images.dart';
import 'package:moniepoint/core/utils/constants.dart';
import 'package:moniepoint/features/home_listings/pages/home_listings_tab.dart';
import 'package:moniepoint/features/map/pages/map_page.dart';

part '../parts/navigation_tab.dart';
part '../parts/navigation_tab_icon.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController? dashboardAnimController;
  late Animation animation;

  int tabIndex = 2;

  @override
  void initState() {
    super.initState();
    dashboardAnimController = AnimationController(
      duration: kDuration1Sec,
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNavbar();
    });
  }

  @override
  void didChangeDependencies() {
    animation = Tween<double>(
      begin: -100,
      end: max(MediaQuery.of(context).viewPadding.bottom, 16.h),
    ).animate(
      CurvedAnimation(
        parent: dashboardAnimController!,
        curve: Curves.easeOutCubic,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // dispose animation controller
    dashboardAnimController?.dispose();
    dashboardAnimController = null;
    super.dispose();
  }

  void showNavbar() {
    Future.delayed(kDuration1Sec * 6, () {
      return dashboardAnimController?.forward();
    });
  }

  Widget currentPage() {
    switch (tabIndex) {
      case 0:
        return const MapPage();
      case 2:
        return const HomePage();
      case 1:
      case 3:
      case 4:
      default:
        return const Scaffold();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(duration: kDuration1Sec, child: currentPage()),
        AnimatedBuilder(
          animation: animation,
          child: Container(
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 4.r),
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: CustomNavBar(currentIndex: tabIndex, changeTab: changeTab),
          ),
          builder: (context, child) {
            return Positioned(bottom: animation.value, child: child!);
          },
        ),
      ],
    );
  }

  void changeTab(int index) {
    setState(() => tabIndex = index);
  }
}