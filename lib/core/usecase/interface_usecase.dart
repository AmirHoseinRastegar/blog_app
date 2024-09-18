import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<successType, params> {
  Future<Either<Failure, successType>> call(params params);
}


