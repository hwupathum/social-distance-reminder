import 'package:flutter/material.dart';

class DiscoverView extends StatelessWidget {
  final int counter;
  const DiscoverView({Key? key, required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$counter',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
