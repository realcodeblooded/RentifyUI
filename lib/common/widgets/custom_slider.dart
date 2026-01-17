import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;

  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.black,
        inactiveTrackColor: Colors.grey[200],
        thumbColor: Colors.white,
        overlayColor: Colors.black.withOpacity(0.12),
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 10,
          elevation: 2,
          pressedElevation: 4,
        ),
        trackHeight: 6,
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
      ),
    );
  }
}
