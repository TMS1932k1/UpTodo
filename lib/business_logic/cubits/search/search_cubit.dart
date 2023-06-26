import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubits/search/search_state.dart';
import 'package:todo_app/data/models/task.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  void searchWithTitle(String? title, List<Task> tasks) {
    if (title == null || title.trim().isEmpty || tasks.isEmpty) {
      emit(SearchState(searchs: null));
    } else {
      emit(
        SearchState(
          searchs: tasks
              .where((task) => task.title.toLowerCase().contains(
                    title.toLowerCase(),
                  ))
              .toList(),
        ),
      );
    }
  }
}
