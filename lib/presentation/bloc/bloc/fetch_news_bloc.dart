import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:news_app/data/models/newsmodel.dart';
import 'package:news_app/domain/repositary/news_repo.dart';

part 'fetch_news_event.dart';
part 'fetch_news_state.dart';

class FetchNewsBloc extends Bloc<FetchNewsEvent, FetchNewsState> {
  final int limit = 20;

  FetchNewsBloc() : super(FetchNewsInitial()) {
    on<FetchNewsInitialEvent>(_fetchInitialEvent);
    on<FetchNewsLoadMoreEvent>(_fetchLoadMoreEvent);
  }

  FutureOr<void> _fetchInitialEvent(
      FetchNewsInitialEvent event, Emitter<FetchNewsState> emit) async {
    emit(FetchNewsLoadingState());
    try {
      final Response response = await NewsRepo.fetchNews(limit: limit, offset: 0);
      if (response.statusCode == 200) {
        List<NewsModel> fetchNews = (jsonDecode(response.body) as List)
            .map((data) => NewsModel.fromJson(data as Map<String, dynamic>))
            .toList();
        emit(FetchNewsSuccessState(fetchNews: fetchNews));
      } else {
        emit(FetchNewsErrorState());
        log('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      emit(FetchNewsErrorState());
      log('Exception occurred: $e');
    }
  }

  FutureOr<void> _fetchLoadMoreEvent(
      FetchNewsLoadMoreEvent event, Emitter<FetchNewsState> emit) async {
    if (state is FetchNewsSuccessState) {
      try {
        final Response response = await NewsRepo.fetchNews(limit: limit, offset: event.offset);
        if (response.statusCode == 200) {
          List<NewsModel> additionalNews = (jsonDecode(response.body) as List)
              .map((data) => NewsModel.fromJson(data as Map<String, dynamic>))
              .toList();
          final currentNews = (state as FetchNewsSuccessState).fetchNews;
          emit(FetchNewsSuccessState(fetchNews: [...currentNews, ...additionalNews]));
        } else {
          emit(FetchNewsErrorState());
          log('Error: ${response.statusCode} - ${response.reasonPhrase}');
        }
      } catch (e) {
        emit(FetchNewsErrorState());
        log('Exception occurred: $e');
      }
    }
  }
}
