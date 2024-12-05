import 'package:flutter/material.dart';
import 'package:inputs/utils/material_color_generator.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: generateMaterialColor(const Color(0xff00c853)),
    colorScheme: ColorScheme.light(
      primary: Colors.red,
    ),
    useMaterial3: false,
    hintColor: Colors.blue,
    inputDecorationTheme: InputDecorationTheme(
      // floatingLabelStyle: TextStyle(color: Colors.amber),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.amber,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      disabledBorder: const UnderlineInputBorder(),
    ),
    checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(Colors.red),
        fillColor: WidgetStateProperty.all(Colors.amber),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        overlayColor: WidgetStateProperty.all(Colors.pink)),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(Colors.pinkAccent),
      visualDensity: VisualDensity.compact,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.pinkAccent),
      trackColor: WidgetStateProperty.all(Colors.lightBlueAccent),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.amber,
      thumbColor: Colors.yellow,
      overlayColor: Colors.lightBlueAccent.withOpacity(0.3),
      valueIndicatorColor: Colors.green,
      inactiveTickMarkColor: Colors.blue,
      trackHeight: 20,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
    ),
  );
}
