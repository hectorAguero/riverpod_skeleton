import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_skeleton/src/settings/settings_controller.dart';
import 'package:riverpod_skeleton/src/settings/settings_service.dart';
import 'package:riverpod_skeleton/src/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> mockThemeModeInCache({
  required SharedPreferences prefs,
  required ThemeMode themeMode,
}) async {
  await prefs.setInt('theme_mode', themeMode.index);
}

void main() {
  group('SettingController tests...', () {
    late SharedPreferences prefs;
    late ProviderContainer container;

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)],
      );
      addTearDown(container.dispose);
    });

    test('returns ThemeMode.system by default', () async {
      final themeMode = container.read(settingsControllerProvider);
      expect(themeMode, ThemeMode.system);
    });

    test('returns a specific ThemeMode if is on cache', () async {
      await mockThemeModeInCache(prefs: prefs, themeMode: ThemeMode.light);
      final firstThemeMode = container.read(settingsControllerProvider);
      expect(firstThemeMode, ThemeMode.system);
      await container.read(settingsServiceProvider.future);
      final finalThemeMode = container.read(settingsControllerProvider);
      expect(finalThemeMode, ThemeMode.light);
    });

    test('updates theme mode correctly', () async {
      await mockThemeModeInCache(prefs: prefs, themeMode: ThemeMode.light);
      final controller = container.read(settingsControllerProvider.notifier);
      await controller.updateThemeMode(ThemeMode.dark);
      final themeMode = container.read(settingsControllerProvider);
      expect(themeMode, ThemeMode.dark);
      final cache = await container.read(sharedPreferencesProvider.future);
      expect(cache.getInt('theme_mode'), ThemeMode.dark.index);
    });
  });
}
