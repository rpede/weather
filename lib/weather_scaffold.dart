import 'package:flutter/material.dart';

import 'hourly_forecast_screen.dart';
import 'weekly_forecast_screen.dart';

class NavDestination {
  const NavDestination(this.label, this.icon, this.selectedIcon, this.builder);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final Widget Function() builder;
}

const destinations = [
  NavDestination(
    'Weekly',
    Icon(Icons.calendar_view_week_outlined),
    Icon(Icons.calendar_view_week),
    WeeklyForecastScreen.new,
  ),
  NavDestination(
    'Temp',
    Icon(Icons.thermostat_outlined),
    Icon(Icons.thermostat),
    HourlyForecastScreen.new,
  ),
];

class WeatherScaffold extends StatefulWidget {
  const WeatherScaffold({super.key});

  @override
  State<WeatherScaffold> createState() => _WeatherScaffoldState();
}

class _WeatherScaffoldState extends State<WeatherScaffold> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: destinations[screenIndex].builder(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
        destinations: destinations.map(
          (NavDestination destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              tooltip: destination.label,
            );
          },
        ).toList(),
      ),
    );
  }
}
