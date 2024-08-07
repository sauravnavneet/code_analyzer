import 'package:flutter/material.dart';
import 'package:performance_demo/pages/highlights.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const Highlights(),
              ),
            );
          },
          child: const Text(
            'See Performance Report',
          ),
        ),
      ),
    );
  }
}
