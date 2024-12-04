import 'package:flutter/material.dart';
import 'package:inputs/pages/keyboard_types_page.dart';
import 'package:inputs/pages/text_field_page.dart';


import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes{
  return {
    Routes.textField: (_)=> const TextFieldPage(),
    Routes.keyboardTypes: (_)=> const KeyboardTypesPage(),
    
  };
}