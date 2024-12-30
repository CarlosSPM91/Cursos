import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/widgets/movies_and_series/trending_list.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/widgets/performers/treneding_performers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            TrendingList(),
            SizedBox(height: 20),
            TrenedingPerformers(),
          ],
        ),
      ),
    );
  }
}
