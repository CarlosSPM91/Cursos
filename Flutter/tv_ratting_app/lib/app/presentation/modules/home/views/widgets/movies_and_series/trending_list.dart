import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/repositories/trending_repository.dart';
import 'package:tv_ratting_app/app/domain/time_window.dart';
import 'package:tv_ratting_app/app/presentation/global/widgets/request_failed.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/widgets/movies_and_series/trending_tile.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/widgets/movies_and_series/trending_time_window.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  TrendingRepository get _repository => context.read();
  late Future<EitherListMedia> _future;
  TimeWindow _timeWindow = TimeWindow.day;

  @override
  void initState() {
    super.initState();
    _future = _repository.getMoviesAndSeries(_timeWindow);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindow(
          timeWindow: _timeWindow,
          onChanged: (timeWindow) {
            setState(() {
              _timeWindow = timeWindow;
              _future = _repository.getMoviesAndSeries(_timeWindow);
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(builder: (_, constraints) {
            final width = constraints.maxHeight * 0.65;
            return Center(
              child: FutureBuilder<EitherListMedia>(
                key: ValueKey(_future),
                future: _future,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return snapshot.data!.when(
                    left: (failure) => RequestFailed(onRetry: () {
                      setState(() {
                        _future = _repository.getMoviesAndSeries(_timeWindow);
                      });
                    }),
                    right: (list) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          final media = list[index];
                          return TrendingTile(
                            media: media,
                            width: width,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 10,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
