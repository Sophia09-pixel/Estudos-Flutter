import 'dart:convert';
import 'package:estudos_cp/model/time.dart';
import 'package:flutter/services.dart';

class TimeRepository {
  final String jsonPath;

  TimeRepository({this.jsonPath = 'assets/data/times.json'});
  
    Future<List<Time>> fetchTime() async {
    final jsonString = await rootBundle.loadString(jsonPath);
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Time.fromJson(json)).toList();
  }
}
