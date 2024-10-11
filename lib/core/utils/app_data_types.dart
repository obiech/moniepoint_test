import 'package:dartz/dartz.dart';
import 'package:moniepoint/core/models/app_error.dart';

typedef AppErrorOr<T> = Future<Either<AppError, T>>;
