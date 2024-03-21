import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherSliverAppBar extends StatelessWidget {
  final AsyncCallback? onRefresh;

  const WeatherSliverAppBar({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.green[900];
    return SliverAppBar(
      pinned: true,
      stretch: true,
      onStretchTrigger: onRefresh,
      backgroundColor: color,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        title: const Text('Weather'),
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: <Color>[color!, Colors.transparent],
            ),
          ),
          child: Image.asset(
            "assets/background.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
