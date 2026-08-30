import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'token';
  static const String _idKey = 'userId';
  static const String _onboardingSeenKey = 'onboardingSeen';
  static const String _loggedInKey = 'loggedIn';
  static const String _rememberEmailKey = 'rememberEmail';
  static const String _organizationKey = 'organizationName';
  static const String _interestsKey = 'interests';
  static const String _notifDropsKey = 'notifDrops';
  static const String _notifSalesKey = 'notifSales';
  static const String _notifOrdersKey = 'notifOrders';
  static const String _notifCommunityKey = 'notifCommunity';
  static const String _biometricKey = 'biometricEnabled';
  static const String _cartCountKey = 'cartCount';
  static const String _savedIdsKey = 'savedProductIds';
  static const String _eliteKey = 'eliteMember';
  static const String _eliteAnnualKey = 'eliteAnnual';
  static const String _addressesKey = 'savedAddressesJson';
  static const String _selectedAddressKey = 'selectedAddressIndex';
  static const String _profileNameKey = 'profileName';
  static const String _profilePhoneKey = 'profilePhone';
  static const String _profilePhotoKey = 'profilePhotoPath';

  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool hasToken() {
    final token = _preferences?.getString(_tokenKey);
    return token != null;
  }

  static Future<void> saveToken(String token, String id) async {
    await _preferences?.setString(_tokenKey, token);
    await _preferences?.setString(_idKey, id);
  }

  static Future<void> logoutUser() async {
    await _preferences?.remove(_tokenKey);
    await _preferences?.remove(_idKey);
    await _preferences?.setBool(_loggedInKey, false);
  }

  static String? get userId => _preferences?.getString(_idKey);

  static String? get token => _preferences?.getString(_tokenKey);

  static bool hasSeenOnboarding() {
    return _preferences?.getBool(_onboardingSeenKey) ?? false;
  }

  static Future<void> setOnboardingSeen() async {
    await _preferences?.setBool(_onboardingSeenKey, true);
  }

  static bool isLoggedIn() {
    return _preferences?.getBool(_loggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    await _preferences?.setBool(_loggedInKey, value);
  }

  static String? get rememberedEmail =>
      _preferences?.getString(_rememberEmailKey);

  static Future<void> setRememberedEmail(String? email) async {
    if (email == null || email.isEmpty) {
      await _preferences?.remove(_rememberEmailKey);
    } else {
      await _preferences?.setString(_rememberEmailKey, email);
    }
  }

  static String? get organizationName =>
      _preferences?.getString(_organizationKey);

  static Future<void> setOrganizationName(String? name) async {
    if (name == null || name.isEmpty) {
      await _preferences?.remove(_organizationKey);
    } else {
      await _preferences?.setString(_organizationKey, name);
    }
  }

  static List<String> get interests {
    return _preferences?.getStringList(_interestsKey) ?? const [];
  }

  static Future<void> setInterests(List<String> values) async {
    await _preferences?.setStringList(_interestsKey, values);
  }

  static bool get notifDrops => _preferences?.getBool(_notifDropsKey) ?? true;
  static bool get notifSales => _preferences?.getBool(_notifSalesKey) ?? true;
  static bool get notifOrders => _preferences?.getBool(_notifOrdersKey) ?? true;
  static bool get notifCommunity =>
      _preferences?.getBool(_notifCommunityKey) ?? true;

  static Future<void> setNotificationPrefs({
    required bool drops,
    required bool sales,
    required bool orders,
    required bool community,
  }) async {
    await _preferences?.setBool(_notifDropsKey, drops);
    await _preferences?.setBool(_notifSalesKey, sales);
    await _preferences?.setBool(_notifOrdersKey, orders);
    await _preferences?.setBool(_notifCommunityKey, community);
  }

  static bool get biometricEnabled =>
      _preferences?.getBool(_biometricKey) ?? false;

  static Future<void> setBiometricEnabled(bool value) async {
    await _preferences?.setBool(_biometricKey, value);
  }

  static int get cartCount => _preferences?.getInt(_cartCountKey) ?? 2;

  static Future<void> setCartCount(int value) async {
    await _preferences?.setInt(_cartCountKey, value);
  }

  static List<String> get savedIds =>
      _preferences?.getStringList(_savedIdsKey) ?? const [];

  static Future<void> setSavedIds(List<String> values) async {
    await _preferences?.setStringList(_savedIdsKey, values);
  }

  static bool get isElite => _preferences?.getBool(_eliteKey) ?? false;

  static Future<void> setElite(bool value) async {
    await _preferences?.setBool(_eliteKey, value);
  }

  static bool get eliteAnnual =>
      _preferences?.getBool(_eliteAnnualKey) ?? false;

  static Future<void> setEliteAnnual(bool value) async {
    await _preferences?.setBool(_eliteAnnualKey, value);
  }

  static int get selectedAddressIndex =>
      _preferences?.getInt(_selectedAddressKey) ?? 0;

  static List<Map<String, dynamic>> get savedAddressMaps {
    final raw = _preferences?.getString(_addressesKey);
    if (raw == null || raw.isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } catch (_) {
      return const [];
    }
  }

  static Future<void> setSavedAddresses({
    required List<Map<String, dynamic>> addresses,
    required int selectedIndex,
  }) async {
    await _preferences?.setString(_addressesKey, jsonEncode(addresses));
    await _preferences?.setInt(_selectedAddressKey, selectedIndex);
  }

  static String get profileName =>
      _preferences?.getString(_profileNameKey) ?? 'Marcus Johnson';

  static Future<void> setProfileName(String name) async {
    await _preferences?.setString(_profileNameKey, name);
  }

  static String get profilePhone =>
      _preferences?.getString(_profilePhoneKey) ?? '';

  static Future<void> setProfilePhone(String phone) async {
    await _preferences?.setString(_profilePhoneKey, phone);
  }

  static String get profilePhotoPath =>
      _preferences?.getString(_profilePhotoKey) ?? '';

  static Future<void> setProfilePhotoPath(String path) async {
    if (path.isEmpty) {
      await _preferences?.remove(_profilePhotoKey);
    } else {
      await _preferences?.setString(_profilePhotoKey, path);
    }
  }
}
