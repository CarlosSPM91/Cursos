import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';
import 'package:tv_ratting_app/app/inject_repositories.dart';
import 'package:tv_ratting_app/app/presentation/global/widgets/request_failed.dart';
import 'package:tv_ratting_app/app/presentation/utils/get_image_url.dart';

class SerieCast extends StatefulWidget {
  const SerieCast({
    super.key,
    required this.serieId,
  });
  final int serieId;

  @override
  State<SerieCast> createState() => _SerieCastState();
}

class _SerieCastState extends State<SerieCast> {
  late Future<Either<HttpRequestFailure, List<Performer>>> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  void _initFuture() {
    _future = Repositories.series.getCastBySerie(widget.serieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpRequestFailure, List<Performer>>>(
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
              _initFuture();
            });
          }),
          right: (cast) => Column(
            children: [
              const Text(
                "Cast",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: cast.length,
                  itemBuilder: (_, index) {
                    final performer = cast[index];
                    return Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (_, constraints) {
                              final size = constraints.maxHeight;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(size / 2),
                                child: ExtendedImage.network(
                                  width: size,
                                  height: size,
                                  fit: BoxFit.cover,
                                  getImageUrl(performer.profilePath),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          performer.name,
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
