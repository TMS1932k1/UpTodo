import 'package:equatable/equatable.dart';

abstract class DelTaskState extends Equatable {}

class LoadingState extends DelTaskState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends DelTaskState {
  @override
  List<Object?> get props => [];
}

class DelSuccessState extends DelTaskState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends DelTaskState {
  @override
  List<Object?> get props => [];
}
