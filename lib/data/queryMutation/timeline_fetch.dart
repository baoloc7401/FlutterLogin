// ignore_for_file: camel_case_types

class vfaTimeline {
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
          String startDate, String endDate) =>
      {
        "input": {"startDate": startDate, "endDate": endDate}
      };
}
