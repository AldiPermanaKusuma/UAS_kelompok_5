import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapk/bloc/addnews_bloc.dart';
import 'package:newsapk/repository/news_repository.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newsapk/repository/login_repository.dart';
import 'layout/homepage.dart';
import './bloc/login_bloc.dart';
import 'bloc/listnews_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => LoginRepository()),
          RepositoryProvider(create: (context) => NewsRepository()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: ((context) => LoginBloc(
                      loginRepository: context.read<LoginRepository>())
                    ..add(InitLogin()))),
              BlocProvider(
                  create: ((context) => AddnewsBloc(
                      newsRepository: context.read<NewsRepository>())
                    ..add(AddnewsInitialEvent()))),
              BlocProvider(
                  create: ((context) => ListnewsBloc(
                      newsRepository: context.read<NewsRepository>())
                    ..add(TampilList(keyword: 'key')))),
            ],
            child: MaterialApp(
              title: "News App",
              home: HomePage(),
            )));
  }
}
