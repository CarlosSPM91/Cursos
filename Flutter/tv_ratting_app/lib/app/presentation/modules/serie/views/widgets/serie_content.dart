import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/controller/state/serie_state.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/views/widgets/serie_cast.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/views/widgets/serie_header.dart';

class SerieContent extends StatelessWidget {
  const SerieContent({
    super.key,
    required this.state,
  });

  final SerieStateLoaded state;

  @override
  Widget build(BuildContext context) {
    final serie = state.serie;
    return SingleChildScrollView(
      child: Column(
        children: [
          SerieHeader(
            serie: serie,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(serie.overview),
          ),
          SerieCast(serieId: serie.id),
        ],
      ),
    );
  }
}
