// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'incident_detail_bloc.dart';

abstract class IncidentDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class IncidentDetailInitial extends IncidentDetailState {}

class IncidentDetailLoading extends IncidentDetailState {}

class IncidentDetailLoaded extends IncidentDetailState {
  // final List<FormControl> formControl;
  final List<dynamic> formCon;
  final Map<String,dynamic> textControllers;

  IncidentDetailLoaded({
    required this.formCon,
    // required this.formControl,
    required this.textControllers
  });

  @override
  List<Object> get props => [formCon,textControllers];
}

class IncidentDetailFailed extends IncidentDetailState {
  final String? error;
  IncidentDetailFailed({this.error});
  @override
  List<Object> get props => [error ?? 'Error'];
}


// final String name;
  // final String textValue;
  // final String displayName;
  // final int templateType;
  // final String templateTypeString;
  // final List selectListItem;
  // final bool isEnable;
  // final DateTime modiFiedDate;

  // IncidentDetailLoaded({
  //   required this.name,
  //   required this.textValue,
  //   required this.displayName,
  //   required this.templateType,
  //   required this.templateTypeString,
  //   required this.selectListItem,
  //   required this.isEnable,
  //   required this.modiFiedDate,
  // });