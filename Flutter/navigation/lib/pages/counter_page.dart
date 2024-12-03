import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
        ),
        body: const Center(
          child: Text("Counter"),
        ),
      ),
      onPopInvokedWithResult: (bool didPop, _) async {
        print(didPop);
        if (didPop){
          return;
        }
      } ,
    );
  }
}
