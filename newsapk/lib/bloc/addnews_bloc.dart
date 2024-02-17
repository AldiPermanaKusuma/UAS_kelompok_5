import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapk/bloc/login_bloc.dart';
import 'dart:io';

import 'package:newsapk/repository/news_repository.dart';

part 'addnews_event.dart';
part 'addnews_state.dart';

class AddnewsBloc extends Bloc<AddnewsEvent, AddnewsState> {
  NewsRepository newsRepository;

  AddnewsBloc({required this.newsRepository}) : super(AddnewsInitial()) {
    on<AddnewsInitialEvent>(_addnewsinitial);
    on<ClikTombolAddEvent>(_addnewsclik);
  }

  _addnewsinitial(AddnewsInitialEvent event, Emitter emit) {
    emit(LoginLoading());
    emit(LoginInitial());
  }

  _addnewsclik(ClikTombolAddEvent event, Emitter emit) async {
    final String judul = event.title;
    final String deskripsi = event.desc;
    final String tanggal = event.date;
    final File gambar = event.img;
    emit(LoginLoading());
    try {
      final result = await newsRepository.addNews(
          title: judul, desc: deskripsi, date: tanggal, image: gambar);
      emit(AddnewsSuccessState());
      await Future.delayed(Duration(seconds: 3));
      emit(AddnewsInitial());
    } catch (error) {
      emit(AddnewsErrorState(message: "Error $error"));
    }
  }
}
