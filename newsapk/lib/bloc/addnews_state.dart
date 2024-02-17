part of 'addnews_bloc.dart';

sealed class AddnewsState extends Equatable {
  const AddnewsState();

  @override
  List<Object> get props => [];
}

final class AddnewsInitial extends AddnewsState {
  @override
  List<Object> get props => [];
}

final class AddnewsLoadingState extends AddnewsState {
  @override
  List<Object> get props => [];
}

final class AddnewsSuccessState extends AddnewsState {
  @override
  List<Object> get props => [];
}

final class AddnewsErrorState extends AddnewsState {
  String message;

  AddnewsErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
