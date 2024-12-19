part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({required this.mapInfo, required this.darkTheme});

  factory MapState.initial() => const MapState(
        mapInfo: MapInformation.price,
        darkTheme: '',
      );
  final MapInformation mapInfo;
  final String darkTheme;

  MapState copy({MapInformation? mapInfo, String? darkTheme}) {
    return MapState(
      mapInfo: mapInfo ?? this.mapInfo,
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }

  @override
  List<Object> get props => [mapInfo, darkTheme];
}
