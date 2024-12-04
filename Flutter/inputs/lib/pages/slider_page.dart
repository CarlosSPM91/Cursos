import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _value = 0;
  double _value2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SliderTheme(
                data: const SliderThemeData(
                  trackHeight: 4
                ),
                child: Slider(
                    value: _value,
                    min: 0,
                    max: 100,
                    label: _value.toString(),
                    divisions: 100,
                    onChanged: (value) {
                      setState(() {
                        _value = value.floorToDouble();
                      });
                    }),
              ),
              Row(
                children: [
                  const SizedBox(width: 30,),
                  SizedBox(
                    height: 300,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Slider(
                          value: _value2,
                          min: 0,
                          max: 100,
                          label: _value2.toString(),
                          divisions: 20,
                          onChanged: (value) {
                            setState(() {
                              _value2 = value.floorToDouble();
                            });
                          }),
                    ),
                  ),
                  const Text("data")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
