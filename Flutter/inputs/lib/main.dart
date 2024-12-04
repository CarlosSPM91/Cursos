import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inputs/app_routes.dart';
import 'package:inputs/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // final focus = FocusScope.of(context);
        // final focusedClhild = focus.focusedChild;
        // if (focusedClhild != null && !focusedClhild.hasPrimaryFocus) focusedClhild.unfocus();
        SystemChannels.textInput.invokeMethod("TextInput.hide");
      },
      child: MaterialApp(
        title: 'Inputs Demo',
        theme: getThemeData(context),
        // theme: ThemeData(
        //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        //   // primarySwatch: generateMaterialColor(Colors.amber), //Se necesita desactivar useMaterial3
        //   colorSchemeSeed: generateMaterialColor(Colors.brown),
        //   // appBarTheme: const AppBarTheme(elevation: 1, shadowColor: Colors.grey, ),
        //   useMaterial3: false,
        // ),
        home: const HomePage(),
        routes: appRoutes,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = appRoutes.keys.toList();
    return Scaffold(
      body: ListView.builder(
        itemCount: keys.length,
        itemBuilder: (_, index) {
          final routeName = keys[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, routeName);
            },
            title: Text(routeName),
          );
        },
      ),
    );
  }
}
