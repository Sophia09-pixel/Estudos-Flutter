import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:estudos_cp/model/time.dart';
class SettingsRepository {
  static const _keyRecentTimes = 'RecentTimes';

  final SharedPreferences _prefs;
  SettingsRepository._(this._prefs);

  static Future<SettingsRepository> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsRepository._(prefs);
  }

  /// Adiciona um time à lista de recentes
  Future<void> addRecentTime(Time time) async {
    final recentList = await getRecentTimes();

    // Remove duplicado se já existir
    recentList.removeWhere((t) => t.id == time.id);

    // Adiciona no início da fila
    recentList.insert(0, time);

    // Limita a 3 últimos
    if (recentList.length > 3) {
      recentList.removeLast();
    }

    final jsonList = recentList.map((t) => t.toJson()).toList();
    await _prefs.setString(_keyRecentTimes, jsonEncode(jsonList));
  }

  /// Recupera a lista de recentes
  Future<List<Time>> getRecentTimes() async {
    final jsonString = _prefs.getString(_keyRecentTimes);
    if (jsonString == null) return [];

    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => Time.fromJson(e)).toList();
  }

  /// Limpa recentes
  Future<void> clearRecentTimes() async {
    await _prefs.remove(_keyRecentTimes);
  }
}