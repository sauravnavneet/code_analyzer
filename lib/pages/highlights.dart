import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:performance_demo/evaluate/frames.dart';
import 'package:performance_demo/model/metrics_model.dart';
import '../evaluate/evaluation.dart';

class Highlights extends StatefulWidget {
  const Highlights({super.key});

  @override
  State<Highlights> createState() => _HighlightsState();
}

class _HighlightsState extends State<Highlights> {
  final Evaluation evaluation = Evaluation();
  final Stopwatch _watch2 = Stopwatch();
  int startUpTime = 0;

  @override
  void initState() {
    super.initState();
    _watch2.start();
    evaluateMetrics();
    startFrameCount();
    startUpTime = _watch2.elapsed.inMilliseconds;
    updateStartupTime(startUpTime);
    _watch2.stop();
  }

  Future<void> evaluateMetrics() async {
    await evaluation.evaluatePerformance();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> updateStartupTime(int time) async {
    evaluation.metrics.add(Metrics('Startup Time', time));
  }

  void startFrameCount() {
    FramesPerSec().startFrameCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Metrics:'),
            ...evaluation.metrics.map(
              (metric) => ListTile(
                title: Text(metric.name),
                subtitle: Text(metric.name == 'Startup Time'
                    ? '$startUpTime ms'
                    : '${metric.value} ${metric.unit}'),
                trailing: Text(evaluation.getActions(metric)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
