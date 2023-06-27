import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/blocs/del_task/del_task_event.dart';
import 'package:todo_app/business_logic/blocs/del_task/del_task_state.dart';
import 'package:todo_app/data/repositories/task_firbase.dart';

class DelTaskBloc extends Bloc<DelTaskEvent, DelTaskState> {
  DelTaskBloc() : super(LoadedState()) {
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
          emit(DelSuccessState());
        }
      },
    );
  }
}
