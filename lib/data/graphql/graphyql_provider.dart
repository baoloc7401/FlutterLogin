// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static final HttpLink httpLink = HttpLink("http://54.255.247.6:3001/graphql");

  static ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: GraphQLCache()));

  static ValueNotifier<GraphQLClient> clientToQuery(
      {String tokenType = "", String token = ""}) {
    return ValueNotifier(GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink("http://54.255.247.6:3001/graphql",
          defaultHeaders: <String, String>{
            'authorization': '$tokenType $token',
          }),
    ));
  }
}
