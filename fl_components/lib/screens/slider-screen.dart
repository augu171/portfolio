import 'package:fl_components/themes/app-themes.dart';
import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  double _sliderValue = 100;
  bool _sliderEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Slider and checks'),
        ),
        body: Column(
          children: [
            Slider.adaptive(
              min: 50,
              max: 400,
              // divisions: 10,
              activeColor: AppTheme.primary,
              value: _sliderValue,
              onChanged: _sliderEnabled
                  ? (value) {
                      _sliderValue = value;
                      setState(() {});
                    }
                  : null,
            ),
            // Checkbox(
            //   activeColor: AppTheme.primary,
            //   value: _sliderEnabled,
            //   onChanged: (value) {
            //     _sliderEnabled = value ?? true;
            //     setState(() {});
            //   },
            // ),
            // Switch(
            //   value: _sliderEnabled,
            //   onChanged: (value) {
            //     _sliderEnabled = value;
            //     setState(() {});
            //   },
            // ),
            // CheckboxListTile(
            //   activeColor: AppTheme.primary,
            //   title: const Text('CheckBox'),
            //   value: _sliderEnabled,
            //   onChanged: (value) {
            //     setState(() {
            //       _sliderEnabled = value ?? true;
            //     });
            //   },
            // ),
            SwitchListTile.adaptive(
              activeColor: AppTheme.primary,
              title: const Text('CheckBox'),
              value: _sliderEnabled,
              onChanged: (value) {
                setState(() {
                  _sliderEnabled = value;
                });
              },
            ),
            const AboutListTile(),
            Expanded(
              child: SingleChildScrollView(
                child: Image(
                  image: const NetworkImage(
                      'https://www.pngplay.com/wp-content/uploads/12/User-Avatar-Profile-Transparent-Background.png'),
                  fit: BoxFit.contain,
                  width: _sliderValue,
                ),
              ),
            ),
            const SizedBox(height: 100)
          ],
        ));
  }
}
