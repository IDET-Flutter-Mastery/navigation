import 'package:flutter/material.dart';
import '../theme/app_durations.dart';

/// A friendly reminder shown whenever a student taps something that
/// doesn't navigate *yet*. Once go_router is wired up, replace the
/// call site with a real navigation call.
void showTodoSnackbar(BuildContext context, String label) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content:
            Text('🚧 "$label" isn\'t wired up yet — that\'s our job today!'),
        duration: AppDurations.snackbar,
      ),
    );
}
