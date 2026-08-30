import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_spacing.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The page you are looking for does not exist!'),
          const SizedBox(
            height: AppSpacing.xl,
          ),
          ElevatedButton(
            onPressed: () => context.go(AppConstants.routeHome),
            child: const Text("Back to home"),
          )
        ],
      ),
    );
  }
}
