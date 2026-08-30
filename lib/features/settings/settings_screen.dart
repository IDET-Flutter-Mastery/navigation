import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/todo_snackbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        children: const [
          _SectionLabel('Account'),
          _SettingsTile(icon: Icons.person_outline_rounded, label: 'Profile'),
          _SettingsTile(
              icon: Icons.notifications_none_rounded, label: 'Notifications'),
          _SectionLabel('Playback'),
          _SettingsTile(
              icon: Icons.high_quality_outlined, label: 'Video Quality'),
          _SettingsTile(icon: Icons.download_outlined, label: 'Downloads'),
          _SectionLabel('About'),
          _SettingsTile(
              icon: Icons.info_outline_rounded, label: 'About CineVerse'),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl, AppSpacing.xl, AppSpacing.xl, AppSpacing.sm),
      child: Text(
        text.toUpperCase(),
        style: AppTypography.overline.copyWith(color: AppColors.textMuted),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SettingsTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing:
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
      onTap: () => showTodoSnackbar(context, label),
    );
  }
}
