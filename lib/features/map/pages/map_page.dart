import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moniepoint/core/styles/app_color.dart';
import 'package:moniepoint/core/styles/map_theme.dart';
import 'package:moniepoint/core/utils/app_images.dart';
import 'package:moniepoint/core/utils/constants.dart';
import 'package:moniepoint/core/utils/enums/map_information.dart';
import 'package:moniepoint/features/map/bloc/map_bloc.dart';
import 'package:moniepoint/features/map/domain/markers_data.dart';
import 'package:moniepoint/features/map/domain/models/custom_marker.dart';
import 'package:moniepoint/features/widgets/scale_animation_widget.dart';

part '../parts/circle_icon_widget.dart';
part '../parts/custom_marker_widget.dart';
part '../parts/map_filter_widget.dart';
part '../parts/map_search_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _controller = Completer<GoogleMapController>();

  static const _kGooglePlex = CameraPosition(
    target: LatLng(6.53967084755339, 3.372879847884178),
    zoom: 16.4746,
  );

  @override
  void initState() {
    super.initState();
    updateAllMarkers();
    // DefaultAssetBundle.of(context)
    //     .loadString('assets/json/google_map_theme.json')
    //     .then((theme) {
    //   if (mounted) setState(() => mapTheme = theme);
    //   updateAllMarkers();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            style: MapTheme.theme,
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: false,
            onMapCreated: _controller.complete,
            onCameraMove: (camPosition) {
              updateAllMarkers();
            },
          ),
          ...markers.map((marker) {
            return Positioned(
              top: marker.yAxis,
              left: marker.xAxis,
              child: _CustomMarker(text: marker.name),
            );
          }),
          Positioned(
            left: 32.w,
            right: 32.w,
            top: 50.h,
            child: SizedBox(
              height: 48.h,
              child: Row(
                children: [
                  const Expanded(child: _MapSearchWidget()),
                  10.horizontalSpace,
                  const AspectRatio(aspectRatio: 1, child: _MapFilterWidget()),
                ],
              ),
            ),
          ),
          Positioned(
            left: 32.w,
            bottom: 100.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dropUpWidget(),
                5.verticalSpace,
                const _CircleIconWidget(icon: AppImages.send),
              ],
            ),
          ),
          Positioned(
            right: 32.w,
            bottom: 100.h,
            child: ScaleAnimationWidget(
              delay: 100,
              duration: 800,
              child: Container(
                height: 54,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.white.withOpacity(0.25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.list,
                      color: Colors.white,
                      width: 16,
                      height: 16,
                    ),
                    6.horizontalSpace,
                    const Text(
                      'List of variants',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<MapMarker> updateMarkerCoordinates(MapMarker marker) async {
    final controller = await _controller.future;
    final coordinate = await controller.getScreenCoordinate(marker.position);
    // ignore: use_build_context_synchronously
    final ratio = MediaQuery.of(context).devicePixelRatio;

    final xAxis = coordinate.x.toDouble() / ratio;
    final yAxis = coordinate.y.toDouble() / ratio;
    return marker.copy(xAxis: xAxis, yAxis: yAxis);
  }

  Widget dropUpWidget() {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const _CircleIconWidget(icon: AppImages.wallet),
            onChanged: (info) {
              if (info != null) {
                context.read<MapBloc>().add(ChangeMarkerInfo(info));
              }
            },
            items: MapInformation.values.map((menu) {
              final selected = state.mapInfo == menu;
              return DropdownMenuItem<MapInformation>(
                value: menu,
                child: Row(
                  children: [
                    Image.asset(
                      menu.icon,
                      width: 18,
                      height: 18,
                      color: selected ? AppColor.primary : AppColor.grey,
                    ),
                    8.horizontalSpace,
                    Text(
                      menu.displayName,
                      style: TextStyle(
                        fontSize: 16,
                        color: selected ? AppColor.primary : AppColor.grey,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            dropdownStyleData: DropdownStyleData(
              width: 180,
              isOverButton: true,
              offset: const Offset(0, 150),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> updateAllMarkers() async {
    final futures = markers.map((marker) async {
      return updateMarkerCoordinates(marker);
    }).toList();

    final allMarkers = await Future.wait(futures);
    markers = allMarkers;
    // update marker positions
    setState(() {});
  }
}
