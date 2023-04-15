import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_theme_template/src/shared_preferences_provider.dart';

part 'settings_service.g.dart';

/// RiverpodAlwaysAliveClass that provides the current [ThemeMode] as a Future
@Riverpod(keepAlive: true)
class SettingsService extends _$SettingsService {
  @override
  FutureOr<ThemeMode> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return ThemeMode.values[prefs.getInt('theme_mode') ?? 0];
  }

  /// Updates the theme mode in the state and cache
  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    state = AsyncData(theme);
    await prefs.setInt('theme_mode', state.value!.index);
  }
}
