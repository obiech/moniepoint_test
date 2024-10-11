import 'package:dartz/dartz.dart';
import 'package:moniepoint/core/utils/app_data_types.dart';
import 'package:moniepoint/features/home_listings/domain/data.dart';
import 'package:moniepoint/features/home_listings/domain/models/home_listing.dart';
import 'package:moniepoint/features/home_listings/repositories/home_listings_repository.dart';

class HomeListingsRepositoryImpl extends HomeListingsRepository {
  @override
  AppErrorOr<List<HomeListing>> getListing() async {
    return const Right(data);
  }
}
