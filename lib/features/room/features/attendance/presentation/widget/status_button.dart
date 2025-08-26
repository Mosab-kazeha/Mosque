import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

class StatusButton extends StatelessWidget {
  final String label;
  final int delayValue;
  final Color color;
  final int? selected;
  final Function(int) onSetDelay;
  const StatusButton({
    super.key,
    required this.label,
    required this.delayValue,
    required this.selected,
    required this.color,
    required this.onSetDelay,
  });

  @override
  Widget build(BuildContext context) {
    if (delayValue == 500) {
      final isSelected = selected != null && selected! > 0 && selected! <= 90;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () async {
            final options = [5, 10, 15, 20, 30, 45, 60, 90];
            final chosenDelay = await showModalBottomSheet<int>(
              context: context,
              builder:
                  (context) => ListView(
                    children:
                        options
                            .map(
                              (minute) => ListTile(
                                title: ResponsiveText(
                                  'متأخر $minute دقيقة',
                                  fontSize: FontTextSize.bodyFontSize,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),

                                onTap: () => Navigator.pop(context, minute),
                              ),
                            )
                            .toList(),
                  ),
            );

            if (chosenDelay != null) {
              onSetDelay(chosenDelay);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ResponsiveText(
              isSelected ? 'متأخر ($selected  د)' : label,
              fontSize: FontTextSize.bodyFontSize,
              color: isSelected ? Colors.white : Colors.black,

              // style: FontStyles.bodyText.copyWith(
              //   fontSize: 16,
              // ),
            ),
          ),
        ),
      );
    }

    final isSelected = delayValue == selected;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => onSetDelay(delayValue),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ResponsiveText(
            label,
            fontSize: FontTextSize.bodyFontSize,
            color: isSelected ? Colors.white : Colors.black,
            // style: FontStyles.bodyText.copyWith(
            //   fontSize: 16,
            // ),
          ),
        ),
      ),
    );
  }
}
