// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClass {
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhMDU1ZDYyZC1hYzYwLTQ0N2UtZWU1Zi1hZDY4MmZkNzVkNGIiLCJqdGkiOiJiZGRlM2JmMS00ZTFjLTQxNzYtYTg4NS0zMTAwMjUzOGVkOGIiLCJpYXQiOjE2NDczMDkxNDcsImlzcyI6InZmYSJ9.XKg9ZO7qOw599ziUE80dF4fMXrP1g95Ul3q3MVwd_aM";
  static final HttpLink httpLink = HttpLink("http://54.255.247.6:3001/graphql");
  static final AuthLink tokenLink = AuthLink(
    getToken: () => 'bearer $token',
  );
  static String LoginMutation() {
    return r"""
            mutation login ($input:LoginCondition!) {
              login(condition:$input) {
                token
                token_type
                expires_in
                user {
                  userId
                  vfaJoinedDate
                  vfaEmail
                }
              }
            }
          """;
  }

  static Map<String, Map<String, String>> LoginVariable(
      String email, String password) {
    return {
      "input": {"vfaEmail": email, "password": password}
    };
  }

  static Link authLink = tokenLink.concat(httpLink);
  static Link nonAuthLink = httpLink;
  static ValueNotifier<GraphQLClient> clientNonAuth =
      ValueNotifier<GraphQLClient>(
          GraphQLClient(link: nonAuthLink, cache: GraphQLCache()));
  static ValueNotifier<GraphQLClient> clientAuth = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: nonAuthLink, cache: GraphQLCache()));
  static GraphQLClient clientToQuery() {
    AuthLink tokenLink = AuthLink(
      getToken: () async => 'Bearer $token',
    );
    final Link link = tokenLink.concat(httpLink);
    //final Link link = httpLink;
    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}
