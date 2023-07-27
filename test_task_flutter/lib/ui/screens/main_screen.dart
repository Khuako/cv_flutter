import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_flutter/constants/constant_text.dart';
import 'package:test_task_flutter/cubit/news_cubit.dart';
import 'package:test_task_flutter/model/news_model.dart';
import 'package:test_task_flutter/resources/helper_function.dart';
import 'package:test_task_flutter/routes/routes.dart';
import 'package:test_task_flutter/ui/screens/news_detail_screen.dart';
import 'package:test_task_flutter/ui/widgets/featured_tile.dart';
import 'package:test_task_flutter/ui/widgets/news_tile.dart';
import 'package:test_task_flutter/ui/widgets/show_snack_bar_widget.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void nextPage(News news, BuildContext context) {
    AutoRouter.of(context).push(NewsDetailRoute(news: news));
  }

  @override
  void initState() {
    HelperFunction.getSeen();
    super.initState();
  }

  bool hasPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifications',
          style: ConstantText.appBarText,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoaded) {
                  return GestureDetector(
                    onTap: () async {
                      if (hasPressed == false) {
                        for (int i = 0; i < state.news.length; i++) {
                          HelperFunction.saveSeen(state.news[i].id!);
                          hasPressed = true;
                          setState(() {});
                        }
                      } else if (hasPressed == true) {
                        showSnackBar(context, Colors.grey,
                            "You've already marked all the news as read.");
                        setState(() {});
                      }
                    },
                    child: Text(
                      'Mark all read',
                      style: ConstantText.appBarText,
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 410,
            elevation: 50,
            stretch: true,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured',
                      style: ConstantText.categoryText,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<NewsCubit, NewsState>(
                      builder: (context, state) {
                        if (state is NewsLoading) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          );
                        }
                        if (state is NewsLoaded) {
                          List<News> newsList = state.news;
                          return SizedBox(
                            height: 300,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    nextPage(newsList[index], context);
                                  },
                                  child: FeaturedTile(
                                      imageUrl: newsList[index].imageUrl!,
                                      title: newsList[index].title!),
                                );
                              },
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Latest News',
                    style: ConstantText.categoryText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height: 900,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return BlocBuilder<NewsCubit, NewsState>(
                          builder: (context, state) {
                            if (state is NewsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.black),
                              );
                            }
                            if (state is NewsLoaded) {
                              List<News> newsList = state.news;
                              bool? hasSeen = HelperFunction.getSeenNews()
                                  .contains(newsList[index + 3].id);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await HelperFunction.saveSeen(
                                          newsList[index + 3].id!);
                                      nextPage(newsList[index + 3], context);
                                      setState(() {});
                                    },
                                    child: NewsTile(
                                      daysAgo: '1',
                                      imageUrl: newsList[index + 3].imageUrl!,
                                      title: newsList[index + 3].title!,
                                      hasSeen: hasSeen,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ])),
        ],
        // children: [

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'Featured',
        //         style: ConstantText.categoryText,
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       BlocBuilder<NewsCubit, NewsState>(
        //         builder: (context, state) {
        //           if (state is NewsLoading) {
        //             return const Center(
        //               child: CircularProgressIndicator(color: Colors.black),
        //             );
        //           }
        //           if (state is NewsLoaded) {
        //             List<News> newsList = state.news;
        //             return SizedBox(
        //               height: 300,
        //               child: ListView.builder(
        //                 shrinkWrap: true,
        //                 physics: AlwaysScrollableScrollPhysics(),
        //                 scrollDirection: Axis.horizontal,
        //                 itemCount: 3,
        //                 itemBuilder: (context, index) {
        //                   return GestureDetector(
        //                     onTap: () {
        //                       nextPage(newsList[index], context);
        //                     },
        //                     child: FeaturedTile(
        //                         imageUrl: newsList[index].imageUrl!,
        //                         title: newsList[index].title!),
        //                   );
        //                 },
        //               ),
        //             );
        //           }
        //           return Container();
        //         },
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       Text(
        //         'Latest News',
        //         style: ConstantText.categoryText,
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       Container(
        //         width: 350,
        //         height: 900,
        //         child: ListView.builder(
        //           physics: NeverScrollableScrollPhysics(),
        //           itemCount: 6,
        //           itemBuilder: (context, index) {
        //             return BlocBuilder<NewsCubit, NewsState>(
        //               builder: (context, state) {
        //                 if (state is NewsLoading) {
        //                   return const Center(
        //                     child:
        //                         CircularProgressIndicator(color: Colors.black),
        //                   );
        //                 }
        //                 if (state is NewsLoaded) {
        //                   List<News> newsList = state.news;
        //                   bool? hasSeen = HelperFunction.getSeenNews()
        //                       .contains(newsList[index + 3].id);
        //                   return Padding(
        //                     padding: const EdgeInsets.only(bottom: 15),
        //                     child: SizedBox(
        //                       child: GestureDetector(
        //                         onTap: () async {
        //                           await HelperFunction.saveSeen(
        //                               newsList[index + 3].id!);
        //                           nextPage(newsList[index + 3], context);
        //                           setState(() {});
        //                         },
        //                         child: NewsTile(
        //                           daysAgo: '1',
        //                           imageUrl: newsList[index + 3].imageUrl!,
        //                           title: newsList[index + 3].title!,
        //                           hasSeen: hasSeen,
        //                         ),
        //                       ),
        //                     ),
        //                   );
        //                 }
        //                 return Container();
        //               },
        //             );
        //           },
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // ],
      ),
    );
  }
}
