import 'package:flutter/material.dart';
import 'package:inputs/pages/check_box_page.dart';
import 'package:inputs/pages/keyboard_types_page.dart';
import 'package:inputs/pages/radio_button_page.dart';
import 'package:inputs/pages/slider_page.dart';
import 'package:inputs/pages/text_field_page.dart';


import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes{
  return {
    Routes.textField: (_)=> const TextFieldPage(),
    Routes.keyboardTypes: (_)=> const KeyboardTypesPage(),
    Routes.checkBox: (_)=> const CheckBoxPage(),
    Routes.radio: (_)=> const RadioButtonPage(),
    Routes.slider: (_)=> const SliderPage(),
    
  };
}