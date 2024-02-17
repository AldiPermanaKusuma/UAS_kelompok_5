part of 'addnews_bloc.dart';

sealed class AddnewsEvent extends Equatable {}

final class AddnewsInitialEvent extends AddnewsEvent {
  @override
  List<Object> get props => [];
}

final class ClikTombolAddEvent extends AddnewsEvent {
  final String title;
  final String desc;
  final String date;
  final File img;

  ClikTombolAddEvent(
      {required this.title,
      required this.desc,
      required this.date,
      required this.img});
  @override
  List<Object> get props => [title, desc, date, img];
}
