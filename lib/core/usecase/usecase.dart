import 'package:equatable/equatable.dart';

/// Interface UseCase LUXORA.
///
/// Chaque action métier (récupérer, créer, valider…) est un UseCase.
/// Cela permet de :
/// - Tester la logique métier isolément
/// - Réutiliser les cas d'usage
/// - Découpler la présentation du repository
///
/// ## Exemple
/// ```dart
/// class EstimateRide implements UseCase<RideEstimate, EstimateRideParams> {
///   EstimateRide(this._repository);
///   final BookingRepository _repository;
///
///   @override
///   Future<RideEstimate> call(EstimateRideParams params) {
///     return _repository.estimateRide(
///       pickup: params.pickup,
///       destination: params.destination,
///     );
///   }
/// }
/// ```
abstract interface class UseCase<Result, Params> {
  Future<Result> call(Params params);
}

/// UseCase sans paramètre.
abstract interface class NoParamUseCase<Result> {
  Future<Result> call();
}

/// Paramètres vides (pour les UseCase sans params).
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
