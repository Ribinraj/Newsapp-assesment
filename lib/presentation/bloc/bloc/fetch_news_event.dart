part of 'fetch_news_bloc.dart';

@immutable
sealed class FetchNewsEvent {}

final class FetchNewsInitialEvent extends FetchNewsEvent {}

final class FetchNewsLoadMoreEvent extends FetchNewsEvent {
  final int offset;
  FetchNewsLoadMoreEvent(this.offset);
}
