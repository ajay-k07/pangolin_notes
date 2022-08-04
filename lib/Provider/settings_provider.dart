import 'package:flutter/material.dart';
import 'package:pangolin_notes/service/settings_service_impl.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPrefSettingsService _service;

  SettingsProvider(this._service);

  bool get showOnboarding => _service.showOnBoardingScreen();

  Future<void> showOnboardingCompleted() async {
    await _service.onBoardingScreenCompleted();
    notifyListeners();
  }
}
