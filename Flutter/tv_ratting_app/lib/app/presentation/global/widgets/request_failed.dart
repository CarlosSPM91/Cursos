import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/generated/assets.gen.dart';
import 'package:tv_ratting_app/app/generated/translations.g.dart';

class RequestFailed extends StatelessWidget {
  const RequestFailed({
    super.key,
    required this.onRetry,
    this.text,
  });
  final VoidCallback onRetry;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      child: Column(
        children: [
          Expanded(
            child: Assets.svg.er404.svg(),
          ),
          Text(text ?? texts.mis.requestFail),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: onRetry,
            child: Text(texts.mis.retry),
          ),
        ],
      ),
    );
  }
}
