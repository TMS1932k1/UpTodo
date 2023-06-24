import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubits/home/add_loading_state.dart';

class AddLoadingCubit extends Cubit<AddLoadingState> {
  AddLoadingCubit() : super(AddLoadingState(isLoading: false));

  void startLoading() => emit(AddLoadingState(isLoading: true));
  void stopLoading() => emit(AddLoadingState(isLoading: false));
}
