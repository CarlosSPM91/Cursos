import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';

part 'http_failure.dart';
part 'logs.dart';
part 'parse_response_body.dart';

enum HttpMethod { get, post, patch, delete, put }

class Http {
  final String _baseURL;
  final String _apiKey;
  final Client _client;

  Http({
    required String baseURL,
    required String apiKey,
    required Client client,
  })  : _baseURL = baseURL,
        _apiKey = apiKey,
        _client = client;

  Future<Either<HttpFailure, T>> request<T>(
    String path, {
    required Function(dynamic responseBody) onSucces,
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool useApiKey = true,
  }) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;

    try {
      if (useApiKey) {
        queryParameters = {
          ...queryParameters,
          "api_key": _apiKey,
        };
      }

      Uri url = Uri.parse(
        path.startsWith("http") ? path : "$_baseURL$path",
      );

      if (queryParameters.isNotEmpty) {
        url = url.replace(queryParameters: queryParameters);
      }

      headers = {"Content-Type": "application/json", ...headers};

      late final Response response;
      final bodyString = jsonEncode(body);
      logs = {
        "startTime": DateTime.now().toString(),
        "url": url.toString(),
        "method": method.name,
        "body": body,
      };

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: headers,
            body: bodyString,
          );
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: headers,
            body: bodyString,
          );
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
            body: bodyString,
          );
        case HttpMethod.put:
          response = await _client.put(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
      }
      final statusCode = response.statusCode;
      final responseBody = _parseResponseBody(response.body);
      logs = {
        ...logs,
        "statusCode": statusCode,
        "responseBody": responseBody,
      };

      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(
          onSucces(responseBody),
        );
      }
      return Either.left(
        HttpFailure(
          statusCode: statusCode,
          data: responseBody,
        ),
      );
    } catch (e, s) {
      stackTrace = s;
      logs = {
        ...logs,
        "exception": e.toString(),
      };
      if (e is ClientException || e is SocketException) {
        logs = {
          ...logs,
          "exception": "NetworkException",
        };
        return Either.left(
          HttpFailure(
            exception: NetworkException(),
          ),
        );
      }

      return Either.left(
        HttpFailure(
          exception: e,
        ),
      );
    } finally {
      logs = {
        ...logs,
        "endTime": DateTime.now().toString(),
      };
      // _printLogs(logs, stackTrace);
    }
  }
}
