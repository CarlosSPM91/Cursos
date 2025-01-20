import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/favorites_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/widgets/request_failed.dart';
import 'package:tv_ratting_app/app/presentation/modules/favorites/views/widgets/favorites_app_bar.dart';
import 'package:tv_ratting_app/app/presentation/modules/favorites/views/widgets/favorites_content.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesController controller = context.watch();
    return Scaffold(
      appBar: FavoritesAppBar(tabController: _tabController),
      body: controller.state.map(
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        failed: (_) => RequestFailed(
          onRetry: () => controller.init(),
        ),
        loaded: (state) => FavoritesContent(
          state: state,
          tabController: _tabController,
        ),
      ),
    );
  }
}
