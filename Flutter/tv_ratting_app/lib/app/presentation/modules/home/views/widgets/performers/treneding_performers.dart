import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';
import 'package:tv_ratting_app/app/domain/repositories/trending_repository.dart';
import 'package:tv_ratting_app/app/presentation/global/widgets/request_failed.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/widgets/performers/performer_tile.dart';

typedef EitherListPerformer = Either<HttpRequestFailure, List<Performer>>;

class TrenedingPerformers extends StatefulWidget {
  const TrenedingPerformers({super.key});

  @override
  State<TrenedingPerformers> createState() => _TrnedingPerformersState();
}

class _TrnedingPerformersState extends State<TrenedingPerformers> {
  late Future<EitherListPerformer> _future;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _future = context.read<TrendingRepository>().getPerformers();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<EitherListPerformer>(
        key: ValueKey(_future),
        future: _future,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.when(
            left: (_) => RequestFailed(onRetry: () {
              setState(() {
                _future = context.read<TrendingRepository>().getPerformers();
              });
            }),
            right: (list) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    final performer = list[index];
                    return PerformerTile(
                      performer: performer,
                    );
                  },
                ),
                Positioned(
                  bottom: 30,
                  child: AnimatedBuilder(
                      animation: _pageController,
                      builder: (_, __) {
                        final int currentCard = _pageController.page?.toInt() ?? 0;
                        return Row(
                          children: List.generate(
                            list.length,
                            (index) => Icon(
                              Icons.circle,
                              color: currentCard == index ? Colors.cyan : Colors.white30,
                              size: 14,
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
