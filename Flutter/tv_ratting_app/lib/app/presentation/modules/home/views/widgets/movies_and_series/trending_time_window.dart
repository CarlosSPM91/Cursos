import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/domain/time_window.dart';
import 'package:tv_ratting_app/app/generated/translations.g.dart';
import 'package:tv_ratting_app/app/presentation/global/colors.dart';
import 'package:tv_ratting_app/app/presentation/global/extensions/build_context_extension.dart';

class TrendingTimeWindow extends StatelessWidget {
  const TrendingTimeWindow({
    super.key,
    required this.timeWindow,
    required this.onChanged,
  });
  final TimeWindow timeWindow;
  final void Function(TimeWindow) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Text(
            texts.home.trending,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              color: context.darkMode ? AppColors.dark : const Color(0xfff0f0f0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<TimeWindow>(
                  value: timeWindow,
                  isDense: true,
                  underline: const SizedBox(),
                  items: [
                    DropdownMenuItem(
                      value: TimeWindow.day,
                      child: Text(texts.home.dropDownButton.last24),
                    ),
                    DropdownMenuItem(
                      value: TimeWindow.week,
                      child: Text(texts.home.dropDownButton.lastWeek),
                    ),
                  ],
                  onChanged: (newTimeWindow) {
                    if (newTimeWindow != null && newTimeWindow != timeWindow) {
                      onChanged(newTimeWindow);
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
