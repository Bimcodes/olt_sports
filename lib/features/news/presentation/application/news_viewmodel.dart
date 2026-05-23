import 'package:flutter_riverpod/legacy.dart';
import 'package:olt_sports/features/news/domain/repositories/news_repository.dart';
import 'package:olt_sports/features/news/presentation/application/news_uistate.dart';

class NewsNotifier extends StateNotifier<NewsUistate> {
  final NewsRepository repository;

  NewsNotifier(this.repository) : super(NewsUistate());
}
