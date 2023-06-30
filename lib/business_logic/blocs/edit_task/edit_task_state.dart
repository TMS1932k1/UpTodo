import 'package:equatable/equatable.dart';

abstract class EditTaskState extends Equatable {}

class LoadingState extends EditTaskState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends EditTaskState {
  @override
  List<Object?> get props => [];
}

class EditSuccessState extends EditTaskState {
  final String mesSuccess;

  EditSuccessState(this.mesSuccess);

  @override
  List<Object?> get props => [];
}

class ErrorState extends EditTaskState {
  @override
  List<Object?> get props => [];
}
