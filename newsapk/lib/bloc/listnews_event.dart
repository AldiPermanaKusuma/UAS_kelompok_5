part of 'listnews_bloc.dart';

sealed class ListnewsEvent extends Equatable {}

class TampilList extends ListnewsEvent {
  final String keyword;

  TampilList({required this.keyword});

  @override
  List<Object> get props => [];
}
