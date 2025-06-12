import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/core/services/networking/network_constants.dart';

class NetworkService {
  NetworkService({final Dio? dio})
      : dio = dio ??
      Dio(
        BaseOptions(
          baseUrl: NetworkConstants.baseUrl,
          receiveTimeout: NetworkConstants.receiveTimeout,
          connectTimeout: NetworkConstants.connectTimeout,
        ),
      ) {
    this.dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  final Dio dio;

  Future<Either<Failure, Response<dynamic>>> getPath(
      final String path, {
        final Map<String, dynamic>? queryParams,
      }) async {
    try {
      final Response<dynamic> response =
      await dio.get(path, queryParameters: queryParams);

      final Failure? failure = _handleStatusCode(response.statusCode);
      if (failure != null) {
        return Left(failure);
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure("Unexpected error: $e"));
    }
  }

  Future<Either<Failure, Response<dynamic>>> postPath(
      final String path, {
        final Map<String, dynamic>? data,
        final Map<String, dynamic>? queryParams,
        final Map<String, String>? headers,
      }) async {
    try {
      final Response<dynamic> response = await dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),

      );

      final Failure? failure = _handleStatusCode(response.statusCode);
      if (failure != null) {
        return Left(failure);
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, Response<dynamic>>> putPath(
      final String path, {
        final Map<String, dynamic>? data,
        final Map<String, dynamic>? queryParams,
      }) async {
    try {
      final Response<dynamic> response = await dio.put(
        path,
        data: data,
        queryParameters: queryParams,
      );

      final Failure? failure = _handleStatusCode(response.statusCode);
      if (failure != null) {
        return Left(failure);
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, Response<dynamic>>> deletePath(
      final String path, {
        final Map<String, dynamic>? data,
        final Map<String, dynamic>? queryParams,
      }) async {
    try {
      final Response<dynamic> response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParams,
      );

      final Failure? failure = _handleStatusCode(response.statusCode);
      if (failure != null) {
        return Left(failure);
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Failure? _handleStatusCode(final int? statusCode) {
    if (statusCode == null) {
      return Failure("No status code received");
    }

    if (statusCode >= 200 && statusCode < 300) {
      return null; // Success
    } else if (statusCode >= 400 && statusCode < 500) {
      switch (statusCode) {
        case 400:
          return Failure("Bad Request");
        case 401:
          return Failure("Unauthorized");
        case 403:
          return Failure("Forbidden");
        case 404:
          return Failure("Not Found");
        default:
          return Failure("Client Error: $statusCode");
      }
    } else if (statusCode >= 500 && statusCode < 600) {
      return Failure("Server Error: $statusCode");
    } else {
      return Failure("Unexpected status code: $statusCode");
    }
  }

  Failure _handleDioError(final DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Failure("Connection Timeout");
      case DioExceptionType.receiveTimeout:
        return Failure("Receive Timeout");
      case DioExceptionType.sendTimeout:
        return Failure("Send Timeout");
      case DioExceptionType.badResponse:
        return Failure(
          "Bad Response: ${e.response?.statusCode ?? 'Unknown'}",
        );
      case DioExceptionType.cancel:
        return Failure("Request Cancelled");
      case DioExceptionType.unknown:
      default:
        return Failure("Unknown Error: ${e.message}");
    }
  }
}