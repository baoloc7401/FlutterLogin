// ignore_for_file: non_constant_identifier_names

class LoginFetch {
  static String loginMutation() => r"""
            mutation login ($input:LoginCondition!) {
              login(condition:$input) {
                token
                token_type
                expires_in
                user {
                  userId
                  vfaJoinedDate
                  vfaEmail
                  userFullName
                }
              }
            }
          """;

  static Map<String, Map<String, String>> loginMutation_variable(
          String email, String password) =>
      {
        "input": {"vfaEmail": email, "password": password}
      };
}
