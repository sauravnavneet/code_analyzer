import 'package:performance_demo/model/metrics_model.dart';

class Evaluation {
  final Stopwatch watch1 = Stopwatch();
  final List<Metrics> metrics = [];

  Future<void> evaluatePerformance() async {
    watch1.start();
    await _computationTask();
    watch1.stop();
    metrics.add(Metrics('Compute Time', watch1.elapsed.inMilliseconds));
    final memoryUsage = await _getMemoryUsed();
    metrics.add(
      Metrics('Memory Usage', memoryUsage, 'mb'),
    );
    watch1.reset();
  }

  Future<int> _computationTask() async {
    int result = 0;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    for (int i = 0; i < 1000; i++) {
      result += i;
    }
    return result;
  }

  Future<int> _getMemoryUsed() async {
    return 10224;
  }

  String getActions(Metrics metric) {
    switch (metric.name) {
      case 'Startup Time':
        return metric.value > 2000 ? 'Optimization needed' : 'Good';
      case 'Compute Time':
        return metric.value > 1000 ? 'Optimization needed' : 'Good';
      case 'Memory Usage':
        return metric.value > 10000 ? 'Optimization needed' : 'Good';
      default:
        return '';
    }
  }
}
