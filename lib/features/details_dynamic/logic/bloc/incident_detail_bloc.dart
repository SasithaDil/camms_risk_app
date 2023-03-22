import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:risk_sample/core/logger.dart';
import 'package:risk_sample/features/details_dynamic/data/db_form_control.dart';

part 'incident_detail_event.dart';
part 'incident_detail_state.dart';

class IncidentDetailBloc
    extends Bloc<IncidentDetailEvent, IncidentDetailState> {
  // final FormcontrolRepository _formcontrolRepository;
  final FormReadJson _formreadJson;
  IncidentDetailBloc(this._formreadJson) : super(IncidentDetailInitial()) {
    on<IncidentDetailEvent>(_getFormControl);
  }

  FutureOr<void> _getFormControl(
    IncidentDetailEvent event,
    Emitter<IncidentDetailState> emit,
  ) async {
    emit(IncidentDetailLoading());

    final formControl = await _formreadJson.readJsonData();

    Map<String, dynamic> controllers = {};

    for (var i = 0; i < formControl.length; i++) {
      controllers['${formControl[i].objectDefinitionId}'] =
          TextEditingController();
    }

    printLog("controllers-->$controllers");

    emit(IncidentDetailLoaded(
        formCon: formControl, textControllers: controllers));
  }
}
