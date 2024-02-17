import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapk/layout/listnewsview.dart';
import '../bloc/listnews_bloc.dart';
import 'loading.dart';

class ListNewsState extends StatefulWidget {
  const ListNewsState({super.key});

  @override
  State<ListNewsState> createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNewsState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListnewsBloc, ListnewsState>(builder: (context, State) {
      if (State is LoadingListnews) {
        return LoadingWidget();
      } else if (State is ListnewsInitial) {
        return ListNewsViews(news: State.news, searchText: State.searchText);
      } else {
        return Container(
          child: Text("Error State"),
        );
      }
    });
  }
}
