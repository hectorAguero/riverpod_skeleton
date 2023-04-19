import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_skeleton/src/app.dart';

void main() {
  //Android navigation bar tranparent
  WidgetsFlutterBinding.ensureInitialized();
  setAndroidNavigationBar();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Set the Android navigation bar to transparent.
void setAndroidNavigationBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
}
