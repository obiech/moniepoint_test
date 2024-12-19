part of 'home_listings_bloc.dart';

class HomeState extends Equatable {
  const HomeState({required this.listing, required this.status});

  factory HomeState.initial() => const HomeState(
        listing: [],
        status: HomeListingStatus.initial,
      );

  HomeState copy({
    List<HomeListing>? listing,
    HomeListingStatus? status,
  }) {
    return HomeState(
      listing: listing ?? this.listing,
      status: status ?? this.status,
    );
  }

  final List<HomeListing> listing;
  final HomeListingStatus status;

  @override
  List<Object> get props => [listing, status];
}

enum HomeListingStatus { initial, loading, failed, success }
