import 'package:flutter/material.dart';
import 'package:pulse_widget/pulse_widget.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ButtonState state = ButtonState.pulse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Pulse(
            shouldShowPulse: (state != ButtonState.hidePulse),
            colour: Colors.blue,
            isSinglePulse: (state == ButtonState.pulseOnce),
            maxDiameter: (state == ButtonState.bigPulse) ? 500 : 250,
            delay: const Duration(milliseconds: 100), // delay inbetween pulses
            child: GestureDetector(
              onTap: () {
                setState(() {
                  switch (state) {
                    // update button state
                    case ButtonState.pulse:
                      state = ButtonState.pulseOnce;
                      break;
                    case ButtonState.pulseOnce:
                      state = ButtonState.bigPulse;
                      break;
                    case ButtonState.bigPulse:
                      state = ButtonState.hidePulse;
                      break;
                    case ButtonState.hidePulse:
                      state = ButtonState.pulse;
                  }
                });
              },
              child: Button(
                name: state.toString(),
              ),
            )),
      ),
    );
  }
}

enum ButtonState {
  pulse,
  pulseOnce,
  bigPulse,
  hidePulse,
}

// widget to display current state
class Button extends StatelessWidget {
  final String name;
  const Button({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ));
  }
}
