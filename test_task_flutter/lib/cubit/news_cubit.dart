import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task_flutter/model/news_model.dart';
import 'package:test_task_flutter/resources/news_api_provider.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  Future<void> fetchNewsList() async {
    emit(NewsLoading());
    try {
      final result = await NewsApiProvider().fetchNews();
      emit(NewsLoaded(news: result));
    } on Exception catch (e) {
      emit(NewsFailure());
    }
  }
}
