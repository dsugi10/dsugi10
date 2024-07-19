import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiConfig extends HttpOverrides {
  // @override
  // HttpClient createHttpClient(SecurityContext? context) {
  //   return super.createHttpClient(context)
  //     ..badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  // }
  static final HttpLink httpLink =
      HttpLink("https://innocent-pony-98.hasura.app/v1/graphql",defaultHeaders: {'x-hasura-admin-secret':'T208kKgZhgm5MQKel721CiAqnA6J3vIWSBYFxSUni2Z2RSxJitGw0qXuFRl0iKfb'

 } );
  static ValueNotifier<GraphQLClient> getLink() {
    final Link link = httpLink;
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: link,
      ),
    );
    return client;
  }
}