import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/core/error/error_mapper.dart';
import 'package:luxora/core/error/exceptions.dart';
import 'package:luxora/core/error/failures.dart';

void main() {
  group('ErrorMapper.toFailure', () {
    group('AppException → Failure', () {
      test('NetworkException → NetworkFailure', () {
        final failure = ErrorMapper.toFailure(
          const NetworkException('timeout'),
        );
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'timeout');
      });

      test('ServerException → ServerFailure', () {
        final failure = ErrorMapper.toFailure(const ServerException());
        expect(failure, isA<ServerFailure>());
      });

      test('AuthException → AuthFailure', () {
        final failure = ErrorMapper.toFailure(const AuthException());
        expect(failure, isA<AuthFailure>());
      });

      test('CacheException → CacheFailure', () {
        final failure = ErrorMapper.toFailure(const CacheException());
        expect(failure, isA<CacheFailure>());
      });

      test('ParseException → ServerFailure (réponse invalide)', () {
        final failure = ErrorMapper.toFailure(const ParseException());
        expect(failure, isA<ServerFailure>());
        expect(failure.message, 'Réponse invalide.');
      });

      test('ValidationException → ValidationFailure', () {
        final failure = ErrorMapper.toFailure(
          const ValidationException('champ requis'),
        );
        expect(failure, isA<ValidationFailure>());
        expect(failure.message, 'champ requis');
      });
    });

    group('DioException → Failure', () {
      test('connectionTimeout → NetworkFailure', () {
        final failure = ErrorMapper.toFailure(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionTimeout,
          ),
        );
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, contains('Délai'));
      });

      test('connectionError → NetworkFailure (pas de connexion)', () {
        final failure = ErrorMapper.toFailure(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionError,
          ),
        );
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, contains('connexion'));
      });

      test('badResponse 401 → AuthFailure', () {
        final failure = ErrorMapper.toFailure(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 401,
            ),
          ),
        );
        expect(failure, isA<AuthFailure>());
        expect(failure.message, contains('expirée'));
      });

      test('badResponse 404 → NotFoundFailure', () {
        final failure = ErrorMapper.toFailure(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 404,
            ),
          ),
        );
        expect(failure, isA<NotFoundFailure>());
      });

      test('badResponse 500 → ServerFailure', () {
        final failure = ErrorMapper.toFailure(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );
        expect(failure, isA<ServerFailure>());
      });

      test('badResponse 400 → ValidationFailure', () {
        final failure = ErrorMapper.toFailure(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 400,
            ),
          ),
        );
        expect(failure, isA<ValidationFailure>());
      });
    });

    group('FirebaseAuthException → Failure', () {
      test('invalid-phone-number → ValidationFailure', () {
        final failure = ErrorMapper.toFailure(
          FirebaseAuthException(code: 'invalid-phone-number'),
        );
        expect(failure, isA<ValidationFailure>());
        expect(failure.message, contains('téléphone'));
      });

      test('invalid-verification-code → ValidationFailure', () {
        final failure = ErrorMapper.toFailure(
          FirebaseAuthException(code: 'invalid-verification-code'),
        );
        expect(failure, isA<ValidationFailure>());
        expect(failure.message, contains('incorrect'));
      });

      test('too-many-requests → ValidationFailure', () {
        final failure = ErrorMapper.toFailure(
          FirebaseAuthException(code: 'too-many-requests'),
        );
        expect(failure, isA<ValidationFailure>());
        expect(failure.message, contains('tentatives'));
      });

      test('user-disabled → AuthFailure', () {
        final failure = ErrorMapper.toFailure(
          FirebaseAuthException(code: 'user-disabled'),
        );
        expect(failure, isA<AuthFailure>());
      });

      test('code inconnu → AuthFailure (fallback)', () {
        final failure = ErrorMapper.toFailure(
          FirebaseAuthException(code: 'unknown_code_xyz'),
        );
        expect(failure, isA<AuthFailure>());
      });
    });

    group('Fallback', () {
      test('erreur inconnue → UnknownFailure', () {
        final failure = ErrorMapper.toFailure(Exception('random'));
        expect(failure, isA<UnknownFailure>());
      });

      test('string → UnknownFailure', () {
        final failure = ErrorMapper.toFailure('random string');
        expect(failure, isA<UnknownFailure>());
      });
    });
  });
}
