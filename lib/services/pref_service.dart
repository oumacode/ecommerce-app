import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  // Singleton pattern
  static final PrefsService _instance = PrefsService._internal();
  factory PrefsService() => _instance;
  PrefsService._internal();

  static late SharedPreferences _prefs;

  // Initialiser
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 📝 SAUVEGARDER LES DONNÉES

  static Future<void> saveUsername(String username) async {
    await _prefs.setString('username', username);
  }

  static Future<void> saveDarkMode(bool isDark) async {
    await _prefs.setBool('darkmode', isDark);
  }

  static Future<void> saveCartCount(int count) async {
    await _prefs.setInt('cart', count);
  }

  // 📖 CHARGER LES DONNÉES

  static String getUsername() {
    return _prefs.getString('username') ?? 'Invité';
  }

  static bool getDarkMode() {
    return _prefs.getBool('darkmode') ?? false;
  }

  static int getCartCount() {
    return _prefs.getInt('cart') ?? 0;
  }

  // 🔄 SAUVEGARDER TOUT EN UNE FOIS
  static Future<void> saveAll({
    String? username,
    bool? darkMode,
    int? cartCount,
  }) async {
    if (username != null) await saveUsername(username);
    if (darkMode != null) await saveDarkMode(darkMode);
    if (cartCount != null) await saveCartCount(cartCount);
  }

  // ❌ RÉINITIALISER
  static Future<void> resetAll() async {
    await _prefs.remove('username');
    await _prefs.remove('darkmode');
    await _prefs.remove('cart');
  }
}