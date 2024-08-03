part of 'fetch_news_bloc.dart';

@immutable
sealed class FetchNewsState {}

final class FetchNewsInitial extends FetchNewsState {}

final class FetchNewsLoadingState extends FetchNewsState {}

final class FetchNewsSuccessState extends FetchNewsState {
  final List<NewsModel> fetchNews;

  FetchNewsSuccessState({required this.fetchNews});
}

final class FetchNewsErrorState extends FetchNewsState {}
