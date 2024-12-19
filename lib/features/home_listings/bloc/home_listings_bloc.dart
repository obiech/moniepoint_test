import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moniepoint/features/home_listings/domain/models/home_listing.dart';
import 'package:moniepoint/features/home_listings/repositories/home_listings_repository.dart';

part 'home_listings_event.dart';
part 'home_listings_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(HomeState.initial()) {
    on<LoadHomeListing>(_loadListing);
  }
  final HomeListingsRepository repository;

  Future<void> _loadListing(
    LoadHomeListing event,
    Emitter<HomeState> emit,
  ) async {
    final listing = await repository.getListing();

    listing.fold(
      (left) => emit(state.copy(status: HomeListingStatus.failed)),
      (right) => emit(
        state.copy(
          listing: right,
          status: HomeListingStatus.success,
        ),
      ),
    );
  }
}
