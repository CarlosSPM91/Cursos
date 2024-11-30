import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyScaffold extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: const [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: TextField(),
                ),
              ),
            ),
            Text("keakfeakfkeak"),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      // resizeToAvoidBottomInset: false, //no cambian las dimensiones cuando sale el teclado
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.accessibility_new,
            size: 34,
          ),
          onPressed: () {
            print("=)");
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "person"),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // drawerEdgeDragWidth: 100,
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,

      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0, //sombra de la appBar
        // shadowColor: Colors.amber,
        backgroundColor: const Color(0xff00BFA5),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Flutter "),
            Text(
              "home",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
