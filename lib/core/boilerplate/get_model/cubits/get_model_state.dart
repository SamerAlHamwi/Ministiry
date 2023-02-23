part of 'get_model_cubit.dart';

@immutable
abstract class GetModelState {}

class GetModelInitial extends GetModelState {}


class Loading extends GetModelState  {}

class GetModelSuccessfully extends GetModelState  {
  final   model;

  GetModelSuccessfully(this.model);
}

class Error  extends GetModelState  {
  final String message;
  Error(this.message);
}