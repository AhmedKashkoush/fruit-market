import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushReplacementNamed(
  String name,
  BuildContext context, {
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, dynamic> queryParameters = const <String, dynamic>{},
  Object? extra,
}) {
  context.pushReplacementNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
}
Future<T?> pushNamed<T extends Object?>(
  String name,
  BuildContext context, {
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, dynamic> queryParameters = const <String, dynamic>{},
  Object? extra,
}) {
  return context.pushNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
}

void pop<T extends Object?>(BuildContext context, [T? result]) {
  context.pop(
    result,
  );
}

void goNamed(
  String name,
  BuildContext context, {
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, dynamic> queryParameters = const <String, dynamic>{},
  Object? extra,
}) {
  context.goNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
}
