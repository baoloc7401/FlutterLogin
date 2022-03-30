class vfaActivity {
  static String createActivityMutation() => r"""
            mutation createActivity($input: CreateActivityCondition!) {
              createActivity(condition: $input) {
                requestResolved
                message
                errorCode
                createdAt
              }
            }
          """;
  static Map<String, Map<String, String>> createActivityMutation_variable(
          String activityType) =>
      {
        "input": {"activityTypes": activityType}
      };
  static String myTimeLineQuery() => r"""
            query myTimeLine($input: MyTimeLineCondition) {
              myTimeLine(condition: $input) {
                response {
                  groupDate
                  collections {
                    timeSheetId
                    fromUserId
                    toUserId
                    reason
                    remainHolidaysFrom
                    remainHolidaysTo
                    remainMinutesFrom
                    remainMinutesTo
                    activityTypes
                    activityDescription
                    createdAt
                    updatedAt
                  }
                }
                error {
                  requestResolved
                  message
                  errorCode
                }
              }
            }
          """;
  static Map<String, Map<String, String>> myTimeLineQuery_variable(
    String startDate,
    String endDate,
  ) =>
      {
        "input": {"startDate": startDate, "endDate": endDate}
      };
  static String myActivityQuery() => r"""
            query myActivities($input: MyActivitiesCondition!) {
              myActivities(condition: $input) {
                response {
                  activityId
                  activityTypes
                  activityDescription
                  createdAt
                }
                error {
                  requestResolved
                  message
                  errorCode
                }
              }
            }
          """;
  static Map<String, Map<String, String>> myActivityQuery_variable(
    String startDate,
    String endDate,
  ) =>
      {
        "input": {"startDate": startDate, "endDate": endDate}
      };
}
