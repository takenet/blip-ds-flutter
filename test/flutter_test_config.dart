import 'dart:async';

// import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // When loading the app fonts, CI (GitHub Actions) will fail because of the OS font alias.
  // See: https://github.com/flutter/flutter/issues/56383
  //
  // TODO: Load the app fonts and make sure that it'll pass through tests.yml workflow.
  // await loadAppFonts();

  return testMain();
}
