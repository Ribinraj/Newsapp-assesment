import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/presentation/bloc/bloc/fetch_news_bloc.dart';
import 'package:news_app/presentation/screens/home_page/widgets/methods.dart';
import 'package:news_app/presentation/screens/widgets/debouncer.dart';

class ScreenHomepage extends StatefulWidget {
  const ScreenHomepage({super.key});

  @override
  State<ScreenHomepage> createState() => _ScreenHomepageState();
}

class _ScreenHomepageState extends State<ScreenHomepage> {
  int currentOffset = 0;

  @override
  void initState() {
    super.initState();
    context.read<FetchNewsBloc>().add(FetchNewsInitialEvent());
  }

  final Debouncer debouncer = Debouncer(milliseconds: 500);

  Future<void> fetchDataWithDebounce() async {
    await debouncer.run(() async {
      context.read<FetchNewsBloc>().add(FetchNewsInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
                margin: const EdgeInsets.only(left: 12),
                child: Image.asset('assets/images/channels4_profile.jpg')),
          ),
          title: const Text(
            'KUMUDAM NEWS',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 154, 40, 31),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<FetchNewsBloc, FetchNewsState>(
          builder: (context, state) {
            if (state is FetchNewsLoadingState) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: kredcolor, size: 40),
              );
            } else if (state is FetchNewsSuccessState) {
              return RefreshIndicator(
                onRefresh: fetchDataWithDebounce,
                child: ListView.builder(
                  itemCount: state.fetchNews.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.fetchNews.length) {
                      final news = state.fetchNews[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            color: kwhitecolor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 250,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      newsimage(news),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 110,
                                  color: kwhitecolor,
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 11, right: 8, top: 8),
                                    child: Text(news.title.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                newstime(news)
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              currentOffset += 20;
                              context
                                  .read<FetchNewsBloc>()
                                  .add(FetchNewsLoadMoreEvent(currentOffset));
                            },
                            child: const Text(
                              'Load More',
                              style: TextStyle(color: kgreycolor),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            } else if (state is FetchNewsErrorState) {
              return const Center(
                child: Text(
                  'Error fetching news. Please try again later.',
                  style: TextStyle(color: kredcolor),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
