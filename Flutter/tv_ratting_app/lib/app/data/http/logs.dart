part of 'http.dart';

void _printLogs(Map<String, dynamic> logs, StackTrace? stackTrace) {
  if (kDebugMode) {
    if (Platform.environment.containsKey("FLUTTER_TEST")) {
      log("""
+++++++++++++++++++++++++++++++++
${const JsonEncoder.withIndent("  ").convert(logs)}
  +++++++++++++++++++++++++++++++
  """, stackTrace: stackTrace);
    }
  }
}
