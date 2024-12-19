import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker {
  MapMarker({
    required this.position,
    required this.name,
    this.xAxis = 0,
    this.yAxis = 0,
  });

  MapMarker copy({
    LatLng? position,
    String? name,
    double? xAxis,
    double? yAxis,
  }) =>
      MapMarker(
        position: position ?? this.position,
        name: name ?? this.name,
        xAxis: xAxis ?? this.xAxis,
        yAxis: yAxis ?? this.yAxis,
      );

  final LatLng position;
  final String name;
  final double xAxis;
  final double yAxis;
}
