import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapk/repository/news_repository.dart';

part 'listnews_event.dart';
part 'listnews_state.dart';

class ListnewsBloc extends Bloc<ListnewsEvent, ListnewsState> {
  NewsRepository newsRepository;
  ListnewsBloc({required this.newsRepository}) : super(LoadingListnews()) {
    on<TampilList>(_tampilList);
  }

  _tampilList(TampilList event, Emitter emirt) async {
    String key = event.keyword;
    emit(LoadingListnews());
    List res = await newsRepository.getlistNews(key);
    emit(ListnewsInitial(news: res, searchText: key));
  }
}
