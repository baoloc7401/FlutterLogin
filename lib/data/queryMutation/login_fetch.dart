// ignore_for_file: non_constant_identifier_names

class LoginFetch {
  static String loginMutation() {
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

  static Map<String, Map<String, String>> loginMutation_variable(
      String email, String password) {
    return {
      "input": {"vfaEmail": email, "password": password}
    };
  }
}
