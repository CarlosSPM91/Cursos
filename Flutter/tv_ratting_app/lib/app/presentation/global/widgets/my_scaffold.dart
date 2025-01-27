import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/repositories/connectivity_repository.dart';
import 'package:tv_ratting_app/app/generated/translations.g.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    required this.body,
    this.appBar,
  });
  final Widget body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final ConnectivityRepository connectivityRepository = context.read();
    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: body,
            ),
            StreamBuilder<bool>(
              initialData: connectivityRepository.hasInternet,
              stream: connectivityRepository.onInternetChanged,
              builder: (_, snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: snapshot.data == false
                      ? Container(
                          width: double.infinity,
                          color: Colors.grey,
                          child: Text(
                            texts.mis.noInternet,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      : const SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
