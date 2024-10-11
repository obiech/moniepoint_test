import 'package:moniepoint/core/utils/app_data_types.dart';
import 'package:moniepoint/features/home_listings/domain/models/home_listing.dart';

abstract class HomeListingsRepository {
  AppErrorOr<List<HomeListing>> getListing();
}
