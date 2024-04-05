import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_market/core/errors/failures.dart';

abstract class BaseUsecase extends Equatable {}

abstract class ParameterUseCase<R, Params> extends BaseUsecase {
  Future<Either<Failure, R>> call(Params params);
}

abstract class NoParameterUseCase<R> extends BaseUsecase {
  Future<Either<Failure, R>> call();
}

abstract class OptionalParameterUseCase<R, Params, OptionalParams>
    extends BaseUsecase {
  Future<Either<Failure, R>> call(
    Params params, [
    OptionalParams optionalParams,
  ]);
}
