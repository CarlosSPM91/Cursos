import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (_) => HomeController(
        HomeState(),
        trendingRepository: context.read(),
      )..init(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.favorites,
              ),
              icon: const Icon(
                Icons.favorite,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.black,
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
