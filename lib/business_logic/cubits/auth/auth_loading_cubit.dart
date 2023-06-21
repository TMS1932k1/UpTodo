import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubits/auth/auth_loading_state.dart';

class AuthLoadingCubit extends Cubit<AuthLoadingState> {
  AuthLoadingCubit() : super(AuthLoadingState(isLoading: false));

  void startLoading() => emit(AuthLoadingState(isLoading: true));
  void stopLoading() => emit(AuthLoadingState(isLoading: false));
}
