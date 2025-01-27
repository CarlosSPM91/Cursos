import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/presentation/global/widgets/request_failed.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/controller/serie_controller.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/controller/state/serie_state.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/views/widgets/serie_app_bar.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/views/widgets/serie_content.dart';

class SerieView extends StatelessWidget {
  const SerieView({
    super.key,
    required this.serieId,
  });

  final int serieId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SerieController(
        SerieState.loading(),
        serieId: serieId,
        serieRepository: context.read(),
      )..init(),
      builder: (context, _) {
        final SerieController controller = context.watch();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const SerieAppBar(),
          body: controller.state.map(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (_) => RequestFailed(
              onRetry: () => controller.init(),
            ),
            loaded: (state) => SerieContent(
              state: state,
            ),
          ),
        );
      },
    );
  }
}
