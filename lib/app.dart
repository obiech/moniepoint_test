import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/app_providers.dart';
import 'package:moniepoint/core/styles/map_theme.dart';
import 'package:moniepoint/features/dashboard/pages/dashboard_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    MapTheme().loadTheme(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 809),
      minTextAdapt: true,
      ensureScreenSize: true,
      fontSizeResolver: FontSizeResolvers.height,
      child: MaterialApp(
        title: 'Real Estate',
        debugShowCheckedModeBanner: false,
        builder: (_, widget) {
          return AppProviders(
            child: ScrollConfiguration(
              behavior: const _GlobalScrollBehavior(),
              child: widget!,
            ),
          );
        },
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Afacad_Flux',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const DashboardPage(),
      ),
    );
  }
}

class _GlobalScrollBehavior extends ScrollBehavior {
  const _GlobalScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(_) => const BouncingScrollPhysics();
}
