import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_theme_template/src/settings/settings_service.dart';

part 'settings_controller.g.dart';

/// RiverpodClass that provides the current [ThemeMode].
@riverpod
class SettingsController extends _$SettingsController {
  @override
  ThemeMode build() {
    return ref.watch(settingsServiceProvider).value ?? ThemeMode.system;
  }

  /// Updates the theme mode calling the [SettingsService] method.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    await ref
        .read(settingsServiceProvider.notifier)
        .updateThemeMode(newThemeMode!);
  }
}
