import 'dart:math';

import 'package:flutter/scheduler.dart';

class FramesPerSec {
  final Stopwatch _stopwatch = Stopwatch();
  int frames = 0;

  void startFrameCount() {
    int frames = 0;
    _stopwatch.start();
    int duration = Random().nextInt(30) + 10;

    while (_stopwatch.elapsedMilliseconds < duration) {}
    _stopwatch.reset();
    _stopwatch.stop();

    if (frames > 7) {
      frames = 0;
      return;
    }

    frames++;

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      startFrameCount();
    });
  }
}
