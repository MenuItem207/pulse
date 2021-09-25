library pulse;

import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { width, colorOpacity }

// widget for pulse
class Pulse extends StatefulWidget {
  final bool shouldShowPulse;
  final Widget child;
  final Duration duration; // duration of pulse
  final Duration delay; // duration in between pulses
  final double maxDiameter; // set diameter of pulse
  final Color colour; // set colour of pulse
  final bool isSinglePulse; // set to true to only pulse once
  const Pulse({
    Key? key,
    required this.shouldShowPulse,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.delay = const Duration(milliseconds: 250),
    this.maxDiameter = 100,
    this.colour = Colors.blue,
    this.isSinglePulse = false,
  }) : super(key: key);

  @override
  State<Pulse> createState() => _PulseState();
}

class _PulseState extends State<Pulse> {
  final tween = MultiTween<AniProps>()
    ..add(AniProps.width, (0.0).tweenTo(1.0))
    ..add(AniProps.colorOpacity, (0.15).tweenTo(0.0));

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        (widget.shouldShowPulse)
            ? CustomAnimation<MultiTweenValues<AniProps>>(
                control: CustomAnimationControl.playFromStart,
                animationStatusListener: (AnimationStatus status) async {
                  if (status == AnimationStatus.completed &&
                      !widget.isSinglePulse) {
                    await Future.delayed(widget.delay);
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                curve: Curves.decelerate,
                tween: tween,
                duration: widget.duration,
                builder: (context, child, value) {
                  return Transform.scale(
                    scale: value.get(AniProps.width),
                    child: Container(
                      height: widget.maxDiameter,
                      width: widget.maxDiameter,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.colour
                              .withOpacity(value.get(AniProps.colorOpacity))),
                    ),
                  );
                },
              )
            : const SizedBox(),
        widget.child
      ],
    );
  }
}
