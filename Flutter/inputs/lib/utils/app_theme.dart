import 'package:flutter/material.dart';
import 'package:inputs/utils/material_color_generator.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: generateMaterialColor(const Color(0xff00c853)),
    colorScheme: ColorScheme.light(
      primary: Colors.red,
      
    ),
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
    useMaterial3: false,
  );
}
