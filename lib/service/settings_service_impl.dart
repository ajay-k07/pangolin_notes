import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefSettingsService {
  static const String backgroundEffectKey = 'backgroundEffectKey';
  static late SharedPreferences _preferences;
  factory SharedPrefSettingsService() {
    return _settingsService;
  }
  SharedPrefSettingsService._privateConstructor();
  static final SharedPrefSettingsService _settingsService =
      SharedPrefSettingsService._privateConstructor();

  static Future<void> setup() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveString(String key, String value) {
    return _preferences.setString(key, value);
  }

  Future<bool> saveInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  WindowEffect getWindowEffect() {
    final val = _preferences.getString(backgroundEffectKey);
    return WindowEffect.values.firstWhere(
      (element) => element.name == val,
      orElse: () => WindowEffect.acrylic,
    );
  }

  void setWindowEffect(WindowEffect value) {
    _preferences.setString(backgroundEffectKey, value.name);
  }

  Future<void> setupMock() async {
    await setup();
  }
}
