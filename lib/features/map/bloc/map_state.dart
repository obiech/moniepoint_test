part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({required this.mapInfo});

  factory MapState.initial() => const MapState(mapInfo: MapInformation.price);
  final MapInformation mapInfo;

  MapState copy({MapInformation? mapInfo}) {
    return MapState(mapInfo: mapInfo ?? this.mapInfo);
  }

  @override
  List<Object> get props => [mapInfo];
}
