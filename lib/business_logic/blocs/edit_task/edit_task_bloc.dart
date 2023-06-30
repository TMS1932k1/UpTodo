import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/blocs/edit_task/edit_task_event.dart';
import 'package:todo_app/business_logic/blocs/edit_task/edit_task_state.dart';
import 'package:todo_app/data/repositories/task_firbase.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc() : super(LoadedState()) {
    on<DelEvent>(
      (event, emit) async {
        emit(LoadingState());
        final error = await delTask(
          user: event.user,
          id: event.id,
        );

        if (error != null) {
          emit(ErrorState());
        } else {
          emit(EditSuccessState('Delete task successfully'));
        }
      },
    );
    on<CompleteEvent>(
      (event, emit) async {
        emit(LoadingState());
        final error = await completeTask(
          user: event.user,
          id: event.id,
        );

        if (error != null) {
          emit(ErrorState());
        } else {
          emit(EditSuccessState('Edited task successfully'));
        }
      },
    );
    on<EditEvent>(
      (event, emit) async {
        emit(LoadingState());
        final error = await editTask(
          user: event.user,
          id: event.id,
          changes: event.changes,
        );

        if (error != null) {
          emit(ErrorState());
        } else {
          emit(EditSuccessState('Edited task successfully'));
        }
      },
    );
  }
}
