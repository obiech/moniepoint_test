import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moniepoint/features/home_listings/bloc/home_listings_bloc.dart';
import 'package:moniepoint/features/home_listings/repositories/home_listings_repository.dart';
import 'package:moniepoint/features/home_listings/repositories/home_listings_repository_impl.dart';
import 'package:moniepoint/features/map/bloc/map_bloc.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<HomeListingsRepository>(
      create: (context) => HomeListingsRepositoryImpl(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MapBloc()),
          BlocProvider(
            create: (context) => HomeBloc(
              context.read<HomeListingsRepository>(),
            )..add(LoadHomeListing()),
          ),
        ],
        child: child,
      ),
    );
  }
}
