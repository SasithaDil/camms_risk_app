import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:risk_sample/core/logger.dart';
import 'package:risk_sample/features/details_dynamic/domain/form_control.dart';

class FormReadJson {
  Future<List<dynamic>> readJsonData() async {
    //read json file
    final jsondata = await rootBundle.loadString('assets/form_controls.json');

    //decode json data as list
    final list = json.decode(jsondata);

    printLog(list);
    // return list;

    //map json and initialize using DataModel
    return list['FormControls'].map((e) => FormControl.fromMap(e)).toList();
  }
}
