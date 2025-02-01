import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/inject_repositories.dart';
import 'package:tv_ratting_app/app/presentation/global/widgets/my_scaffold.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/controller/home_controller.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/controller/home_state.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/widgets/movies_and_series/trending_list.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/widgets/performers/trending_performers.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    return ChangeNotifierProvider(
      key: Key("home-$languageCode"),
      create: (_) => HomeController(
        HomeState(),
        trendingRepository: Repositories.trending,
      )..init(),
      child: MyScaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.favorites,
              ),
              icon: const Icon(
                Icons.favorite,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.profile);
              },
              icon: const Icon(
                Icons.person,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => RefreshIndicator(
              onRefresh: () => context.read<HomeController>().init(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: const Column(
                    children: [
                      SizedBox(height: 10),
                      TrendingList(),
                      SizedBox(height: 20),
                      TrendingPerformers(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
